# Based on Maxwell B.Joseph's github post

#Load necessary packages and libraries
library(sf)
library(raster)
library(tidyr)

#Load the raster file
nlcd <- raster("D:\\Ram\\LanscapeMetrics\\LCLU.tif")

#Load the points data with coordinates
pts <- read.csv("C:\\Users\\Ram Raghavan\\Downloads\\test.csv")
#pts <- head(points, 20)
# Create an id for each row
ID<- data.frame(ID = 1:nrow(pts))
pts <- cbind(pts, ID)

#To change and make sure coordinates are numeric
pts$LAT  = as.numeric(pts$LAT)
pts$LONG  = as.numeric(pts$LONG)

#Change the CRS of points data to match the raster file and convert the coordinates to Spatial points
coords<-data.frame(x = pts$LAT, y = pts$LONG)
coordinates(coords)<-~x+y
proj4string(coords)<- CRS("+proj=longlat +datum=NAD83")
pts.sp <- spTransform(coords, CRS("+proj=aea +lat_0=23 +lon_0=-96 +lat_1=29.5 +lat_2=45.5 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs"))

# Create a 5000 meters buffer around each points
buffer_meters = 5000
buffer_shp<- buffer(pts.sp, buffer_meters)

# Plot data to make sure they look okay
plot(nlcd)
plot(buffer_shp, add = TRUE)

# Extract the data and calculate the proportions of each land cover types
output <- raster::extract(nlcd, pts.sp, buffer=buffer_meters)
lcprops <- lapply(output, function(x){
  counts_x <- table(x)
  proportions_x <- prop.table(counts_x)
  sort(proportions_x)
})

# Create a dataframe for extracted values
mydf <- data.frame(ID = rep(pts$ID, 
             lapply(lcprops,length)),
             cover = names(unlist(lcprops)),
             percent = unlist(lcprops))

#Convert to wide format
data_wide <- spread(mydf, cover, percent)
data_wide[is.na(data_wide)] <- 0

# Merge proportions back to points data
lclu_pts <- merge(data_wide, pts, by = "ID")
lclu_pts
