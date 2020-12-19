#' Show TERYT data.
#'
#' Display TERYT code, voivodship, code_je of county and county name.
#'
#' @param teryt character vector; two digits TERYT number, code of Polish voivodeship
#' @param voivodeship character vector; Polish voivodeship name
#' @param code_je charatcer vector; code of Polish county
#' @param county character vector; name of Polish county
#'
#' @return a tibble with requested information
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' show_teryt()
#'
show_teryt <- function(teryt = "", voivodeship = "", code_je = "", county = "") {
  if (teryt == "" & voivodeship == "" & code_je == "" & county == "") {
    dout <- dteryt
  } else {
    if (nchar(teryt) == 2) {
      dout <- dplyr::filter(dteryt, TERYT == teryt)
    } else {
      dout <- dteryt
    }
    if (nchar(voivodeship) > 0) {
      dout <- dplyr::filter(dout, Voivodeship == voivodeship)
    }
    if (nchar(code_je) == 4) {
      dout <- dplyr::filter(dout, Code_je == code_je)
    }
    if (nchar(county) > 0) {
      dout <- dplyr::filter(dout, County == county)
    }
  }
  dout %>% dplyr::as_tibble() %>% print(n = Inf)
}
