#' Show Corine roughness on county on the map.
#'
#' Display Corine roughness areas of a selected county on the map.
#'
#' @param code_je character vector; code of Polish county
#'
#' @return show a leaflet map with Corine roughness areas.
#'
#' @importFrom magrittr %>%

#' @export
#'
#' @examples
#' corine_map()
#'
corine_map <- function(code_je = "0414") {
  # check if code_je has 4 chars
  if(nchar(code_je) != 4) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 chars.", call. = FALSE)
  }
  # check if code_je has 4 chars
  if(is.na(as.numeric(code_je))) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 digits chars.", call. = FALSE)
  }

  # create a county shape ----------------------------------------------------
  message("Preparing county map...")
  powiat_shape <- sf::st_transform(countyshp, crs = 4326)
  powiat_shape <- powiat_shape[powiat_shape$JPT_KOD_JE == code_je,]

  # prepare corine map ------------------------------------------------------
  message("Preparing CORINE map...")
  voivod_prefix <- stringr::str_sub(code_je, 1, 2)
  if(voivod_prefix == "02") {
    corine <- sf::st_as_sf(d02)
  } else if(voivod_prefix == "04") {
    corine <- sf::st_as_sf(d04)
  } else if(voivod_prefix == "06") {
    corine <- sf::st_as_sf(d06)
  } else if(voivod_prefix == "08") {
    corine <- sf::st_as_sf(d08)
  } else if(voivod_prefix == "10") {
    corine <- sf::st_as_sf(d10)
  } else if(voivod_prefix == "12") {
    corine <- sf::st_as_sf(d12)
  } else if(voivod_prefix == "14") {
    corine <- sf::st_as_sf(d14)
  } else if(voivod_prefix == "16") {
    corine <- sf::st_as_sf(d16)
  } else if(voivod_prefix == "18") {
    corine <- sf::st_as_sf(d18)
  } else if(voivod_prefix == "20") {
    corine <- sf::st_as_sf(d20)
  } else if(voivod_prefix == "22") {
    corine <- sf::st_as_sf(d22)
  } else if(voivod_prefix == "24") {
    corine <- sf::st_as_sf(d24)
  } else if(voivod_prefix == "26") {
    corine <- sf::st_as_sf(d26)
  } else if(voivod_prefix == "28") {
    corine <- sf::st_as_sf(d28)
  } else if(voivod_prefix == "30") {
    corine <- sf::st_as_sf(d30)
  } else if(voivod_prefix == "32") {
    corine <- sf::st_as_sf(d32)
  }
  corine <- sf::st_transform(corine, crs = 4326)

  # crop map ----------------------------------------------------------------
  message("Cropping of map...")
  m <- sf::st_intersection(corine, powiat_shape)

  # join with CORINE Land Cover definitions ---------------------------------
  message("Joining maps...")
  m <- m %>%
    dplyr::left_join(clc, by = c("CODE_18" = "CORINE_Land_Cover_level_3")) %>%
    dplyr::mutate(textmap = paste(CODE_18, Roughness_length, sep = "; "))

  # preapre map -------------------------------------------------------------
  message("Preparing map for dispalying")
  tmap::tmap_mode("view")
  tm <- tmap::tm_shape(m, name = "Corine map", is.master = TRUE) +
    tmap::tm_borders(lwd = 1) +
    tmap::tm_fill("CODE_18", palette = "-plasma", alpha = 0.3) +
    tmap::tm_markers(popup.vars = FALSE, text = c("textmap"), text.size = 1) +
    tmap::tm_shape(powiat_shape, name = "County borders") +
    tmap::tm_borders(lwd = 2) +
    tmap::tmap_options(basemaps = c("OpenStreetMap"))

  # display map -------------------------------------------------------------
  tmap::tmap_leaflet(tm)
}
