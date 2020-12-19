#' Show CORINE Land Cover leveles.
#'
#' Display a data frame with CORINE Land Cover leveles, roughness length vaulesa
#' and descriptions in Polish and English.
#'
#' @return a tibble CORINE Land Cover leveles.
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' show_teryt()
#'
show_clc <- function() {
  clc %>% dplyr::as_tibble() %>% print(n = Inf)
}
