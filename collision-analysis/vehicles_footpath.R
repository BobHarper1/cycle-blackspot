## Determining vehicle types injuring pedestrians on footpaths

library(dplyr)

casualties_tbl <- tbl_df(casualties)

## Pedestrian casualties who were on footpath (c_loc == 7) severity groupings
ped_fatal <- casualties_tbl$a_ref[which(casualties_tbl$c_loc == 7 & casualties$c_sever == 1)]

ped_serious <- casualties_tbl$a_ref[which(casualties_tbl$c_loc == 7 & casualties$c_sever == 2)]

ped_slight <- casualties_tbl$a_ref[which(casualties_tbl$c_loc == 7 & casualties$c_sever == 3)]

## Vehicles involved in collisions where pedestrians on footpath, 
## where vehicle on footpath at time of impact
fpath_fatal <- filter(vehicles_tbl, a_ref %in% ped_fatal) %>% 
    filter(v_loc == "Footpath" | v_loc == "Pedestrian and vehicle shared precinct")

fpath_serious <-  filter(vehicles_tbl, a_ref %in% ped_serious) %>% 
    filter(v_loc == "Footpath" | v_loc == "Pedestrian and vehicle shared precinct")

fpath_slight <- filter(vehicles_tbl, a_ref %in% ped_slight) %>% 
    filter(v_loc == "Footpath" | v_loc == "Pedestrian and vehicle shared precinct")

## What were the vehicles? 
v1<-fpath_fatal %>% group_by(v_type) %>% summarise(num=length(v_loc)) %>% mutate(injury="Fatal")
v2<- fpath_serious %>% group_by(v_type) %>% summarise(num=length(v_loc)) %>% mutate(injury="Serious")
v3<- fpath_slight %>% group_by(v_type) %>% summarise(num=length(v_loc)) %>% mutate(injury="Slight")

summary_tbl <- rbind(v1, v2, v3) %>% spread(injury,num, fill=0)
View(summary_tbl)
