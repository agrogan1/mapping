library(sf)

library(ggplot2)

mapdata <- read_sf("./shapefiles/wrld_simpl/wrld_simpl.shp")

mapdata$continent <- factor(mapdata$REGION,
                            levels = c(0, 2, 9, 19, 142))
ggplot(mapdata) + 
  geom_sf(aes(fill = factor(POP2005)))