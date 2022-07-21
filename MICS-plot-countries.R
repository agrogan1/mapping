# plot MICS countries

# call libraries

library(ggplot2)

library(ggthemes)

library(sf) # simple (spatial) features

# get data

global_data <- read_sf("./shapefiles/wrld_simpl/wrld_simpl.shp")

MICS <- read_sf("./shapefiles/MICS/MICS.shp")

# map

ggplot(global_data) +
  geom_sf(fill = "gray93",
          size = .25) +
  geom_sf(data = MICS, 
          aes(fill = continent)) +
  scale_fill_tableau(name = "Continent",
                     palette = "Tableau 10", 
                     type = "regular") +
  # scale_fill_viridis_d(option = "turbo") +
  labs(title = "Countries in MICS") +
  # theme_minimal() +
  theme_void()

ggsave("MICScountries.png")

