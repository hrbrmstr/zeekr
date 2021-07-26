#' Process a PCAP with Zeek and create Parquet files
#'
#' @param pcap path to PCAP to process. ([path.expand()] will be called on this value)
#' @param out_dir path to Parquet files. ([path.expand()] will be called on this value)
#'        If the directory does not exist it will be created. If ho directory is specified
#'        a temporary directory will be created and used. You should
#'        call [unlink()] on this path if you used a temporary directory.
#' @param zeek_opts extra options passed to to Zeek command line. NOTE:
#'        `--no-checksums`, `LogAscii::use_json=T`, and `Log::default_scope_sep='_'`
#'        are already handled by this function; no need to specify them.
#' @param ... extra named parameters passed on to [arrow::write_parquet()]
#' @return length 1 character vector of the expanded path of the `out_dir`
#' @note the `zeek` binary **must** be available on `PATH`. You can use the
#'       environment variable `ZEEK_PATH` as a hint where [find_zeek()] will
#'       look for the `zeek` binary.
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
pcap_to_zeek <- function(pcap, out_dir = tempfile(pattern = "zeek"), zeek_opts = c(), ...) {

  pcap <- path.expand(pcap[1])

  if (!file.exists(pcap)) {
    stop(sprintf("PCAP [%s] not found.", pcap), call.=FALSE)
  }

  out_dir <- path.expand(out_dir[1])
  if (!dir.exists(out_dir)) dir.create(out_dir)

  pcap_link <- file.path(out_dir, basename(pcap))

  if (!file.symlink(pcap, pcap_link)) {
   stop(sprintf("Could not create symlink %s for %s.", pcap_link, pcap), call. = FALSE)
  }

  zeek_opts <- c("--no-checksums", "LogAscii::use_json=T", "Log::default_scope_sep='_'", zeek_opts, "-r", pcap_link)

  wd <- getwd()
  on.exit(setwd(wd))
  setwd(out_dir)

  system2(
    command = find_zeek(),
    args = zeek_opts,
    env = c("ZEEK_LOG_SUFFIX=json")
  ) -> status

  stopifnot("Error converting PCAP." = (status == 0))

  if (!file.remove(pcap_link)) {
    stop(sprintf("Could not remove symlink %s", pcap_link), call.=FALSE)
  }

  in_fils <- list.files(out_dir, pattern = "\\.json$", full.names = TRUE)
  out_fils <- sub("\\.json$", ".parquet", in_fils)

  for (idx in seq_along(in_fils)) {

    arrow::write_parquet(
      x = arrow::read_json_arrow(
        file = in_fils[idx],
        as_data_frame = FALSE
      ),
      sink = out_fils[idx],
      ...
    )

    file.remove(in_fils[idx])

  }

  out_dir

}

#' Find the Zeek binary
#'
#' Use the environment variable `ZEEK_PATH` or specify the directory in
#' the call to this function.
#'
#' @param path hint to where to look for the Zeek binary
#' @export
#' @return length 1 character vector of the path to the zeek binary or `""`
#' @examples
#' loc <- tryCatch(
#'   find_zeek(),
#'   error = function(e) message("No Zeek")
#' )
find_zeek <- function(path = Sys.getenv("ZEEK_PATH", "")) {

  if (path != "") {
     Sys.setenv(
       PATH = paste0(path, Sys.getenv("PATH"), sep = .Platform$path.sep)
      )
  }

  res <- Sys.which("zeek")
  stopifnot(
    c("Cannot locate Zeek binary." = (res != ""))
  )
  unname(res)
}

set_names <- function (object = nm, nm) {
  names(object) <- nm
  object
}
