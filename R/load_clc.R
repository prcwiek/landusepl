#' Load Corine land cover definition data frame.
#'
#' Load Corine land cover definition data frame from csv file.
#'
#' @param fname character vector; file name
#'
#' @export
#'
#' @examples
#' load_clc()
#'
load_clc <- function(fname = "") {
  # check if code_je has 4 chars
  if(fname == "") {
    stop("ERROR: Missing file name!", call. = FALSE)
  }
  dtemp <- suppressMessages(readr::read_csv(file = fname))
  unlockBinding("clc", as.environment("package:landusepl"))
  assign("clc", dtemp, envir = as.environment("package:landusepl"))
  lockBinding("clc", as.environment("package:landusepl"))
}
