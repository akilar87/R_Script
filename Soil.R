#### Load libraries.

library(terra)
library(sf)
library(raster)
library(rgdal)

#### List SSURGO. Note: all raster SSURGO have to be in the same extent.

s <- stack ('D:\\RR\\CWD\\RScripts\\SSURGO\\cec_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\clay.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\clay_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\clay_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\clay_2550.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\clay_3060.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\db.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\drainage_class_int.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ec_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ec_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\hydgrp_int.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\i_class.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ksat_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\kw_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\max_ksat.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\max_om.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\mean_ksat.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\min_ksat.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\n_class.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\om_kg_sq_m.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\paws_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\paws_050.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ph_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ph_2550.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\ph_3060.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\resdept.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\rf_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sand.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sand_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sand_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sand_2550.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sand_3060.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\sar.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\silt.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\silt_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\silt_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\silt_2550.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\silt_3060.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\soilorder_int.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\str_int.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\texture_05.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\texture_025.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\texture_2550.tif',
             'D:\\RR\\CWD\\RScripts\\SSURGO\\water_storage.tif')

#### Read shape file with coordinates and match the crs as raster file

c = sf::st_read('D:\\RR\\CWD\\RScripts\\Shapefiles\\M3.shp')|>
  sf::st_transform(crs = terra::crs(s))

#Extract the values
values <- extract(s, c)

#Join the values to shape file
final = cbind(c,val)
final

#Make a csv of the final output
write.csv(final, file = 'D:\\RR\\CWD\\RScripts\\Soil_KS.csv')


#plot to check how it looks
#m<- rbind(c(1,2), c(2, 3), c(3,4))
#layout(m)
#plot(s[[1]])
#plot(c, add=TRUE)
#plot(s[[2]])
#plot(c, add=TRUE)
#plot(s[[3]])
#plot(c, add=TRUE)
#plot(s[[4]])
#plot(c, add=TRUE)
