#' Save Corine land cover definition data frame.
#'
#' Save Corine land cover definition data frame to csv file.
#'
#' @param fname character vector; file name
#'
#' @export
#'
#' @examples
#' save_clc()
#'
save_clc <- function(fname = "") {
  # check if code_je has 4 chars
  if(fname == "") {
    stop("ERROR: Missing file name!", call. = FALSE)
  }
  readr::write_csv(clc, file = paste0(fname, ".csv"))
}
