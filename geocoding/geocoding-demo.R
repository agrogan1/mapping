#' ---
#' title: "geocoding demo"
#' output: html_document
#' author: Andy Grogan-Kaylor
#' ---

library(tidygeocoder) # geocoding

library(dplyr) # for %>% operator

library(readxl) # import Excel

library(ggplot2) # beautiful graphs

library(maps) # map data

library(ggrepel) # repelling labels

# library(ggmap) # don't use

# Get Data

simulated_address_data <- read_excel("simulated-address-data.xlsx")

# Concatenate Addresses

simulated_address_data$address <- paste(simulated_address_data$street,
                                     ", ",
                                     simulated_address_data$city,
                                     ", ",
                                     simulated_address_data$state)

# Geocode

# Census geocoding has LOW success rate with this data
# You will want to find a process with HIGH success rate
# You could also try batchgeo -> KML -> Latitude/Longitude

mydata <- simulated_address_data %>% 
  tidygeocoder::geocode(address, 
                        method = 'arcgis', 
                        lat = latitude, 
                        long = longitude)

# Map (ggplot)

ggplot(mydata,
       aes(x = longitude,
           y = latitude,
           label = agency)) +
  borders("state") +
  geom_point(color = "red") +
  geom_text_repel(max.overlaps = 100) + 
  theme_void()

# Map Leaflet

library(leaflet) # interactive maps

leaflet(mydata) %>% 
  addCircles(lng = ~longitude, 
             lat = ~latitude,
             label = ~agency) %>% 
  addTiles() # map tiles










