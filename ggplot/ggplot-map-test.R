#' ---
#' title: "ggplot map test"
#' output: pdf_document
#' author: Andy Grogan-Kaylor
#' ---

# Demo of making maps with R

# Call the libraries

library(ggplot2) # beautiful graphs

library(dplyr) # data wrangling

library(sf) # simple (spatial) features

library(readr) # import csv

library(here) # where am I?

setwd(here()) # set the working directory

# use read_sf to open shapefiles
# getting the directory and filename right is important

city_boundary <- read_sf("./mapping/shapefiles/AA_City_Boundary/AA_City_Boundary.shp")

buildings <- read_sf("./mapping/shapefiles/AA_Building_Footprints/AA_Building_Footprints.shp")

trees <- read_sf("./mapping/shapefiles/a2trees/AA_Trees.shp")

parks <- read_sf("./mapping/shapefiles/AA_Parks/AA_Parks.shp")

university <- read_sf("./mapping/shapefiles/AA_University/AA_University.shp")

WashtenawRoads <- read_sf("./mapping/shapefiles/Roads/RoadCenterlines.shp")

AnnArborRoads <- st_crop(WashtenawRoads, 
                         city_boundary) # crop to only get A2 roads

# watersheds <- read_sf("./mapping/shapefiles/watersheds/Watersheds.shp")

# use read_csv to read text file with client data

clients <- read_csv("./mapping/location-data/clients.csv")

# only clients in Ann Arbor area

clients <- clients %>% 
  filter(latitude <= 42.35 &
           latitude >= 42.2 &
           longitude >= -83.8 &
           longitude <= -83.65)

# convert clients to sf object while denoting CRS

# 4326 -> WGS1984

# point <- st_as_sf(clients,
#                   coords = c("longitude", "latitude"),
#                   crs = 4326)

# 4269 -> NAD1983 (A2 is NAD1983)

point <- st_as_sf(clients, 
                  coords = c("longitude", "latitude"), 
                  crs = 4269) 

# use ggplot to make the map

# NB RE Macs: the plotting device on Macs is actually pretty slow
# we notice this with all the detail that is involved in maps
# maps can be REALLY slow on Macs
# so--inconveniently--we write directly to PDF on a Mac
# and don't see the graph in our RStudio window
# we have to manually open the PDF to see the created map

# Note, haven't figured out how to add clients w/o goofing up the map

# Apparently, the first layer is important for setting the CRS of the map

# pdf("./mapping/ggplot-map-test.pdf") # open PDF device (uncomment on Mac)

ggplot(city_boundary) +
  # geom_sf(data = buildings,
  #         fill = "lightgrey") +
  geom_sf(data = AnnArborRoads, 
          color = "lightgrey") +
  geom_sf(color = "red", alpha = .5) +
  geom_sf(data = university, 
          fill = "blue", 
          alpha = .25) + 
  geom_sf(data = parks, 
          fill = "darkgreen", 
          alpha = .25) +
  geom_sf(data = point, 
          aes(color = program), 
          size = 5, 
          alpha = 1.0) +
  geom_sf(data = point, 
          size = 5, 
          pch = 21) + # 21 is outlines
  # geom_sf(data = trees, 
  #         size = .1,
  #         color = "darkgreen") +
  labs(title = "Ann Arbor",
       subtitle = "Locations of Clients",
       caption = "Simulated Social Service Agency Data") +
  scale_color_viridis_d() +
  scale_fill_viridis_d() +
  theme_minimal() +
  theme(plot.title = element_text(size = rel(2)), 
        axis.text = element_text(size = rel(.5))) 

ggsave("./mapping/social-service-agency.png", 
       height = 11, 
       width = 8.5)

ggsave("./mapping/social-service-agency.pdf", 
       height = 11, 
       width = 8.5)

# dev.off() # turn off PDF device (uncomment on Mac)



