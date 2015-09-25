library(dplyr) # N.B. need to make sure plyr not running as these conflict
library(tidyr)

cycle_tbl <- tbl_df(cycle_collisions)

## How many collisions by severity (type) over the years?
cycle_tbl %>% group_by(a_type) %>% summarise(num = length(a_type))

## How many collisions per year?
cycle_tbl %>% group_by(a_year) %>% summarise(num = length(a_year))

## How many collisions observed per year by severity of collision?
print(annual_type <-
  cycle_tbl %>% group_by(a_type, a_year) %>% summarise(num = length(a_year)))

## How many cyclists KSI per year?
annual_KSIs <- cycle_tbl[which(cycle_tbl$a_ref %in% (casualties$a_ref[which(casualties$c_vtype==1 & casualties$c_sever < 3)])),] %>% group_by(a_year, a_type) %>% summarise(num = length(a_year)) %>% spread(a_type, num, fill=0)
print(annual_KSIs)

## Baseline period (2004-2008) for Road Safety Strategy 2020, Fatal and Serious Injuries
baseline <- subset(annual_KSIs, a_year >= 2004 & a_year <= 2008)
print(baseline)
mean(baseline$num[which(baseline$a_type=="Fatal")])
mean(baseline$num[which(baseline$a_type=="Serious")])

## How many collisions by number of vehs involved?
cycle_tbl %>% group_by(a_veh) %>% summarise(num = length(a_veh))

## Create a list of the cycle collision reference numbers (a_ref)
cycle_ref <- cycle_tbl$a_ref

## Data frame of the other (non-cycle) vehicles involved.
other_veh <- subset(vehicles, a_ref %in% cycle_ref & v_type != 'Pedal cycle')

## What are cycles colliding with? (Group factor levels e.g. all Goods together?)
other_veh %>% group_by(v_type) %>% summarise(no_vehicles = length(v_type))

## How many hit and runs?
sum(other_veh$v_hitr == 'Hit and run')

## All road users, KSI by year
all_KSIs <- filter(casualties, c_sever==1) %>% group_by(a_year, c_sever) %>% summarise(num=length(a_year)) %>% spread(c_sever, num, fill=0)
colnames(all_KSIs) <- (c("Year", "Fatal", "Serious"))
all_KSIs <- mutate(all_KSIs, Total_KSI = Fatal + Serious)
print(all_KSIs)
