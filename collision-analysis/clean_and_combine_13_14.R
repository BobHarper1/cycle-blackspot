setwd('~/R/cycle-collisions-data')
coll14<-read.csv('collisions2014.csv')
coll13<-read.csv('collisions2013.csv')
veh14<-read.csv('vehicles2014.csv')
veh13<-read.csv('vehicles2013.csv')

## Create list of collision reference numbers where vehicle 'Pedal cycle' 
cycles14<-veh14$coll_ref[which(veh14$vehicle_type=='Pedal cycle')]
cycles13<-veh13$coll_ref[which(veh13$vehicle_type=='Pedal cycle')]

## Select collision observations matching these references
colls14<-coll14[(coll14$coll_ref %in% cycles14),]
colls13<-coll13[(coll13$coll_ref %in% cycles13),]

## Combine and remove the columns that are extraneous to requirements
collisions<-rbind(colls14, colls13)
collisions<-collisions[c(-2, -3, -12, -13, -(18:27))]

write.csv(collisions, 'cycle_collisions.csv', row.names=FALSE, quote=FALSE)
