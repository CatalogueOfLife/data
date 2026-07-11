# COL eXtended Release historic ChangeLog

We document here all major editorial changes for each weekly [COL XRelease](https://www.checklistbank.org/dataset?limit=50&offset=0&origin=xrelease&releasedFrom=3&reverse=false). 
Each entry is headed by the dataset version date (`YYYY-MM-DD`), followed when known by links to the ChecklistBank dataset, the release attempt log, and the DOI.

For an automatically generated changelog that offers change metrics please see https://www.catalogueoflife.org/data/changelog
### 2026-07-10
- Inclusion of specific Plazi dataset as sector to fill gap in family Chrysididae: Hymenoptera (Dataset 313716). Ranks included: subfamilies, tribes, genus, species and subspecies)
### 2026-06-12
- NCBI sector removed (scientific names in Bacteria): unsuccessfull test, the mayority of the names merged were informal or not validly published names (according to LPSN).
- Sources removed: [2032](https://www.checklistbank.org/dataset/2032/metadata) and [55472](https://www.checklistbank.org/dataset/55472/metadata): no information was merged from them. 
### 2026-05-22
- Sector added from NCBI, just Bacteria, scientific names. Test: Candidatus, unidentified and uncultured names should not be included. 
- Editorial decisions: blocked names in UKSI and IRMNG
- Pycnopodiidae was blocked as it's current status is unclear. It's currently accepted as a subfamily in WoRMS, but with the same LSID that Pynopodiidae had. https://github.com/CatalogueOfLife/data/issues/1584
- Dataset 26425 was blocked because it had completely erroneous information.
  
### 2026-05-15
- The Reptile Database with literature sector  (dataset #223917) was removed from project as it was including just 1 reference for one duplicated name)
  
### 2026-05-15
- Mollusca was blocked from WoRMS (dataset 2011) - comment on day 2026-05-15 [issue 1500](https://github.com/CatalogueOfLife/data/issues/1500) due to contradictions with MolluscaBase

### 2026-04-24
[CLB 315026](https://www.checklistbank.org/dataset/315026/about), [#576](https://download.checklistbank.org/releases/3/576/)

- sector from iNat added for Braconidae (fill gap on subfamilies and genus) [issue 1555](https://github.com/CatalogueOfLife/data/issues/1555)

### 2026-04-18
[CLB 314965](https://www.checklistbank.org/dataset/314965/about), [#574](https://download.checklistbank.org/releases/3/574/) — published as COL26.4 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgxjw-blue?logo=doi)](https://doi.org/10.48580/dgxjw)

- Change in priority of sectors from Worms with Algae
- Change in priority of sector from GRIN: from 8 to 158
- Sector from WoRMS (dataset 2011) Plantae:Plantae deleted
- Block of names in project (duplicates) and in config file:  [issue 1545](https://github.com/CatalogueOfLife/data/issues/1545)

### 2026-02-13
[CLB 314231](https://www.checklistbank.org/dataset/314231/about), [#551](https://download.checklistbank.org/releases/3/551/) — published as COL26.2 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgwnl-blue?logo=doi)](https://doi.org/10.48580/dgwnl)

- Exclusion of datasets creating duplicates: 7136, 300094 , 22282, 2839,
- Exclusion of dataset due to erroneous classification: 309204
- Decisions in ChecklistBank to block names with duplicates in COL-China

### 2026-01-16
[CLB 313811](https://www.checklistbank.org/dataset/313811/about), [#539](https://download.checklistbank.org/releases/3/539/) — published as COL26.1 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgw64-blue?logo=doi)](https://doi.org/10.48580/dgw64)

- New source and sector included to fill gap in Tenebrionidae: https://www.checklistbank.org/dataset/313711/about
- New source and sector included to fill gap in Tenebrionidae: https://www.checklistbank.org/catalogue/3/dataset/5678/metadata
- Block genus Neogarganus from TAXREF (missplaced) , should be included from IRMNG. [issue 1410](https://github.com/CatalogueOfLife/data/issues/1410)

### 2026-01-09
[CLB 313685](https://www.checklistbank.org/dataset/313685/about), [#536](https://download.checklistbank.org/releases/3/536/)

- block of names (editorial decisions) that created duplicates
- iNat sectors for Vespoidea and Chrysididae

### 2025-11-16
[CLB 313100](https://www.checklistbank.org/dataset/313100/about), [#515](https://download.checklistbank.org/releases/3/515/) — published as COL25.11 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgvbl-blue?logo=doi)](https://doi.org/10.48580/dgvbl)

- make nomenclatural names provisional again: [issue 1319](https://github.com/CatalogueOfLife/data/issues/1319#issuecomment-3534814004)
- merge nomenclatural properties `gender` and `etymology`: [issue 1468](https://github.com/CatalogueOfLife/backend/issues/1468)
- block several Homo species from Zoobank [issue 1299](https://github.com/CatalogueOfLife/data/issues/1299), [issue 1300](https://github.com/CatalogueOfLife/data/issues/1300) , [issue 1301](https://github.com/CatalogueOfLife/data/issues/1301) , [issue 1302](https://github.com/CatalogueOfLife/data/issues/1302) , [issue 1303](https://github.com/CatalogueOfLife/data/issues/1303) , [issue 1304](https://github.com/CatalogueOfLife/data/issues/1304)
- Extinct flag on Mauisaurus [issue 1298](https://github.com/CatalogueOfLife/data/issues/1298)
- Block Scarab species from ZooBank [issue 1327](https://github.com/CatalogueOfLife/data/issues/1327)
- Block Siphonius from ITIS (misspelled) [issue 1318](https://github.com/CatalogueOfLife/data/issues/1318#issuecomment-3534566679)

### 2025-11-07
[CLB 313034](https://www.checklistbank.org/dataset/313034/about), [#510](https://download.checklistbank.org/releases/3/510/)

- Block Scarabaeoidea in IRMNG, TaxRef, ITIS, UKSI, DynTaxa, IUCN, TaiCOL.  [issue 1327](https://github.com/CatalogueOfLife/data/issues/1327)

### 2025-10-24
[CLB 312896](https://www.checklistbank.org/dataset/312896/about), [#504](https://download.checklistbank.org/releases/3/504/)

- Blocking IRMNG Names for Auchenorrhyncha Families: Cercopidae, Cicadellidae, Cixiidae, Membracidae, Issidae, Derbidae
- Remove BOLD insecta

### 2025-10-17
[CLB 312752](https://www.checklistbank.org/dataset/312752/about), [#501](https://download.checklistbank.org/releases/3/501/)

- Add Catalogue of life China that now has a cc-by license to test resuls https://www.checklistbank.org/dataset/312616/classification

### 2025-10-10
[CLB 312578](https://www.checklistbank.org/dataset/312578/about), [#500](https://download.checklistbank.org/releases/3/500/) — published as COL25.10 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgtpl-blue?logo=doi)](https://doi.org/10.48580/dgtpl)

- Block Opiliones in IRMNG, UKSI, ITIS, Plazi (42 datasets that were providing names to Opiliones), Zoobank, TaxRef, DynTaxa, NorTaxa, TaiCOL, WoRMS. [issue 1261](https://github.com/CatalogueOfLife/data/issues/1261)
- Decisions in different datasets to avoid duplicated names  [issue 1257](https://github.com/CatalogueOfLife/data/issues/1257)
- Add only BINs from the entiry BOLD dataset [issue 1262](https://github.com/CatalogueOfLife/data/issues/1262)

### 2025-10-03
- Block Plazi dataset: [issue 1254](https://github.com/CatalogueOfLife/data/issues/1254)
- Block doubful name: [issue 1250](https://github.com/CatalogueOfLife/data/issues/1250)

### 2025-09-26
[CLB 312442](https://www.checklistbank.org/dataset/312442/about), [#492](https://download.checklistbank.org/releases/3/492/)

- Add Bold insects dataset to test merging

### 2025-07-11
[CLB 311018](https://www.checklistbank.org/dataset/311018/about), [#439](https://download.checklistbank.org/releases/3/439/)

- Modification in Sector of dataset 2021 (Checklist of Beetles (Coleoptera) of Canada and Alaska) to include only family, genera, species ans subspecies.
- Add the full World Plants Catalogue to test how much additional information is added https://www.checklistbank.org/dataset/309839/classification, and defined if it should be included or not

### 2025-06-27
- Block Plazi datasets following the Auchenorrhyncha dataset
- Block Lepidoptera for DAISE sector [issue 817](https://github.com/CatalogueOfLife/data/issues/817)
- Block names from taxref identified during the Orthoptera review [issue 1046](https://github.com/CatalogueOfLife/data/issues/1046)

### 2025-06-20
- Inclusion of sector UKSI Ichneumonoidea (priority 98) including subfamilies and tribes to prevent misplacing of genus under Diptera. see [issue 1004](https://github.com/CatalogueOfLife/data/issues/1004)
- Block Plazi datasets following the Orthoptera review

### 2025-06-13
[CLB 310492](https://www.checklistbank.org/dataset/310492/about), [#430](https://download.checklistbank.org/releases/3/430/)

- Fixed subject of IUCN Animalia for some reason it was pointing to a lower taxa
- Block Plazi datasets following the Orthoptera review

### 2025-06-06
[CLB 310311](https://www.checklistbank.org/dataset/310311/about), [#424](https://download.checklistbank.org/releases/3/424/)

- Publisher added as Plazi Journals have become independed on the GBIF registry
    - [07fa07e6-9d4f-4b82-99fb-1a2055991233](https://www.gbif.org/publisher/07fa07e6-9d4f-4b82-99fb-1a2055991233): AINV # pensoft African Invertebrates
    - [7597e7d3-b8d6-4ecf-84a3-d731d8b6d290](https://www.gbif.org/publisher/7597e7d3-b8d6-4ecf-84a3-d731d8b6d290): ESYS # pensoft Evolutionary Systematics
    - [43999f3b-3220-490b-83f4-954cd43c3f6c](https://www.gbif.org/publisher/43999f3b-3220-490b-83f4-954cd43c3f6c): VZOO # pensoft Vertebrate Zoology
    - [3996dc51-9cce-445b-a06f-7aba727bb0d8](https://www.gbif.org/publisher/3996dc51-9cce-445b-a06f-7aba727bb0d8): HERP # pensoft Herpetozoa
    - [d9a8e26f-f479-45f2-9bf3-144c25965646](https://www.gbif.org/publisher/d9a8e26f-f479-45f2-9bf3-144c25965646): FREC # pensoft FR Fossil Record
    - [5aaf6f62-72a5-403f-8fae-e8f9cd4a18cd](https://www.gbif.org/publisher/5aaf6f62-72a5-403f-8fae-e8f9cd4a18cd): CENT # pensoft Contributions to Entomology
    - [9eb1b78c-2c2b-431e-8fd7-492734770611](https://www.gbif.org/publisher/9eb1b78c-2c2b-431e-8fd7-492734770611): ASP # pensoft Arthropod Systematics & Phylogeny
    - [a019af3a-3982-4c10-9a27-2a793d40ed97](https://www.gbif.org/publisher/a019af3a-3982-4c10-9a27-2a793d40ed97): CAUC # pensoft Caucasiana
    - [af62a723-bd15-484a-995e-6fc6720c54f0](https://www.gbif.org/publisher/af62a723-bd15-484a-995e-6fc6720c54f0): AIEP # pensoft AIEP Acta Ichthyologica et Piscatoria
    - [ac084e47-e95d-4e30-ab94-115d4dec59b2](https://www.gbif.org/publisher/ac084e47-e95d-4e30-ab94-115d4dec59b2): DEZ # pensoft DEZ Deutsche Entomologische Zeitschrift
    - [24eb42e2-7877-4e58-af67-4aea8a3cd177](https://www.gbif.org/publisher/24eb42e2-7877-4e58-af67-4aea8a3cd177): NLEP # pensoft NL Nota Lepidopterologica
    - [78b5476e-1eb5-4531-9ff1-e1971d43eb4d](https://www.gbif.org/publisher/78b5476e-1eb5-4531-9ff1-e1971d43eb4d): SUBB # pensoft Subterranean Biology
    - [b7dc6d5d-49b7-4b55-936a-fb85e33d65e1](https://www.gbif.org/publisher/b7dc6d5d-49b7-4b55-936a-fb85e33d65e1): JOR # pensoft Journal of Orthoptera Research
    - [eb49971d-5d73-4534-a87a-81443c0cd66b](https://www.gbif.org/publisher/eb49971d-5d73-4534-a87a-81443c0cd66b): IBOT # pensoft Italian Botanist
    - [aa95865f-a32f-46d4-8a10-178d69436a90](https://www.gbif.org/publisher/aa95865f-a32f-46d4-8a10-178d69436a90): ZITT # pensoft Zitteliana
    - [f6406919-13e5-48e9-9e99-8226df18fa6d](https://www.gbif.org/publisher/f6406919-13e5-48e9-9e99-8226df18fa6d): ALPE # pensoft Alpine Entomology
- Block plazi datases on config file as a result of Orthoptera revision by taxonomist OSF

### 2025-05-23
- Remove PBDB to test how does it impact the GBIF occurrences coverage
- Inclusion of PR2 (sector for Amoebozoa)
- Inclusion of IRMNG (sector Animalia -Exclusion of Animalia (awaiting allocation) and Animalia incertae sedis in decisions-).
- Changes in decisions in Plazi datasets recently corrected, to include mites properly placed (not in Diptera)

### 2025-05-17
[CLB 309864](https://www.checklistbank.org/dataset/309864/about), [#411](https://download.checklistbank.org/releases/3/411/) — published as COL25.5 XR
[![DOI](https://img.shields.io/badge/DOI-10.48580%2Fdgqgz-blue?logo=doi)](https://doi.org/10.48580/dgqgz)

- ZooKeys [bb922300-7ddb-11de-a300-90ac77aa923f](https://www.gbif.org/publisher/bb922300-7ddb-11de-a300-90ac77aa923f) Publisher added last import to the project was on the 22025-03-01 vía plazi
- MycoKeys [b0e7edd4-d8b5-4b1c-bb5f-f6484e16c21c](https://www.gbif.org/publisher/b0e7edd4-d8b5-4b1c-bb5f-f6484e16c21c) Publisher added last import to the project was on the 22025-03-01 vía plazi
- PhytoKeys [fc871c4a-bb5e-4db6-b332-487bc23797f1](https://www.gbif.org/publisher/fc871c4a-bb5e-4db6-b332-487bc23797f1) Publisher added last import to the project was on the 22025-03-01 vía plazi

### 2025-05-10
[CLB 309741](https://www.checklistbank.org/dataset/309741/about), [#406](https://download.checklistbank.org/releases/3/406/)

- Rematchs Coloptera sectors given the recent adition of Bouchards classification to the base release
- Updated exclusion of BDJ into the config file, 100+ BDJ dataset are now allowed to merge

### 2025-04-19
[CLB 309351](https://www.checklistbank.org/dataset/309351/about), [#395](https://download.checklistbank.org/releases/3/395/)

- Remove PR2 sector see [issue 1009](https://github.com/CatalogueOfLife/data/issues/1009)

### 2025-04-12
[CLB 309188](https://www.checklistbank.org/dataset/309188/about), [#392](https://download.checklistbank.org/releases/3/392/)

- Add sector TAXREF Ichneumonoidea (priority 97) including subfamilies and tribes to prevent misplacing of genus under Diptera. see [issue 1004](https://github.com/CatalogueOfLife/data/issues/1004)

### 2025-04-04
- Add [PR2](https://www.checklistbank.org/dataset/308974/about) sector

### 2025-03-15
[CLB 308637](https://www.checklistbank.org/dataset/308637/about), [#376](https://download.checklistbank.org/releases/3/376/)

- Temporal addition of Tipulidae sector from Systema Dipterorum - to be removed when CCW gets updated see [issue 927](https://github.com/CatalogueOfLife/data/issues/927) [issue 926](https://github.com/CatalogueOfLife/data/issues/926)
- Add Tenebrionidea sector from iNat, [issue 969](https://github.com/CatalogueOfLife/data/issues/969)

### 2025-03-01
[CLB 308374](https://www.checklistbank.org/dataset/308374/about), [#369](https://download.checklistbank.org/releases/3/369/)

- Add IRMNG sector for Coleoptera, see [issue 875](https://github.com/CatalogueOfLife/data/issues/875), [issue 874](https://github.com/CatalogueOfLife/data/issues/874)
- Add iNat sector for Elatoroidea see [issue 965](https://github.com/CatalogueOfLife/data/issues/965)
- Update parameter Haptophyta WoRMS sector to have more classsification detailes for Algae
- Change in priority (down to 31) of Sector Plantae from WoRMS, to avoid duplicate merging of certain families . Moved below sector Haptophyta.

### 2025-02-22
[CLB 308218](https://www.checklistbank.org/dataset/308218/about), [#364](https://download.checklistbank.org/releases/3/364/)

- Add Higher clasification for Charophyta from WoRMS to cover algae HC gap
- Add Higher clasification for Chlorophyta from WoRMS to cover algae HC gap
- Remove Algae Patch, to be latter erased from ClB
- Add sector Plantae incertae sedis from WoRMS to include Higher clasification for Algospongia and Vendophyceae to cover extinct families onf plants and algae HC gap
- Add BDJ reviewed checklists related to Insects, Arachnids and Fungi 2021-2025, all from 2021-2023 and 2025 where individually checked. For 2024 only the checklist with major amount of megred names where checked. The publisher was added, and all the checklist not belonging to the above mentioned categories were blocked.
- Improve XR patch ([Commit 5cfea58](https://github.com/CatalogueOfLife/data-xrelease-patch/commit/a2e070506d8342ffca558a48f9a773406068df01), [Commit a2e0705](https://github.com/CatalogueOfLife/data-xrelease-patch/commit/5cfea5802df8080e1adb75e0e31635a52a3f41ea))

### 2025-02-15
[CLB 308145](https://www.checklistbank.org/dataset/308145/about), [#355](https://download.checklistbank.org/releases/3/355/)
