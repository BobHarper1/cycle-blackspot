# Cycle blackspots NI
## Safety (and a disclaimer)
*Disclaimer: I don't endorse 'alternative' routes as being safer and you should always exercise appropriate caution when cycling or driving whatever the circumstances.*

I've provided this map for cyclists (and motorists) who want to take care on the road network by being aware of 'danger points' for cycles, and to help plan their trips accordingly. The clusters show areas where collisions have occurred previously in close proximity to one another. Obviously, this has some aspects to consider:
* Areas (or routes through areas) where previous collisions or clustering are not displayed are not inherently 'safer'. Nowhere that cycles and motor vehicles pass close to one another is 100% safe.
* The most heavily used routes will have the most significant amounts of prior collisions. This doesn't mean that you're x times as likely to have an RTC on those routes over an alternative, and the inverse is true for light-use routes.
* There is likely to be an underreporting of incidents to PSNI meaning that there are a number of collisions missing from the map. The best thing that you can do to correct this is to [report](http://www.psni.police.uk/collision_care_pack.pdf) any RTC to the police. It's a legal requirement in NI.

## The data
Data for populating this map has come from PSNI records of road traffic collisions (RTCs) from 1998 to 2014 (inclusive) held on the UK Data Archive. 

Each incident has involved a cycle where a person has been injured in the collision (slight, serious or fatally). 'Collision' does not necessarily mean colliding with another vehicle (it might involve a collision with e.g. road signage) but this occurs in only 2% of these cases. Also, the person injured is not necessarily the cyclist (two cars could collide with driver injuries and involve a cyclist who escapes uninjured, but that is unlikely). In the case of fatal collisions involving cycles, the cyclist was the fatal party in each case.

A note as well as to the difference in the scale of injuries. Obviously, all collisions are tragic (and in most cases, avoidable), but I've chosen not to distinguish between 'slight' and 'serious/fatal' injuries for the purposes of this project. This is because the map is intended to provide a sense of where any collision has happened so they can be avoided in future. I don't mean to equate fatal and slight injuries, especially where people's friends and family members have been involved.

I've copied the R scripts used to combined the annual datasets in the analysis folder of this repository (as well as the output comma-separated values files). The datasets required a good bit of cleaning to get into the appropriate format for extracting the cycle collisions (using the unique incident reference identifier) before conversion into GeoJSON (simply using [csv2json](https://github.com/mapbox/csv2geojson)) to display on the map, all those steps are detailed in the scripts.

The spatial stuff for the map was done in QGIS. Essentially, at first producing a heatmap (each collision had a 150m radius), then vectorising it and selecting the 'hottest' areas as the clusters. [Here's the basic process](http://www.qgistutorials.com/en/docs/creating_heatmaps.html)

## Why 'collision' and not accident?
It's more accurate. In nearly all cases a collision could have been avoided by driving or cycling with greater care - 'accident' suggests otherwise. PSNI refer to collisions, unlike their policing counterparts in GB who still produce road traffic accident (RTA) statistics.

## Plot.ly graphs
[Here](https://plot.ly/organize/bobharper:139)
