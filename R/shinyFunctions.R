
usaSharkAttacks<- function(attackDF, type = "fatal", group){
  #Filter down to just the states
  attackDF<- attackDF %>% filter(
    country == "USA",
    !{{group}}[1] %in% c("Puerto Rico", "US Virgin Islands", "Midway Atoll", "CUBA", "East cost",
                 "Johnston Atoll", "Palmyra Atoll", "Wake Island" , "Guam")
  )
  #Create attackFatal column
  if(type == "fatal"){
    attackDF2<- attackDF %>% 
      mutate(attackFatal = case_when(grepl("y", fatal_y_n, ignore.case = T) ~ 1, TRUE ~ 0))
  } else{
    attackDF2<- attackDF %>% 
      mutate(attackFatal = 1)
  }
  
  if(length(group) == 2){
    attachDF2<- attackDF2 %>% 
      group_by(!!sym(group[1]), !!sym(group[2])) %>% summarise(total = sum(attackFatal))
  } else{
    attachDF2<- attackDF2 %>% 
      group_by(!!sym(group[1])) %>% summarise(total = sum(attackFatal)) %>% 
      rename(state = area)
  }
  
  return(attachDF2)
  
}

usaAttack<- usaSharkAttacks(attacks, type = "attack", group = c("year", "sharkType"))

#USA Map
plot_usmap(data = usaAttack, values = 'total', regions = "states")  + 
  labs(title = "United States Attacks/Fatalities") +
  theme(legend.position = "right")

#Area Chart
usaAttack %>% filter(year>1900) %>% 
plot_ly(., x = ~year, y = ~total, name = ~sharkType, type = 'scatter',mode = 'lines', 
               color = ~sharkType, fill = 'tonexty', stackgroup='none') %>%
  layout(title = 'Shark Attacks and Fatalities',
                      xaxis = list(title = "Year",
                                   showgrid = FALSE),
                      yaxis = list(title = "Attacks/Fatalities",
                                   showgrid = FALSE))





