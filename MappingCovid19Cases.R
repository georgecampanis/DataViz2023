
# Ref: https://teng.pub/technical/2020/1/7/drawing-canada-maps-in-r

# Canadian Data: https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm

#install.packages("raster")
install.packages('maptools')
#install.packages("RODBC")

library(RODBC)
library(tidyverse)
library(raster)
library(sf)
library(tidyverse)


dbconnection = odbcDriverConnect('driver={SQL Server};server=ML-RefVm-361229;database=Covid19;trusted_connection=true')

# cases
covid.casedata <- sqlQuery(dbconnection,paste("select * from cases;"))

glimpse(covid.casedata)

#pop data
covid.popdata <- sqlQuery(dbconnection,paste("select * from PopulationData;"))

odbcClose(dbconnection)

View(covid.casedata)# now join pop data

max_cases_by_prov <- covid.casedata %>% group_by(Province) %>% 
  summarize(cases_max= max(CumulativeCases)) %>% 
inner_join(covid.popdata, by = "Province") %>% 
mutate(percPopPositive=(cases_max/Population)*100)%>% 
  rename("PRENAME"="Province")


canada.provs <- read_sf('C:/Users/Student/Documents/DataViz2023/MappingData')

mapdata.Cases <- sp::merge(canada.provs , max_cases_by_prov, by="PRENAME", all=F)

map=ggplot(mapdata.Cases,aes(fill = percPopPositive)) +
  geom_sf()

map_out = map + scale_fill_gradient(name = "% cases", low = "green",  high =  "red", na.value = "grey50")+
  
  labs(x = NULL, y = NULL,
       title = "Covid Cases By Province",
       caption = "Data: Boundary Data (StatsCan).")+
  theme(
        #axis.text.x = element_blank(),
        #axis.text.y = element_blank(),
        #axis.ticks = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        rect = element_blank(),
        panel.border = element_rect(color = "black", 
                                    fill = NA, 
                                    size = 1))
map_out


ggsave("figures/canada_cases.pdf", map_out, height = 12, width = 15)

