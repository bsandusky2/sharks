
usaSharkAttacks<- function(attackDF, type = "fatal"){
  #Filter down to just the states
  attackDF<- attackDF %>% filter(
    !Area %in% c("Puerto Rico", "US Virgin Islands", "Midway Atoll", "CUBA", "East cost",
                 "Johnston Atoll", "Palmyra Atoll", "Wake Island" , "Guam")
  )
}


testSummary<- test %>% 
  mutate(fatal = case_when(grepl("y", `Fatal (Y/N)`, ignore.case = T) ~ 1, TRUE ~ 0)) %>% 
  group_by(Area) %>% summarise(totalFatal = sum(fatal)) %>% 
  rename(state = Area)

plot_usmap(data = testSummary, values = 'totalFatal', regions = "states")  + 
  labs(title = "United States Attacks/Fatalities", subtitle = "Poverty Percentage Estimates for New England Counties in 2014") +
  theme(legend.position = "right")





