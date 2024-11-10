library(tidyverse)
library(raster)
library(sf)
raster_url <- "https://github.com/DyerlabTeaching/Raster-Data/raw/main/data/alt_22.tif"
beetle_url <- "https://raw.githubuserconteendnt.com/DyerlabTeaching/Raster-Data/main/data/AraptusDispersalBias.csv"
r <- raster(raster_url)
read_csv( beetle_url ) %>% 
  st_as_sf( coords=c("Longitude","Latitude"), crs=4326 ) -> beetles
bbox <- c(-116, -109, 22, 30)
baja_extent <- extent(bbox)
cropped_r <- crop(r, baja_extent)
rm(r)
plot( cropped_r )
plot( beetles, add=TRUE, col="purple", pch=16, cex=1.5)
text(st_coordinates(beetles), labels = beetles$Site, pos = 3, cex = 0.8, col = "black")
click( cropped_r, xy=TRUE, 
       n=3 ) -> points

