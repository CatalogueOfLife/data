
import sys, os, csv, collections
import psycopg2, psycopg2.extras


con = psycopg2.connect(host='localhost', dbname='colh', user='postgres')
con.autocommit = True
cur = con.cursor(cursor_factory = psycopg2.extras.NamedTupleCursor)


CHILDREN = "SELECT id, major_dataset AS did, rank, name FROM names WHERE parent_id "

Source = collections.namedtuple('Source', 'id did rank name')

BIOTA  = Source(id=0, did=None, rank='unranked', name='Biota')

sectorKey = 0


def writeSector(t, p):
    global sectorKey
    sectorKey += 1
    print("  Sector %s %s %s found for dataset %s" % (sectorKey, t.rank, t.name, t.did))
    # sectorKey, datasetID, rank, name, targetRank, targetName
    sout.write("%s,%s,%s,%s,%s,%s\n" % (sectorKey, t.did+1000, t.rank, t.name, p.rank, p.name))
    return sectorKey

def writeCsvHeader():
    sout.write("key,dataset_key,subject_rank,subject_name,target_rank,target_name\n")

def processTaxon(t, p, sdid, sKey):
    print("process %s %s: sector=%s, dataset=%s" % (t.rank, t.name, sKey, sdid))
    # load children only for ranks above genera
    children=[]
    if t.rank != 'genus':
        cur.execute(CHILDREN + ("='%s'" % t.id))
        children = cur.fetchall()
    # skip not assigned taxa, but dive into their children keeping the current parent
    if (" assigned" in t.name.lower() or 'unassigned' in t.name.lower()):
        print("  skip")
        t=p
    else:
        if (t.did and t.did != sdid):
            sdid = t.did
            sKey = writeSector(t, p)
    # recursively go deeper
    for c in children:
        processTaxon(c, t, sdid, sKey)



def walkRoot():
    cur.execute(CHILDREN + "IS NULL")
    roots = cur.fetchall()
    for r in roots:
        print("\n\n*** KINGDOM ***")
        processTaxon(r, BIOTA, None, None)




if __name__ == "__main__":
    with open('sector.csv', 'w', newline='') as sout:
        writeCsvHeader()
        walkRoot()
    cur.close()

