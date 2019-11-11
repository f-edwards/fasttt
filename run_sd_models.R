rm(list=ls())
load("./mixture_model/input/sd.RData")
source("run_mixture_mcmc_sd.R")
source("mixture_analysis_sd.R")
#run_threshold_test("sd", "model_mixture.stan")

load("./mixture_model/output/sd_model_mixture.RData")

stops$thresholds<-get_thresholds_from_post(post, stops)

stops_white<-stops %>% 
  filter(driver_race=="White") %>% 
  rename(white_threshold = thresholds) %>% 
  select(location_variable, white_threshold)

stops_plot<-stops %>% 
  left_join(stops_white) 

ggplot(stops_plot %>% 
         filter(driver_race!="White"),
       aes(x=white_threshold, y = thresholds,
           size = num_stops)) + 
  geom_point() + 
  geom_abline(slope=1, intercept=0, lty=2) +
  facet_wrap(~driver_race) + 
  scale_y_log10() +
  scale_x_log10()

observed_white<-stops %>% 
  filter(driver_race=="White") %>% 
  mutate(white_hit_rate = num_hits/num_searches) %>% 
  select(location_variable, white_hit_rate)

stops_plot<-stops %>% 
  filter(driver_race!="White") %>% 
  left_join(observed_white) %>% 
  mutate(hit_rate = num_hits/num_searches)

ggplot(stops_plot, 
       aes(x=white_hit_rate, y = hit_rate,
           size = num_stops)) + 
  geom_point() + 
  geom_abline(slope=1, intercept=0, lty=2) +
  facet_wrap(~driver_race) + 
  scale_y_log10() +
  scale_x_log10()