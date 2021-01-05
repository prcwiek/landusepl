#' WAsP map based on CORINE map.
#'
#' Extract and export to a file roughness areas WAsP map based on Corine map.
#'
#' @param fname character vector; file name
#' @param code_je character vector; code of Polish county
#' @param wsg_zone numeric vector; 33 or 34 UTM WGS84 zone
#' @param buffer numeric vector; negative shape buffer value
#'
#' @return show a leaflet map with Corine roughness areas.
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' export_wasp_map()
#'
export_wasp_map <- function(fname = "", code_je = "0414", wgs_zone = 0, buffer = -1) {
  if(fname  == "") {
    stop("ERROR: File name missing!", call. = FALSE)
  }
  if(nchar(code_je) != 4) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 chars.", call. = FALSE)
  }
  # check if code_je has 4 chars
  if(is.na(as.numeric(code_je))) {
    stop("ERROR: Invalid input format! Argument code_je has to have 4 digits chars.", call. = FALSE)
  }
  if(wgs_zone != 33 & wgs_zone != 34) {
    stop("ERROR: Wrong UTM WGS84 zone! For Poland select 33 or 34", call. = FALSE)
  }
  if(buffer >= 0) {
    stop("ERROR: Buffer has to be negative!", call. = FALSE)
  }

  # prepare corine map ------------------------------------------------------
  message("Preparing CORINE map...")
  voivod_prefix <- stringr::str_sub(code_je, 1, 2)
  if(voivod_prefix == "02") {
    corine <- d02
  } else if(voivod_prefix == "04") {
    corine <- d04
  } else if(voivod_prefix == "06") {
    corine <- d06
  } else if(voivod_prefix == "08") {
    corine <- d08
  } else if(voivod_prefix == "10") {
    corine <- d10
  } else if(voivod_prefix == "12") {
    corine <- d12
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "14") {
    corine <- d14
  } else if(voivod_prefix == "16") {
    corine <- d16
  } else if(voivod_prefix == "18") {
    corine <- d18
  } else if(voivod_prefix == "20") {
    corine <- d20
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "22") {
    corine <- d22
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "24") {
    corine <- d24
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "26") {
    corine <- d26
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "28") {
    corine <- d28
  } else if(voivod_prefix == "30") {
    corine <- d30
    message("Missing data in several areas of this voivodeship!")
  } else if(voivod_prefix == "32") {
    corine <- 32
  }

  # create a county shape ----------------------------------------------------
  message("Creating county shape...")
  powiat_shape <- sf::as_Spatial(countyshp[countyshp$JPT_KOD_JE == code_je,])
  powiat_shape <- sp::spTransform(powiat_shape, raster::crs(corine))

  # crop CORINE map ---------------------------------------------------------
  message("Cropping CORINE map...")
  corine_crop <- raster::crop(corine, powiat_shape)
  corine_crop <- suppressWarnings(sp::spTransform(corine_crop,
                             raster::crs(paste0("+proj=utm +zone=",
                                                wgs_zone,
                                                "+ellps=WGS84 +datum=WGS84 +units=m +no_defs"))))


  # shrink shapes by buffer value -------------------------------------------
  message("Shrinking map by buffer...")
  corine_buffer <- suppressWarnings(rgeos::gBuffer(corine_crop, width = buffer, byid = TRUE))

  # processing data ---------------------------------------------------------
  message("Processing data...")
  corine_buffer$ID <- stringr::str_remove(corine_buffer$ID, pattern = "PL_")
  corine_buffer@data$ID <- rownames(corine_buffer@data)
  out_points <- broom::tidy(corine_buffer, region = "ID")
  names(out_points) <- stringr::str_replace(names(out_points), "id", "ID")
  out_df <- dplyr::left_join(out_points, corine_buffer@data, by = "ID")
  df <- out_df %>%
    dplyr::select(long, lat, group, CODE_18)
  df$long <- round(as.numeric(df$long),1)
  df$lat <- round(as.numeric(df$lat),1)

  # Saving file -------------------------------------------------------------
  message("Saving file...")
  # select separator
  if (R.Version()$os == "linux-gnu") {
    lsep <- "\r\n"
  } else {
    lsep <- "\n"
  }
  # open file
  fcon = file(fname, "w")
  # write header
  writeLines(paste0("+", fname, ", 3: 34: 10: 0, UTM (north)-WGS84 Zone: 34 | UTM Z34 WGS-8 | WME v.11.3.2.360"), sep = lsep, fcon)
  writeLines("  0.000000   0.000000   0.000000   0.000000", sep = lsep, fcon)
  writeLines("  1.000000   0.000000   1.000000   0.000000",  sep = lsep, fcon)
  writeLines("  1.000000   0.000000", sep = lsep, fcon)

  # get numbers of polygons
  items <- unique(df$group)

  for (i in items) {
    save_line <- TRUE
    # get a polygon
    dw <- df[df$group == i,]

    # get left roughness
    lr <- as.numeric(clc[which(clc$CORINE_Land_Cover_level_3 == dw$CODE_18[1]), 2])

    if(lr == 0.03) {
      save_line <- FALSE
    }

    if(save_line){

      # write header of a new line
      writeLines(paste0("     0.0300","      ", format(lr, nsmall = 4), "      ", nrow(dw)),
                 sep = lsep, fcon)

      # number of full lines
      nfl <- nrow(dw) %/% 3

      j <- 1
      while(j < nfl * 3 ){
        writeLines(paste("   ", format(dw$long[j], nsmall = 1),"   ", format(dw$lat[j], nsmall = 1),
                          "    ", format(dw$long[j+1], nsmall = 1),"   ", format(dw$lat[j+1], nsmall = 1),
                          "    ", format(dw$long[j+2], nsmall = 1),"   ", format(dw$lat[j+2], nsmall = 1)),
                   sep = lsep, fcon)

        j <- j + 3
      }
      # number of lines
      k <- nrow(dw)
      if(k - nfl * 3 == 2){
        writeLines(paste0("   ", format(dw$long[k-1], nsmall = 1),"   ", format(dw$lat[k-1], nsmall = 1),
                          "    ", format(dw$long[k], nsmall = 1),"   ", format(dw$lat[k], nsmall = 1)),
                   sep = lsep, fcon)
      } else if(k - nfl * 3 == 1){
        writeLines(paste0("   ", format(dw$long[k], nsmall = 1),"   ", format(dw$lat[k], nsmall = 1)),
                   sep = lsep, fcon)

      }
    }
  }
  close(fcon)
  message("Done!")
}
