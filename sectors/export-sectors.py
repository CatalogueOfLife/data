
import sys, os, csv, collections
import psycopg2, psycopg2.extras

REGIONAL_IDS ={17,121,500,501} # ITIS regional, CoL China, CoL Management, IRMNG
MANAGED_IDS  ={141,204,163} # we manage sectors for these datasets manually
THRESHOLD=0.85



con = psycopg2.connect(host='localhost', dbname='cpsectors', user='postgres')
con.autocommit = True
cur = con.cursor(cursor_factory = psycopg2.extras.NamedTupleCursor)

UPDATE_SPECIES_COUNTS = """UPDATE _names SET species=1, datasets=array[dataset_id] WHERE rank='species'"""
UPDATE_COUNTS = """WITH childs AS (
    SELECT n.id AS cid, sum(c.species) AS species, uniq(sort(array_cat_agg(distinct c.datasets))) AS dids
    FROM _names n JOIN _names c ON c.parent_id=n.id
    WHERE n.rank='%s'
    GROUP BY n.id
)
UPDATE _names n SET species=c.species, datasets=c.dids
    FROM childs c
    WHERE c.cid=n.id AND n.rank='%s';
"""
CHILDREN = "SELECT id, dataset_id AS did, rank, name, authorship, species AS cnt, datasets AS dids" \
           " FROM _names WHERE rank != 'species' AND parent_id "

Source = collections.namedtuple('Source', 'did rank name cnt', defaults=(None, '', '', 0))





def writeSector(did, t, p, parentDatasetIds):
    if (t.name != "Not assigned" and did not in parentDatasetIds and did not in MANAGED_IDS):
        print("Sector %s %s found with %s species for dataset %s" % (t.rank, t.name, t.cnt, did))
        # datasetID, rank, name, parentRank, parentName
        if p:
            out.write("(%s, '%s', '%s', '%s', '%s'),\n" % (did+1000, t.rank, t.name, p.rank, p.name))
        else:
            out.write("(%s, '%s', '%s', NULL, NULL),\n" % (did+1000, t.rank, t.name))


def updateCounts():
    print("Count species")
    cur.execute(UPDATE_SPECIES_COUNTS)
    for rank in ["subgenus", "genus", "family", "superfamily", "order", "class", "phylum", "kingdom"]:
        print("Count %s" % rank)
        cur.execute(UPDATE_COUNTS % (rank, rank))


def processTaxon(p, t, out, parentDatasetIds):
    if (t.dids):
        dids = set(t.dids).difference(REGIONAL_IDS)
        print("  process %s %s: species=%s, datasets=%s" % (t.rank, t.name, t.cnt, dids))
        if len(dids) == 1:
            writeSector(dids.pop(), t, p, parentDatasetIds)
        elif len(dids) > 1 and t.rank != 'genus':
            cur.execute(CHILDREN + ("='%s'" % t.id))
            children = cur.fetchall()
            if children:
                maj = findMajorSource(t.cnt, children)
                # allow a threshold match on (super)family level
                if maj and t.rank in ('order','family','superfamily'):
                    print("  major sector %s %s found with %s out of %s species for dataset %s" % (t.rank, t.name, maj.cnt, t.cnt, maj.did))
                    writeSector(maj.did, t, p, parentDatasetIds)
                    # recursively go deeper, but remember we have reported a sector already
                    for c in children:
                        processTaxon(t, c, out, parentDatasetIds+(maj.did,))
                else:
                    # recursively go deeper
                    for c in children:
                        processTaxon(t, c, out, parentDatasetIds)


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
            return Source(did=did, cnt=cnts[did])
    return None


def walkRoot(out):
    cur.execute(CHILDREN + "IS NULL")
    roots = cur.fetchall()
    for r in roots:
        print("\n\n*** KINGDOM ***")
        processTaxon(None, r, out, tuple([]))




if __name__ == "__main__":
    updateCounts();
    with open('sectors.sql', 'w', newline='') as out:
        walkRoot(out)
    cur.close()

