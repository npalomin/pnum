## tutorial url
## http://www.sthda.com/english/wiki/computing-and-adding-new-variables-to-a-data-frame-in-r

library("dplyr")
library("readr")
#### tmap
library(maptools)
library(RColorBrewer)
library(classInt)
library(OpenStreetMap)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
library(ggplot2)
library(spData)
library(tidyverse)

businesses_in_london <- read_csv("/Volumes/ucfnnap-1/made_in_london/GISanalysis/dataRaw/businesses-in-london.csv")
bil <- businesses_in_london
head(bil)
class(bil)

# Create variable 'division' from variable 'SICCode.SicText_1' substract chr 1 to 4 (first 4 characters)
bil <- mutate(bil, division = substr(SICCode.SicText_1, 1, 4))

# Change chr to num for 'division' variable
bil$division <- as.numeric(as.character(bil$division))

# Convert numeric to factor
bil$divname <- cut(bil$division, 
                  breaks = c(-Inf, 999, 1499, 1799, 1999, 3999, 4999, 5199, 5999, 6799, 8999, 9729, 9999),
                  labels = c("Agriculture, Forestry and Fishing", "Mining", "Construction", "not used", "Manufacturing",
                             "Transportation, Communications, Electric, Gas and Sanitary service", "Wholesale Trade", 
                             "Retail Trade", "Finance, Insurance and Real Estate", "Services", "Public Administration", "Nonclassifiable"), 
                  right = TRUE)

### count number of variables in 'divname'
bil$divname <- as.character(bil$divname)

length(unique(bil[["divname"]])) # [1] 13
library(plyr)
sumt <- count(bil, vars = "divname")
sumt

#### create markdown table
library(knitr)
kable(sumt, format = "markdown")

bildf <-as.data.frame(bil)
class(bildf) # [1] "data.frame"
### Get long and lat from your data.frame. Make sure that the order is in lon/lat.
latlon <- bildf[,c('long','lat')]

bilsp <- SpatialPointsDataFrame(coords = latlon, data = bil,
                               proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))

class(bilsp) # [1] "SpatialPointsDataFrame"
bilsf <- st_as_sf(bilsp)
class(bilsf) # [1] "sf"         "data.frame"
### quick map SpatialPointsDataFrame
qtm(bilsp)

man <- subset(bilsp, divname == "Manufacturing")
class(man) # [1] "sf"         "data.frame"
qtm(man)

tmap_mode("view") # or "plot"
tm_shape(man) + 
  tm_symbols(size=0.01,
             shape = 20,
             col = "magenta", 
             alpha = .1,
             border.lwd = NA
  )

testdf <- subset(df, select=c(division, divname))
# using subset function 
# newdata <- subset(mydata, age >= 20 | age < 10, 
#                   select=c(ID, Weight))

write.csv(df, file = "/Users/nicolas/Desktop/df.csv")
# this did not work because I ran out of storage space
# write.table(df, file = "/Volumes/ucfnnap-1/made_in_london/GISanalysis/dataProcessed/df.csv")

#### tmap
library(maptools)
library(RColorBrewer)
library(classInt)
library(OpenStreetMap)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
library(ggplot2)
library(spData)
library(tidyverse)


### csv into dataframe
qq <- as.data.frame(x)
class(qq) # [1] "data.frame"

### Get long and lat from your data.frame. Make sure that the order is in lon/lat.
xy <- qq[,c('long','lat')]
xy

spdf <- SpatialPointsDataFrame(coords = xy, data = qq,
                               proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))

class(spdf) # [1] "SpatialPointsDataFrame"
# convert sp (spatial) to sf (simple feature)
bui <- st_as_sf(spdf)
class(bui) # [1] "sf"         "data.frame"
qtm(bui)
qtm(spdf)

# qw <-as.data.frame(df)
# class(qw) # [1] "data.frame"
# ### Get long and lat from your data.frame. Make sure that the order is in lon/lat.
# ll <- qw[,c('long','lat')]
# 
# spqw <- SpatialPointsDataFrame(coords = ll, data = qw,
#                                proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
# 
# class(spqw) # [1] "SpatialPointsDataFrame"
# sfqw <- st_as_sf(spqw)
# class(sfqw) # [1] "sf"         "data.frame"
# qtm(spqw)


##### Mapeck exercise
##### https://github.com/SymbolixAU/mapdeck

install.packages("mapdeck")
library(mapdeck)

key <- "pk.eyJ1IjoibnBhbG9taW4iLCJhIjoiY2owMDF5YXQxMDA2eDMybmwwd2tqYTU3bSJ9.Icvrku6Q57o8L0gncJI89g"

dfc <- capitals
dfc$z <- sample(10000:10000000, size = nrow(dfc))

##### add_pointcloud
mapdeck(token = key, style = 'mapbox://styles/mapbox/dark-v9') %>%
  add_pointcloud(
    data = dfc
    , lon = 'lon'
    , lat = 'lat'
    , elevation = 'z'
    , layer_id = 'point'
    , fill_colour = "country"
  )
head(dfc)

##### add_scatterplot
mapdeck( token = key, style = 'mapbox://styles/mapbox/dark-v9', pitch = 0 ) %>%
  add_scatterplot(
    data = capitals
    , lat = "lat"
    , lon = "lon"
    , radius = 1000
    , fill_colour = "country"
    , layer_id = "scatter_layer"
  )

testdf <- subset(df, select=c(divname, lat, long))

# first five rows
testdf <- subset(df, select=c(divname, lat, long))

x <- df[1:32,c('divname', 'lat', 'long')]
x

mapdeck( token = key, style = 'mapbox://styles/mapbox/dark-v9', pitch = 0 ) %>%
  add_scatterplot(
    data = x
    , lat = "lat"
    , lon = "long"
    , radius = 1000
    , fill_colour = "divname"
    , layer_id = "scatter_layer"
  )

ls() # R will produce a list of objects that are currently active.


# URL source: https://en.wikipedia.org/wiki/Standard_Industrial_Classification
# 0100-0999	Agriculture, Forestry and Fishing
# 1000-1499	Mining
# 1500-1799	Construction
# 1800-1999	not used
# 2000-3999	Manufacturing
# 4000-4999	Transportation, Communications, Electric, Gas and Sanitary service
# 5000-5199	Wholesale Trade
# 5200-5999	Retail Trade
# 6000-6799	Finance, Insurance and Real Estate
# 7000-8999	Services
# 9100-9729	Public Administration
# 9900-9999	Nonclassifiable