# plot MICS countries

library(ggplot2)

library(ggthemes)

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
  theme_minimal()

ggsave("MICScountries.png")

