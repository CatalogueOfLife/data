#!/usr/bin/env python

import sys, os, MySQL.db


EXCLUDE_IDS=[501]
THRESHOLD=0.8

mydb = MySQLdb.connect(host='localhost',user='root',passwd='')
dbc = mydb.cursor()
mydb.set_character_set('utf8')
dbc.execute('SET NAMES utf8')
dbc.execute('SET CHARACTER SET utf8')
dbc.execute('SET character_set_connection=utf8')
dbc.execute('USE ac_latest')


query = "SELECT source_database_id AS database_id, TT.rank, taxon_id AS id, TT.parent_id, name, original_id AS name_code, total_species " \
		"FROM _taxon_tree TT INNER JOIN taxon TAX ON TT.taxon_id = TAX.ID WHERE parent_id="


def processTaxon(parent):
	print id
	id = row[2]
	did = row[0]
	if did and did not in EXCLUDE_IDS:
		print "DB found: "+did
	else:
		# recursivelly go deeper
		children = dbc.execute(query+id).fetchall();
		#for c in children:
			#processTaxon(c)


def walkRoot():
	roots = dbc.execute(query+"0").fetchall();
	for r in roots:
		processTaxon(r)


