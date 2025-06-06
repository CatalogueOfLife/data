# COL eXtended Release historic ChangeLog
We document here all major editorial changes for each weekly [COL XRelease]([url](https://www.checklistbank.org/dataset?limit=50&offset=0&origin=xrelease&releasedFrom=3&reverse=false)).


### 2025, Week 23
- Publisher added as Plazi Journals have become independed on the GBIF registry
    07fa07e6-9d4f-4b82-99fb-1a2055991233: AINV # pensoft African Invertebrates
    7597e7d3-b8d6-4ecf-84a3-d731d8b6d290: ESYS # pensoft Evolutionary Systematics
    43999f3b-3220-490b-83f4-954cd43c3f6c: VZOO # pensoft Vertebrate Zoology
    3996dc51-9cce-445b-a06f-7aba727bb0d8: HERP # pensoft Herpetozoa
    d9a8e26f-f479-45f2-9bf3-144c25965646: FREC # pensoft FR Fossil Record
    5aaf6f62-72a5-403f-8fae-e8f9cd4a18cd: CENT # pensoft Contributions to Entomology
    9eb1b78c-2c2b-431e-8fd7-492734770611: ASP # pensoft Arthropod Systematics & Phylogeny
    a019af3a-3982-4c10-9a27-2a793d40ed97: CAUC # pensoft Caucasiana
    af62a723-bd15-484a-995e-6fc6720c54f0: AIEP # pensoft AIEP Acta Ichthyologica et Piscatoria
    ac084e47-e95d-4e30-ab94-115d4dec59b2: DEZ # pensoft DEZ Deutsche Entomologische Zeitschrift
    24eb42e2-7877-4e58-af67-4aea8a3cd177: NLEP # pensoft NL Nota Lepidopterologica
    78b5476e-1eb5-4531-9ff1-e1971d43eb4d: SUBB # pensoft Subterranean Biology
    b7dc6d5d-49b7-4b55-936a-fb85e33d65e1: JOR # pensoft Journal of Orthoptera Research
    eb49971d-5d73-4534-a87a-81443c0cd66b: IBOT # pensoft Italian Botanist
    aa95865f-a32f-46d4-8a10-178d69436a90: ZITT # pensoft Zitteliana
    f6406919-13e5-48e9-9e99-8226df18fa6d: ALPE # pensoft Alpine Entomology


### 2025, Week 21
XR Link: https://www.checklistbank.org/dataset/309864/about
- Remove PBDB to test how does it impact the GBIF occurrences coverage
- Inclusion of PR2 (sector for Amoebozoa)
- Inclusion of IRMNG (sector Animalia -Exclusion of Animalia (awaiting allocation) and Animalia incertae sedis in decisions-). 
- Changes in decisions in Plazi datasets recently corrected, to include mites properly placed (not in Diptera)

### 2025, Week 20 
XR Link: https://www.checklistbank.org/dataset/309864/about
[CLB 309864](https://www.checklistbank.org/dataset/309864), [#411](https://download.checklistbank.org/releases/3/411)
published as ```COL25.5 XR```
- ZooKeys  [bb922300-7ddb-11de-a300-90ac77aa923f] Publisher added last import to the project was on the 22025-03-01 vía plazi
- MycoKeys  [b0e7edd4-d8b5-4b1c-bb5f-f6484e16c21c] Publisher added last import to the project was on the 22025-03-01 vía plazi
- PhytoKeys  [fc871c4a-bb5e-4db6-b332-487bc23797f1] Publisher added last import to the project was on the 22025-03-01 vía plazi

### 2025, Week 19
[CLB 309741](https://www.checklistbank.org/dataset/309741), [#406](https://download.checklistbank.org/releases/3/406)
- Rematchs Coloptera sectors given the recent adition of Bouchards classification to the base release
- Updated exclusion of BDJ into the config file, 100+ BDJ dataset are now allowed to merge


### 2025, Week 16
- Remove PR2 sector see https://github.com/CatalogueOfLife/data/issues/1009
  
### 2025, Week 15
- Add sector TAXREF Ichneumonoidea (priority 97) including subfamilies and tribes to prevent misplacing of genus under Diptera. see https://github.com/CatalogueOfLife/data/issues/1004
  
### 2025, Week 14
- Add [PR2](https://www.checklistbank.org/dataset/308974/about) sector


### 2025, Week 11
- Temporal addition of Tipulidae sector from Systema Dipterorum - to be removed when CCW gets updated see [927](https://github.com/CatalogueOfLife/data/issues/927) [926](https://github.com/CatalogueOfLife/data/issues/926)
- Add Tenebrionidea sector from iNat, https://github.com/CatalogueOfLife/data/issues/969

### 2025, Week 9
- Add IRMNG sector for Coleoptera, see [875](https://github.com/CatalogueOfLife/data/issues/875), [874](https://github.com/CatalogueOfLife/data/issues/874)
- Add iNat sector for Elatoroidea see [965](https://github.com/CatalogueOfLife/data/issues/965)
- Update parameter Haptophyta WoRMS sector to have more classsification detailes for Algae
- Change in priority (down to 31) of Sector Plantae from WoRMS, to avoid duplicate merging of certain families . Moved below sector Haptophyta. 


### 2025, Week 8
 - Add Higher clasification for Charophyta from WoRMS to cover algae HC gap
 - Add Higher clasification for Chlorophyta from WoRMS to cover algae HC gap
 - Remove Algae Patch, to be latter erased from ClB
 - Add sector Plantae incertae sedis from WoRMS to include Higher clasification for Algospongia and Vendophyceae to cover extinct families onf plants and algae HC gap
 - Add BDJ reviewed checklists related to Insects, Arachnids and Fungi 2021-2025, all from 2021-2023 and 2025 where individually checked. For 2024 only the checklist with major amount of megred names where checked. The publisher was added, and all the checklist not belonging to the above mentioned categories were blocked.
 - Improve XR patch ([Commit 5cfea58
](https://github.com/CatalogueOfLife/data-xrelease-patch/commit/a2e070506d8342ffca558a48f9a773406068df01), [Commit a2e0705
Preview](https://github.com/CatalogueOfLife/data-xrelease-patch/commit/5cfea5802df8080e1adb75e0e31635a52a3f41ea))

### 2025, Week 7
[COL-2025-02-15](https://www.checklistbank.org/dataset/308145/about)
