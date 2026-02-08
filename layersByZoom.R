library(shiny)
library(mapgl)
library(tidycensus)

library(tidycensus)
library(dplyr)
library(purrr)
library(sf)

census_api_key("YOUR_KEY", install = FALSE)
options(tigris_use_cache = TRUE)

counties <- c("Miami-Dade", "Broward", "Palm Beach")
acs_vars <- "B01003_001"
acs_year <- 2024

fetch_level <- function(level) {
  map_dfr(counties, function(cty) {
    get_acs(
      geography = level,
      variables = acs_vars,
      state = "FL",
      county = cty,
      survey = "acs5", # 2020–2024 5-year
      year = acs_year,
      geometry = TRUE
    ) |>
      mutate(county_name = cty, level = level)
  })
}

pop_county <- fetch_level("county")
pop_tract <- fetch_level("tract")
pop_bg <- fetch_level("block group")
