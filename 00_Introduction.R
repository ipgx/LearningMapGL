library(pak)
library(mapgl)
library(tidyverse)

#setwd("/Users/pgupta/Documents/LearningMapGL")
setwd("~/Documents/LearningMapGL")
source("~/Documents/iTx/Data/Secrets/AT.R")
pak::pak("walkerke/mapgl")


## Public Access Token for Mapbox
Sys.setenv(MAPBOX_PUBLIC_TOKEN = my_Access_token)

## Globe View
mapboxgl()
maplibre()

# Write script from here
mapboxgl() %>%
  set_projection("albers")

maplibre() %>%
  set_projection("mercator")

maplibre() %>%
  set_projection("equalEarth")


maplibre()
