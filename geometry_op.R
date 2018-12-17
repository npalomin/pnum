library(readr)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
library(spData)
library(tidyverse)
library(maptools)
library(dplyr)

ild <- st_read("/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/GLA_Ind_Land_bl_2015.shp")
lsoa <- st_read("/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataRaw/statistical-gis-boundaries-london/ESRI/LSOA_2011_London_gen_MHW.shp")

ildsf <- st_as_sf(ild)
lsoasf <- st_as_sf(lsoa)

ildsf <- st_buffer(ild, dist = 0)
st_write(ildsf, "/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/ildsf.shp")

ild_lsoa <- st_read("/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/ild_lsoa.shp")
ild_lsoa_sf <- st_as_sf(ild_lsoa)
names(ild_lsoa_sf)

ildp <- aggregate(ild_lsoa_sf$Shape_Area, by=list(Category=ild_lsoa_sf$LSOA11CD), FUN=sum)
write_csv(ildp, "/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/ildp.csv")

ildpN <- st_set_geometry(ild_lsoa_sf, NULL)

c_sum <- ildpN[c(8,15,16)] %>%
  group_by(LSOA11CD, TYPE_2015) %>%
  summarise_if(
    is.numeric,
    funs(sum))
  
write_csv(c_sum, "/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/c_sum.csv")

wide_DF <- c_sum %>% spread(TYPE_2015, Shape_Area)

# convert NA to 0 values
wide_DF[is.na(wide_DF)] <- 0

wide_DF$il_Total <- rowSums(wide_DF[,2:4])

write_csv(wide_DF, "/Volumes/ritd-ag-project-rd00lq-jamfe87/GIS_Analysis/dataProcessed/GLA_Ind_Land_Baseline_2015/wide_DF.csv")

# unique values
length(unique(wide_DF$LSOA11CD))

