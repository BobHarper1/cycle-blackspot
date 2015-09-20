library(dplyr)

## How many collisions by severity (type) over the 10 years?
cycle_collisions %>% group_by(a_type) %>% summarise(no_collisions = length(a_type))

## How many collisions observed per year?
by_year_type <- cycle_collisions %>% group_by(a_type, a_year) %>% summarise(no_collisions = length(a_year))

## Create a list of the cycle collision reference numbers (a_ref)
cycle_ref <- cycle_collisions$a_ref

## Data frame of the other (non-cycle) vehicles involved.
other_veh <- subset(vehicles, a_ref %in% cycle_ref & v_type != 'Pedal cycle')

## What are cycles colliding with? (Group factor levels e.g. all Goods together?)
other_veh %>% group_by(v_type) %>% summarise(no_vehicles = length(v_type))

## How many hit and runs?
sum(other_veh$v_hitr == 'Hit and run')