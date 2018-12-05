-- origin:  0=EXTERNAL, 1=UPLOADED, 2=MANAGED
INSERT INTO dataset (key, origin, type, contributes_to, title, import_frequency, created_by, modified_by, data_format, data_access) 
VALUES ('1000', 0, 1, 0, 'CoL Management Classification', 1, 0, 0, 0, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/higher-classification.dwca.zip');

INSERT INTO dataset (key, origin, type, contributes_to, title, import_frequency, created_by, modified_by, data_format, data_access) 
SELECT x.id+1000, 0, 1, 0, 'GSD ' || x.id, 1, 0, 0, 1, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/' || x.id || '.tar.gz'
FROM (SELECT unnest(array[
10,
100,
101,
103,
104,
105,
106,
107,
108,
109,
11,
110,
112,
113,
115,
118,
119,
12,
120,
121,
122,
123,
124,
125,
126,
127,
128,
129,
130,
131,
132,
133,
134,
138,
139,
14,
142,
143,
144,
146,
148,
149,
15,
150,
152,
153,
154,
157,
158,
161,
162,
163,
164,
166,
167,
168,
169,
17,
170,
171,
172,
173,
174,
175,
176,
177,
178,
179,
18,
180,
181,
182,
183,
184,
185,
186,
188,
189,
19,
190,
191,
192,
193,
194,
195,
196,
197,
198,
199,
20,
200,
201,
21,
22,
23,
24,
25,
26,
28,
29,
30,
31,
32,
33,
34,
36,
37,
38,
39,
40,
42,
44,
45,
46,
47,
48,
49,
5,
50,
500,
501,
502,
51,
52,
53,
54,
57,
58,
59,
6,
61,
62,
63,
65,
66,
67,
68,
69,
7,
70,
73,
74,
75,
76,
78,
79,
8,
80,
81,
82,
85,
86,
87,
88,
89,
9,
90,
91,
92,
93,
94,
95,
96,
97,
98,
99
]) AS id) AS x;


-- regional ACEF dataset: NZIB, COL-CHINA, ITIS-regional
UPDATE dataset SET type=2 WHERE key IN (
	1121, 1075, 1017
);

-- other ACEF dataset: common names
UPDATE dataset SET type=4 WHERE key IN (
	1007
);

UPDATE dataset SET code=1 WHERE key IN (
	1015,1025,1036,1038,1040,1045,1048,1066,1097,1098,1163
);
UPDATE dataset SET code=3 WHERE key IN (
	1014
);
UPDATE dataset SET code=4 WHERE key IN (
	1005,1006,1008,1009,1010,1011,1018,1020,1021,1022,1023,1026,1029,1030,1031,1032,1034,1037,1039,1042,1044,
	1046,1047,1049,1050,1051,1052,1054,1057,1058,1059,1061,1062,1063,1065,1067,1068,1069,1070,1076,1078,
	1080,1081,1082,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1099,1100,1103,1104,1105,1106,
	1107,1108,1109,1110,1112,1118,1119,1120,1122,1130,1133,1134
);

-- removed, old sources which we mark as deleted
INSERT INTO dataset (key, origin, title, created_by, modified_by, deleted) VALUES 
	('1016', 0, 'IOPI-GPC', 0, 0, now()),
	('1041', 0, 'Systematic Myriapod Database', 0, 0, now()),
	('1043', 0, 'lecypages', 0, 0, now()),
	('1056', 0, 'lhd', 0, 0, now()),
	('1060', 0, 'worms_proseriata-kalyptorhynchia', 0, 0, now()),
	('1064', 0, 'solanaceae_source', 0, 0, now()),
	('1117', 0, 'chenobase', 0, 0, now()),
	('1135', 0, 'fada_turbellaria', 0, 0, now()),
	('1159', 0, 'fada_copepoda', 0, 0, now()),
	('1165', 0, 'faeu_turbellaria', 0, 0, now());

ALTER SEQUENCE dataset_key_seq RESTART WITH 2000;




INSERT INTO col_source (key, dataset_key, alias, created_by, modified_by) 
SELECT key, key, key::text, created_by, modified_by FROM dataset 
WHERE data_format=1 AND key < 2000;

ALTER SEQUENCE col_source_key_seq RESTART WITH 2000;
