# Cycle blackspots NI
## Safety (and a disclaimer)
*Disclaimer: I don't endorse 'alternative' routes as being safer and you should always exercise appropriate caution when cycling or driving whatever the circumstances.*

I've provided this map for cyclists (and motorists) who want to take care on the road network by being aware of 'danger points' for cycles, and to help plan their trips accordingly. The clusters show areas where collisions have occurred previously in close proximity to one another. Obviously, this has two aspects to consider:
* Areas (or routes through areas) where collisions or clusters are not displayed are not inherently 'safer'. Nowhere that cycles and motor vehicles pass close to one another is 100% safe.
* There is likely to be an underreporting of incidents to PSNI meaning that there are a number of collisions missing from the map. The best thing that you can do to correct this is to [report](http://www.psni.police.uk/collision_care_pack.pdf) any RTC to the police. It's a legal requirement in NI.

## The data
Data for populating this map has come from PSNI records of road traffic collisions (RTCs) from 2004 to 2013 (inclusive) held on the UK Data Archive. In addition, I have also added data for killed or seriously injured ('KSI') collisions that the [Detail Data](http://data.nicva.org/dataset/road-traffic-collision-data-ksi-northern-ireland) project obtained through FoI from PSNI, as that dataset has not been added to the UK Data Archive as yet.

Each incident has involved a cycle where a person has been injured in the collision (slight, serious or fatally). 'Collision' does not necessarily mean colliding with another vehicle, it could involve a collision with road signage, but this occurs in only 2% of these cases. Also, the person injured is not necessarily the cyclist (two cars could collide with injuries and involve a cyclist who escapes uninjured, but that is unlikely). 

I've copied the R scripts used to combined the annual datasets in the analysis folder of this repository (as well as the output comma-separated values files). The datasets required a bit of cleaning to get into the appropriate format for extracting the cycle collisions (using the unique incident reference identifier) before conversion into GeoJSON (simply using [csv2json](https://github.com/mapbox/csv2geojson)) to display on the map, all those steps are detailed in the scripts.

## Why 'collision' and not accident?
It's more accurate. In nearly all cases a collision could have been avoided by driving or cycling with greater care - 'accident' suggests otherwise. PSNI refer to collisions, unlike their policing counterparts in GB who still produce road traffic accident (RTA) statistics.
