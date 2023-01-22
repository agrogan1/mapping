# plotly map test

library(plotly)

g <- list(# projection = list(type = 'robinson'),
  projection = list(type = 'orthographic',
                    rotation = list(lon = 0,
                                    lat = 0,
                                    roll = 0)))

plot_ly(type = "scattermapbox") %>%
  layout(
    mapbox = list(
      style = 'open-street-map',
      zoom =3.0,
      center = list(lon = -83, lat = 42))) 
