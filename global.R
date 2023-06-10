packages<- c("shiny", "tidyverse", "plotly", "shinydashboard", "usmap", "janitor")
invisible(lapply(packages, library, character.only = T))
source("./R/shinyFunctions.R")
source("./Modules/metrics/metricsModule.R")
attacks<- readxl::read_xlsx("attacks.xlsx") %>% 
  clean_names() %>% 
  filter(!row_number() %in% c(2882)) %>% 
  mutate(sharkType = case_when(
    grepl("white", species, ignore.case = T) ~ "Great White Shark",
    grepl("bull", species, ignore.case = T) ~ "Bull Shark",
    grepl("tiger",species, ignore.case = T) ~ "Tiger Shark",
    grepl("lemon", species, ignore.case = T) ~ "Lemon Shark",
    grepl("hammer",species, ignore.case = T) ~ "Hammerhead Shark",
    TRUE ~ "Other"
  ))
