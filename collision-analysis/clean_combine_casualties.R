setwd("C:/Users/bob.harper/Dropbox/cycle-collisions-data/data-archive/casualties/")
cas_temp = list.files(pattern = "*.tab")
for (i in 1:length(cas_temp)) assign(cas_temp[i], read.delim(cas_temp[i], stringsAsFactors = FALSE))

casualty1 <- rbind(casualty1998.tab, casualty1999.tab, casualty2000.tab, casualty2001.tab, casualty2002.tab, 
                   casualty2003.tab, casualty2004.tab, casualty2005.tab, casualty2006.tab, make.row.names = FALSE)
casualty2 <- rbind(casualty2007.tab, casualty2008.tab, casualty2009.tab, casualty2010.tab, make.row.names = FALSE)
casualty3 <- rbind(casualty2011.tab, casualty2012.tab, casualty2013.tab, casualty2014.tab, make.row.names = FALSE)

rm(list=cas_temp)

# Object 'casualty3' (the combined sets from 2011 onwards) has age groupings
# (nominal, as value labels), while previous datasets had the age itself as
# integers. First, lets put those age grouping in:
casualty3$c_agegroup <- factor(casualty3$c_agegroup, 
                               levels = c(1:9), 
                               labels = c("Under 10","10-16", "17-24", "25-34", "35-44", 
                                          "45-54", "55-64", "65+", "Unknown"))

# Then change the column names
colnames(casualty3) <- colnames(casualty2)
colnames(casualty2) == colnames(casualty3)

# Remove the 'ped_inj' column from casualty2 & 3 (1 does not have this variable)
casualty2 <- casualty2[-13]
casualty3 <- casualty3[-13]

# Now all rows can be combined
casualties <- rbind(casualty1, casualty2, casualty3)
