
import sys, os, csv, collections
import psycopg2, psycopg2.extras

REGIONAL_IDS ={17,75,121,500,501} # ITIS regional, NZOR, CoL China, CoL Management, IRMNG
MANAGED_IDS  ={141,204,163}    # we manage sectors for these datasets manually
THRESHOLD=0.75



con = psycopg2.connect(host='localhost', dbname='colh', user='postgres')
con.autocommit = True
cur = con.cursor(cursor_factory = psycopg2.extras.NamedTupleCursor)

UPDATE_SPECIES_COUNTS = """UPDATE names SET species=1, datasets=array[dataset_id] WHERE rank='species'"""
UPDATE_COUNTS = """WITH childs AS (
    SELECT n.id AS cid, sum(c.species) AS species, uniq(sort(array_cat_agg(distinct c.datasets))) AS dids
    FROM names n JOIN names c ON c.parent_id=n.id
    WHERE n.rank='%s'
    GROUP BY n.id
)
UPDATE names n SET species=c.species, datasets=c.dids
    FROM childs c
    WHERE c.cid=n.id AND n.rank='%s';
"""
CHILDREN = "SELECT id, dataset_id AS did, rank, name, authorship, species AS cnt, datasets AS dids" \
           " FROM names WHERE rank != 'species' AND parent_id "

Source = collections.namedtuple('Source', 'id did rank name cnt')

sectorKey = 0


def writeSector(did, t, p, parentDatasetIds, sKey):
    global sectorKey
    if (did not in parentDatasetIds and did not in MANAGED_IDS):
        sectorKey += 1
        print("Sector %s %s %s found with %s species for dataset %s" % (sectorKey, t.rank, t.name, t.cnt, did))
        # sectorKey, datasetID, rank, name, targetRank, targetName, targetID
        prank = p.rank if p else ''
        pname = p.name if p else ''
        pid   = p.id   if p else ''
        # MODE: 0=ATTACH, 1=MERGE
        sout.write("%s,%s,%s,%s,%s,%s,%s,%s\n" % (sectorKey, did+1000, 0 if p else 1, t.rank, t.name, prank, pname, pid))
        return sectorKey
    return sKey


def writeTaxon(p, t, sKey):
    nout.write("%s,%s,%s,%s,%s\n" % (t.id, t.id, t.rank, t.name, t.name))
    tout.write("%s,%s,%s,%s\n" % (t.id, t.id, p.id if p else '', sKey or ''))

def writeCsvHeader():
    sout.write("key,dataset_key,mode,subject_rank,subject_name,target_rank,target_name,target_id\n")
    nout.write("id,homotypic_name_id,rank,scientific_name,uninomial\n")
    tout.write("id,name_id,parent_id,sector_key\n")

def updateCounts():
    print("Count species")
    cur.execute(UPDATE_SPECIES_COUNTS)
    for rank in ["subgenus", "genus", "family", "superfamily", "order", "class", "phylum", "kingdom"]:
        print("Count %s" % rank)
        cur.execute(UPDATE_COUNTS % (rank, rank))


def processTaxon(p, t, parentDatasetIds, sKey):
    print("  process %s %s: sector=%s, species=%s, datasets=%s" % (t.rank, t.name, sKey, t.cnt, t.dids))
    # load children only for ranks above genera
    children=[]
    if t.rank != 'genus':
        cur.execute(CHILDREN + ("='%s'" % t.id))
        children = cur.fetchall()
    # skip not assigned taxa, but dive into their children keeping the current parent
    if (" assigned" in t.name.lower() or 'unassigned' in t.name.lower()):
        print("  skip")
        t = p
    else:        
        if (t.dids):
            dids = set(t.dids).difference(REGIONAL_IDS)
            if len(dids) == 1:
                did = dids.pop()
                sKey = writeSector(did, t, p, parentDatasetIds, sKey)
                parentDatasetIds = parentDatasetIds+(did,)
            elif len(dids) > 1 and t.rank in ('order','family','superfamily') and children:
                # allow a threshold match on (super)family level
                maj = findMajorSource(t.cnt, children)
                if maj:
                    print("  major sector %s %s found with %s out of %s species for dataset %s" % (t.rank, t.name, maj.cnt, t.cnt, maj.did))
                    sKey = writeSector(maj.did, t, p, parentDatasetIds, sKey)
                    parentDatasetIds = parentDatasetIds+(maj.did,)
        writeTaxon(p, t, sKey)
    # recursively go deeper
    for c in children:
        processTaxon(t, c, parentDatasetIds, sKey)


def findMajorSource(total, children):
    cnts={}
    for c in children:
        if c.dids:
            dids = set(c.dids).difference(REGIONAL_IDS)
            if len(dids) == 1:
                did = dids.pop()
                cnts[did] = cnts.get(did, 0) + c.cnt
    print("  calc major: %s" % cnts)
    for did in cnts:
        if cnts[did] >= total*THRESHOLD:
            return Source(id=None, did=did, rank='', name='', cnt=cnts[did])
    return None


def walkRoot():
    cur.execute(CHILDREN + "IS NULL")
    roots = cur.fetchall()
    for r in roots:
        print("\n\n*** KINGDOM ***")
        processTaxon(None, r, tuple([]), None)




if __name__ == "__main__":
    updateCounts();
    with open('sector.csv', 'w', newline='') as sout:
        with open('name.csv', 'w', newline='') as nout:
            with open('taxon.csv', 'w', newline='') as tout:
                writeCsvHeader()
                walkRoot()
    cur.close()

