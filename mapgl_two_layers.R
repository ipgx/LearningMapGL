library(mapgl)
library(tidyverse)

# Set Mapbox token from environment or secrets
setwd("~/Documents/LearningMapGL")
source("~/Documents/iTx/Data/Secrets/AT.R")
Sys.setenv(MAPBOX_PUBLIC_TOKEN = my_Access_token)

# Create sample data for two different point layers
# Layer 1: Coffee shops
coffee_shops <- tibble(
  lon = c(-74.0060, -74.0061, -74.0062, -74.0063),
  lat = c(40.7128, 40.7129, 40.7130, 40.7131),
  name = c("Brew Haven", "Daily Grind", "The Bean", "Espresso Express"),
  type = "coffee"
)

# Layer 2: Parks
parks <- tibble(
  lon = c(-74.0070, -74.0075, -74.0080),
  lat = c(40.7135, 40.7140, 40.7145),
  name = c("Central Park", "Madison Square Park", "Washington Square"),
  type = "park"
)

points_to_geojson <- function(df) {
  list(
    type = "FeatureCollection",
    features = lapply(seq_len(nrow(df)), function(i) {
      list(
        type = "Feature",
        geometry = list(
          type = "Point",
          coordinates = c(df$lon[i], df$lat[i])
        ),
        properties = list(
          name = df$name[i],
          type = df$type[i]
        )
      )
    })
  )
}

coffee_geojson <- points_to_geojson(coffee_shops)
parks_geojson <- points_to_geojson(parks)

# Create the map with two point layers and layer control
mapboxgl(
  style = mapbox_style("streets"),
  center = c(-74.006, 40.713),
  zoom = 14
) %>%
  # Add first point layer: Coffee Shops
  add_circle_layer(
    id = "coffee_shops",
    source = list(
      type = "geojson",
      data = coffee_geojson
    ),
    circle_radius = 8,
    circle_color = "#8B4513",
    circle_opacity = 0.8
  ) %>%
  # Add second point layer: Parks
  add_circle_layer(
    id = "parks",
    source = list(
      type = "geojson",
      data = parks_geojson
    ),
    circle_radius = 10,
    circle_color = "#228B22",
    circle_opacity = 0.8
  ) %>%
  add_layers_control(
    layers = list(
      "Coffee shops" = "coffee_shops",
      "Parks" = "parks"
    ),
    position = "top-right"
  )


mapboxgl() |>
  add_draw_control(radius = TRUE)
