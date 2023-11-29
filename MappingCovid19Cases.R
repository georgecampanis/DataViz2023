
# install.packages(c("sf", "rgdal","geojsonio","spdply","rmapshaper","magrittr"))
# 
install.packages("sf")


# library(sf) # the base package manipulating shapes
# #library(rgdal) # geo data abstraction library
# library(geojsonio) # geo json input and output
# library(spdplyr) # the `dplyr` counterpart for shapes
# # library(rmapshaper) # the package that allows geo shape transformation
# # library(magrittr) # data wrangling
# # library(dplyr)
# # library(tidyr)
# # library(ggplot2)



# Resources
# https://cran.r-project.org/web/packages/geojsonR/vignettes/the_geojsonR_package.html
# https://teng.pub/technical/2020/1/7/drawing-canada-maps-in-r
# https://mgimond.github.io/Spatial/reading-and-writing-spatial-data-in-r.html


# Stats Can boundary Files=> https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm

#   
# .shp file is where the data live in
library(sf)
library(ggplot2)
library(dplyr)

#https://r-spatial.github.io/sf/index.html
# https://r.geocompx.org/index.html

s.sf <- sf::st_read("~\MappingData\gpr_000b11a_e.shp")

canada_sf <- geodata::gadm("Canada", path = tempdir(), resolution = 1) |> st_as_sf()
canada_sf <- st_simplify(canada_sf, dTolerance = 1000)
# https://epsg.io/3348
canada_sf <- st_transform(canada_sf, 3348) 



