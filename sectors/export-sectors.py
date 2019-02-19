
import sys, os, psycopg2, csv


EXCLUDE_IDS={17,121,500,501} # ITIS regional, CoL China, CoL Management, IRMNG
THRESHOLD=0.8

con = psycopg2.connect(host='localhost', dbname='colplus', user='postgres')
con.autocommit = True
dbc = con.cursor()




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
CHILDREN = "SELECT id, parent_id, dataset_id, rank, name, authorship, species, datasets " \
           "FROM _names WHERE parent_id "



def updateCounts():
    print("Count species")
    #dbc.execute(UPDATE_SPECIES_COUNTS)
    for rank in ["subgenus", "genus", "family", "superfamily", "order", "class", "phylum", "kingdom"]:
        print("Count %s" % rank)
        dbc.execute(UPDATE_COUNTS % (rank, rank))


def processTaxon(p, out):
    print("Process %s %s: species=%s, datasets=%s" % (p[3], p[4], p[6], p[7]))
    if (p[7]):
        id = p[0]
        did = p[2]
        cnt = p[6]    
        dids = set(p[7]).difference(EXCLUDE_IDS)
        if len(dids) == 1:
            print("Sector %s %s found with %s species for dataset %s" % (p[3], p[4], cnt, did))
            out.writerow(p)
        elif len(dids) > 1:
            # recursivelly go deeper
            dbc.execute(CHILDREN + ("='%s'" % id))
            children = dbc.fetchall();
            for c in children:
                processTaxon(c, out)

def walkRoot(out):
    dbc.execute(CHILDREN + "IS NULL")
    roots = dbc.fetchall();
    for r in roots:
        print("\n\n*** KINGDOM ***")
        processTaxon(r, out)



if __name__ == "__main__":
    #updateCounts();
    with open('sectors.csv', 'w', newline='') as csvfile:
        out = csv.writer(csvfile, delimiter='\t', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        walkRoot(out)
    dbc.close()

