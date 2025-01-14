## Schedule
An XRelease is to be started every friday.

## Preparation
Before releasing we need to verify the following:

 1. no [broken merge sectors]([url](https://www.checklistbank.org/catalogue/3/sector?broken=true&mode=merge)) exist
 2. no source aliases are missing


## Validation 
**Once completed** a review of the results should look at:

 1. [failed sector syncs](https://www.checklistbank.org/catalogue/3/sector/sync?limit=25&offset=0&state=failed)
 2. scan [build logs](https://www.checklistbank.org/dataset/3LXRC/about) for any `ERROR` entries
 3. release [issues](https://www.checklistbank.org/dataset/3LXRC/issues)
 4. scan [GBIF impact tool](https://www.checklistbank.org/tools/gbif-impact)
 
