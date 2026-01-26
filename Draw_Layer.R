


# With custom styling
   
# tx <- counties(state = "TX", cb = TRUE)

tx<- st_read("./data/drawn-features.geojson")


library(tigris)
library(sf)

 
 mapboxgl(bounds = tx) |>
   add_source(id = "tx", data = tx) |>
  add_draw_control(
    source = "tx",
    point_color = "#ff0000",
    line_color = "#00ff00",
    fill_color = "#0000ff",
    fill_opacity = 0.3,
    active_color = "#ff00ff",
    vertex_radius = 7,
    line_width = 3,
    freehand = TRUE,
    rectangle = TRUE,
    radius = TRUE,
    download_button = TRUE
  )
 