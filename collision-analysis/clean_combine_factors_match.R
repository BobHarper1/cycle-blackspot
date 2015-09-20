setwd("C:/Users/Bob/Dropbox/cycle-collisions-data/data-archive/vehicles/")
v_temp = list.files(pattern = "*.tab")
for (i in 1:length(v_temp)) assign(v_temp[i], read.delim(v_temp[i], stringsAsFactors = TRUE))

setwd("C:/Users/Bob/Dropbox/cycle-collisions-data/data-archive/collisions/")
c_temp = list.files(pattern = "*.tab")
for (i in 1:length(c_temp)) assign(c_temp[i], read.delim(c_temp[i], stringsAsFactors = TRUE))

# From 2007, the sets have the additional column 'forreg', which isn't necessary
# for our purposes, so remove column 17 and then bind rows
vehicles1 <- rbind(vehicle2004.tab, vehicle2005.tab, vehicle2006.tab, make.row.names = FALSE)
vehicles2 <- rbind(vehicle2007.tab, vehicle2008.tab, vehicle2009.tab, vehicle2010.tab, 
                   make.row.names = FALSE)
vehicles3 <- rbind(vehicle2011.tab, vehicle2012.tab, vehicle2013.tab, make.row.names = FALSE)
vehicles2 <- vehicles2[-17]
vehicles3 <- vehicles3[-17]

# The column names of one of these sets isn't matching the others
colnames(vehicles1) == colnames(vehicles2)
colnames(vehicles2) == colnames(vehicles3)

# Turns out vehicles3 (the sets from 2011 onwards) has driver age groupings
# (nominal, as value labels), while previous datasets had the age itself as
# integers. First, lets put those age grouping in:
vehicles3$v_agegroup <- factor(vehicles3$v_agegroup, levels = c(1:9), labels = c("Under 10", 
                                                                                 "10-16", "17-24", "25-34", "35-44", "45-54", "55-64", "65+", "Unknown"))

# Then change the column names so the rows can be combined
colnames(vehicles3) <- colnames(vehicles2)
colnames(vehicles2) == colnames(vehicles3)

vehicles <- rbind(vehicles1, vehicles2, vehicles3)

# Sort out the other value:labels
vehicles$v_type <- factor(vehicles$v_type, 
                          levels = c(0:25), 
                          labels = c("Unknown", 
                                     "Pedal cycle", "Motorcycle - moped", "No label 1", "Motorcycle (<125cc)", "Motorcycle (>=125cc)", 
                                     "Invalid vehicle/3-wheeler", "Car - hackney taxi", "Car", "Motor caravan", "No label2 ", 
                                     "No label3 ", "No label 4", "Tractor", "Other motor", "Goods <=3.5 tonnes", 
                                     "Goods >3.5 tonnes <7.5 tonnes", "Goods >=7.5 tonnes", "Car - taxi", "Minibus", 
                                     "Bus or coach", "Ridden horse", "Other non motor", "Motorcycle (size unknown)", 
                                     "Goods vehicles (weight unknown)", "Agri vehicle"))

vehicles$v_tow <- factor(vehicles$v_tow, 
                         levels = c(1:6), 
                         labels = c("No towing/artic", 
                                    "Artic vehicle", "Double/multiple trailer", "Caravan", "Single trailer", "Other tow"))

vehicles$v_man <- factor(vehicles$v_man, 
                         levels = c(1:19), 
                         labels = c("Reversing", 
                                    "Parking", "About to go", "Slowing/stopping", "Moving off", "U-turn", "Left turn", 
                                    "Waiting to turn left", "Right turn", "Waiting to turn right", "Change lane to left", 
                                    "Change lane to right", "Overtake moving offside", "Overtake stationary offside", 
                                    "Overtake nearside", "Left-hand bend", "Right-hand bend", "Ahead other", "Other/not known"))

vehicles$v_loc <- factor(vehicles$v_loc, 
                         levels = c(1:13), 
                         labels = c("Leaving main road", 
                                    "Entering main road", "On main road", "On minor road", NA, "Lay-by/hard shoulder", 
                                    "Entering lay-by", "Leaving lay-by", "On cycle lane/way", "Pedestrian and vehicle shared precinct", 
                                    "Other public place", "Bus lane/way", "Footpath"))

vehicles$v_junc <- factor(vehicles$v_junc, 
                          levels = c(1:7), 
                          labels = c("Not at junction", 
                                     "Approaching/waiting/parked at junction", "Vehicle in middle junction", "Cleared junction or waiting/parked at exit", 
                                     "Did not impact", "Entering slip road", "Exiting slip road"))

vehicles$v_skid <- factor(vehicles$v_skid, 
                          levels = c(1:6), 
                          labels = c("No skid", 
                                     "Skidded", "Skidded and overturned", "Jack-knifed", "Jack-knifed and overturned", 
                                     "Overturned"))

vehicles$v_hit <- factor(vehicles$v_hit, 
                         levels = c(1:15), 
                         labels = c("None", "Previous collision", 
                                    "Roadworks", "Parked vehicle (lit)", "Parked vehicle (unlit)", "Bridge (roof)", 
                                    "Bridge side", "Bollard/refuge", "Open door", "Central island roundabout", "Kerb", 
                                    NA, "Other", "Animal except ridden horse", "Parked vehicle"))

vehicles$v_leave <- factor(vehicles$v_leave, 
                           levels = c(1:11), 
                           labels = c("None", 
                                      "Road sign/signal", "Lamp post", "Telegraph pole", "Tree/fence/boundary", "Bus stop", 
                                      "Central crash barrier", "Near/offside barrier", "Submerged in water", "Entered ditch", 
                                      "Other perm object"))

vehicles$v_hitoff <- factor(vehicles$v_hitoff, 
                            levels = c(1:11), 
                            labels = c("None", 
                                       "Road sign/signal", "Lamp post", "Telegraph pole", "Tree/fence/boundary", "Bus stop", 
                                       "Central crash barrier", "Near/offside barrier", "Submerged in water", "Entered ditch", 
                                       "Other perm object"))

vehicles$v_impact <- factor(vehicles$v_impact, 
                            levels = c(1:5), 
                            labels = c("Did not impact", 
                                       "Front", "Back", "Nearside", "Offside"))

vehicles$v_sex <- factor(vehicles$v_sex, 
                         levels = c(1:3), 
                         labels = c("Male", "Female", 
                                    "Unknown"))

vehicles$v_hitr <- factor(vehicles$v_hitr, 
                          levels = c(1:3), 
                          labels = c("Other", "Hit and run", 
                                     "Non-stop, not hit"))

# Extract the observations that were 'pedal cycles'
cycles <- vehicles[which(vehicles$v_type == "Pedal cycle"), ]

# Apply the same binding process to the collision sets
collision1 <- rbind(collision2004.tab, collision2005.tab, collision2006.tab, make.row.names = FALSE)
collision2 <- collision2007.tab
collision3 <- rbind(collision2008.tab, collision2009.tab, collision2010.tab, collision2011.tab, 
                    collision2012.tab, collision2013.tab, make.row.names = FALSE)

collision1 <- collision1[-c(18:20)]
collision2 <- collision2[-c(18:23)]
collision3 <- collision3[-c(18:20)]

collisions <- rbind(collision1, collision2, collision3, make.row.names = FALSE)

collisions$a_type <- factor(collisions$a_type, 
                            levels = c(1:3), 
                            labels = c("Fatal", "Serious", 
                                       "Slight"))

collisions$a_ctype <- factor(collisions$a_ctype, 
                             levels = c(1:14), 
                             labels = c("Roundabout", 
                                        "One way", "no3", "no4", "no5", "Single track", "Single carriageway 1 lane each way", 
                                        "Single carriageway 3 lanes", "Single carriageway 4 lanes", "Other/unknown", 
                                        "Dual carriageway", "Motorway", "Single carriageway", "Slip road"))

collisions$a_jdet <- factor(collisions$a_jdet, 
                            levels = c(1:12), 
                            labels = c("Not at or within 20m of junction", 
                                       "Roundabout", "Mini roundabout", "T junction", "Y junction", "Crossroads", "Staggered junction", 
                                       "Multiple junction", "Slip road", "Private entrance", "Other junction", "T or staggered junction"))

collisions$a_jcont <- factor(collisions$a_jcont, 
                             levels = c(1:7), 
                             labels = c("Not at junction", 
                                        "Authorised person", "Automatic traffic signal", "Stop sign", "Giveway sign/markings", 
                                        "Uncontrolled", "Give way or uncontrolled"))

collisions$a_weat <- factor(collisions$a_weat, 
                            levels = c(1:8), 
                            labels = c("Fine no high winds", 
                                       "Raining no high winds", "Snowing no high winds", "Fine with high winds", "Raining with high winds", 
                                       "Snowing with high winds", "Fog/mist hazard", "Strong sun (glare)"))

collisions$a_roadsc <- factor(collisions$a_roadsc, 
                              levels = c(1:10), 
                              labels = c("Dry", "Wet/damp", "Snow", "Frost/ice", 
                                         "Flood", "Oil", "Mud", "Leaves", 
                                         "Slippery (but dry)", "Other"))

collisions$a_speccs <- factor(collisions$a_speccs, 
                              levels = c(1:7), 
                              labels = c("None", "Auto traffic signal out", 
                                         "Auto traffic signal partial defect", 
                                         "Permanent road signing defective/obscured", 
                                         "Road works", "Road surface defective", 
                                         "Railing level crossing"))

collisions$a_chaz <- factor(collisions$a_chaz, 
                            levels = c(1:9), 
                            labels = c("None", "Dislodged vehicle load in road", 
                                       "Other object in road", "Previous collision", 
                                       "Dog in road", "Other animal in road", "Smoke, dust etc", "Any animal except ridden horse", 
                                       "Pedestrian in road - not injured"))

collisions$a_scene <- factor(collisions$a_scene, 
                             levels = c(1, 2), 
                             labels = c("Yes", "No"))

cycle_collisions <- collisions[which(collisions$a_ref %in% cycles$a_ref), ] 