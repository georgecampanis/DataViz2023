
install.packages("RODBC")
library(RODBC)
library(tidyverse)

dbconnection = odbcDriverConnect('driver={SQL Server};server=ML-RefVm-361229;database=Covid19;trusted_connection=true')

# cases
covid.casedata <- sqlQuery(dbconnection,paste("select * from cases;"))



#pop data
covid.popdata <- sqlQuery(dbconnection,paste("select * from PopulationData;"))


odbcClose(dbconnection)

View(covid.casedata)# now join pop data

max_cases_by_prov <- covid.casedata %>% group_by(Province) %>% 
  summarize(cases_max= max(CumulativeCases)) %>% 
inner_join(covid.popdata, by = "Province") 



