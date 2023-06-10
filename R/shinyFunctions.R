
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

usaAttack<- usaSharkAttacks(attacks, group = c("area"))

#USA Map
plot_usmap(data = usaAttack, values = 'total', regions = "states")  + 
  labs(title = "United States Attacks/Fatalities") +
  theme(legend.position = "right")

#Area Chart
fig <- plot_ly(usaAttack, x = ~year, y = ~Food.and.Tobacco, name = 'Food and Tobacco', type = 'scatter', mode = 'none', stackgroup = 'one', fillcolor = '#F5FF8D')
fig <- fig %>% add_trace(y = ~Household.Operation, name = 'Household Operation', fillcolor = '#50CB86')
fig <- fig %>% add_trace(y = ~Medical.and.Health, name = 'Medical and Health', fillcolor = '#4C74C9')
fig <- fig %>% add_trace(y = ~Personal.Care, name = 'Personal Care', fillcolor = '#700961')
fig <- fig %>% add_trace(y = ~Private.Education, name = 'Private Education', fillcolor = '#312F44')
fig <- fig %>% layout(title = 'United States Personal Expenditures by Categories',
                      xaxis = list(title = "",
                                   showgrid = FALSE),
                      yaxis = list(title = "Expenditures (in billions of dollars)",
                                   showgrid = FALSE))

fig





