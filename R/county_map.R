#' Show county on the map.
#'
#' Display borders of a selected county on the map.
#'
#' @param code_je character vector; code of Polish county
#' @param county character vector; name of Polish county
#'
#' @return show a leaflet map with a county border.
#'
#' @export
#'
#' @examples
#' county_map()
#'
county_map <- function(code_je = "1465") {
  # check if code_je has 4 chars
  if(nchar(code_je) != 4) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 chars.", call. = FALSE)
  }
  # check if code_je has 4 chars
  if(is.na(as.numeric(code_je))) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 digits chars.", call. = FALSE)
  }
  # extract a shape for a selected county ------------------------------------
  powiat_shape <- countyshp[countyshp$JPT_KOD_JE == code_je,]

  # transform to geographical coordinates -----------------------------------
  powiat_display <- sf::st_transform(powiat_shape, crs = 4326)

  tmap::tmap_mode("view")
  tm <- tmap::tm_shape(powiat_display, name = "County borders") +
    tmap::tm_borders(lwd = 2) +
    tmap::tmap_options(basemaps = c("OpenStreetMap", "Esri.WorldTopoMap", "Esri.WorldGrayCanvas")) +
    tmap::tm_markers(popup.vars = FALSE, text = c("JPT_NAZWA_"), text.size = 1.5)
  tmap::tmap_leaflet(tm)
}
