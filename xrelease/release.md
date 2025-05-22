## Schedule
An XRelease is to be started every friday.

## Prepare Friday Releases
Before releasing we need to verify the following:

 1. no [broken merge sectors](https://www.checklistbank.org/catalogue/3/sector?broken=true&mode=merge) exist
 2. no [source aliases](https://www.checklistbank.org/catalogue/3/sources) are missing


## Validation 
**Once completed** a review of the results should look at:

 1. [failed sector syncs](https://www.checklistbank.org/catalogue/3/sector/sync?limit=25&offset=0&state=failed)
 2. scan [build logs](https://www.checklistbank.org/dataset/3LXRC/about) for any `ERROR` entries
 3. release [issues](https://www.checklistbank.org/dataset/3LXRC/issues)
 4. scan [GBIF impact tool](https://www.checklistbank.org/tools/gbif-impact)
 5. review [ID logs](https://download.checklistbank.org/releases/3/)
 6. review [incertae sedis taxa](https://www.checklistbank.org/dataset/3LXRC/taxon/S) and metric changes compared to last published release.
 7. review [metadata](https://www.checklistbank.org/dataset/3LXRC/about)
 
## Publishing the XR
Once a new base release is published around the middle of the month the following XRs in the same month can be used to publish the monthly XR.
If nothing blocking is found in the validation above, the XR immediately following the base release should be used. Otherwise we have one week to focus on fixing things and start building a new XR manually before the regular friday build to save time.
