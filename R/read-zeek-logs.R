#' Read zeek logs from a processed PCAP into a list
#'
#' @note Logs must be in Parquet or JSON format.
#' @param log_dir directory of zeek logs
#' @export
#' @examples
#' loc <- tryCatch(
#'   pcap_to_zeek(system.file("pcap/ssh.pcap", package = "zeekr")),
#'   error = function(e) message("No Zeek")
#' )
#'
#' if (!is.null(loc)) {
#'   read_zeek_logs(loc)
#'   unlink(loc) # don't do this IRL until you're done working with or saving.
#' }
read_zeek_logs <- function(log_dir) {

  log_dir <- path.expand(log_dir[1])

  stopifnot("Cannot find directory." = dir.exists(log_dir))

  in_fils <- list.files(log_dir, full.names = TRUE)

  fil_names <- make.unique(tools::file_path_sans_ext(basename(in_fils)))

  lapply(in_fils, function(.x) {

    if (tools::file_ext(.x) == "parquet") {
      arrow::read_parquet(.x)
    } else {
      ndjson::stream_in(.x, cls = "tbl")
    }

  }) -> out

  set_names(out, fil_names)

}