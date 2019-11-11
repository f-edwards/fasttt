library(tidyverse)
rm(list=ls())
load("./mixture_model/input/sd.RData")

### manully constrain stops>searches>hits
stops<-stops %>% 
  mutate(num_searches = 
           ifelse(num_searches>num_stops, 
                  num_stops,
                  num_searches
                  ),
         num_hits = 
           ifelse(num_hits>num_searches,
                  num_searches,
                  num_hits))

save(stops, file = "./mixture_model/input/sd.RData")



### format data for use with fasttt
### requires table with the following columns:
# [1] "location_variable"     "driver_race"           "num_searches"         
# [4] "num_hits"              "race_base_pop"         "total_pop_in_precinct"
# [7] "base_population"       "searches_per_capita"   "hit_rate"    
# sd_dat<-read_csv("./sd_data.csv") %>% 
#   filter(beat!=999) %>% 
#   filter(race%in%c("Black", "Latinx", "White"))
# 
# sd_index<-expand_grid(race = unique(sd_dat$race),
#                       beat = unique(sd_dat$beat))
# 
# stops<-sd_index %>% 
#   left_join(sd_dat %>% 
#   group_by(beat, race) %>% 
#   summarise(num_stops = n(),
#             num_searches = sum(search_conducted),
#             num_hits = sum(contraband_found))) %>% 
#   mutate(num_stops = ifelse(is.na(num_stops), 0, num_stops),
#          num_searches = ifelse(is.na(num_searches), 0, num_searches),
#          num_hits = ifelse(is.na(num_hits), 0, num_hits)) %>% 
#   rename(location_variable = beat,
#          driver_race = race) %>% 
#   arrange(location_variable) %>% 
#   mutate(driver_race = factor(driver_race),
#          location_variable = factor(location_variable)) %>% 
#   mutate(num_stops = ifelse(num_stops==0,1,num_stops),
#          num_searches = ifelse(num_searches==0,1,num_searches),
#          num_hits = ifelse(num_hits==0,1,num_hits))


# save(stops,
#            file="./mixture_model/input/sd.RData")