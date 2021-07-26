#' Get Zeek
#'
#' Opens the default browser to the place where you can get Zeek.
#'
#' @export
#' @examples
#' if (interactive()) get_zeek()
get_zeek <- function() {
  utils::browseURL("https://zeek.org/get-zeek/")
}