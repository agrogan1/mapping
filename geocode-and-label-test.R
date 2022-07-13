# Demo of Geocoding + (Hopefully Better Labeling) In R

library(tidygeocoder) # geocoding

library(dplyr) # for %>% operator

library(readxl) # import Excel

library(ggplot2) # beautiful graphs

library(maps) # map data

library(ggrepel) # repelling labels

# library(ggmap) # don't use

# Get Data

Final_Geocode_PEG_QGIS <- read_excel("mydata.xlsx")

# Concatenate Addresses

Final_Geocode_PEG_QGIS$addr <- paste(mydata$Address,
                                     ", ",
                                     mydata$City,
                                     ", ",
                                     mydata$State,
                                     " ",
                                     mydata$Zipcode)

# Geocode

# Census geocoding has LOW success rate with this data
# You will want to find a process with HIGH success rate
# You could also try batchgeo -> KML -> Latitude/Longitude

mydata <- Final_Geocode_PEG_QGIS %>% 
  tidygeocoder::geocode(addr, 
          method = 'census', 
          lat = latitude, 
          long = longitude)

# Choose Which Points To Map

mydata$usethislabel <- NA

# Manually Set A Few Labels

mydata$usethislabel[1] <- mydata$`Client Name`[1]

mydata$usethislabel[9] <- mydata$`Client Name`[9]

# Map (ggplot)

ggplot(mydata,
       aes(x = longitude,
           y = latitude,
           label = usethislabel)) +
  borders("state") +
  geom_point(color = "red") +
  geom_text_repel(max.overlaps = 100) + 
  theme_void()

# Map Leaflet

library(leaflet) # interactive maps

leaflet(mydata) %>% 
  addCircles(lng = ~longitude, 
             lat = ~latitude,
             label = ~`Client Name`) %>% 
  # addTiles() %>%
  addProviderTiles(providers$CartoDB.Positron) # good map tiles








