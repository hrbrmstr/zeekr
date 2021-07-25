#' (WIP) Common `redef`initions for Zeek when processing PCAPs
#'
#' Zeek is great out-of-the-box, but you may need to tweak behavior
#' every now and then to perform analyses on the Zeek logs.
#'
#' - `redef Log::default_scope_sep = "_"` will turn dots ("`.`") in column
#' names to underscores ("`_`"). This will make many "big data" environments
#' much more pleasant to deal with.
#'
#' - `redef FileExtraction::path = "/some/where/else"` will reconfigure where
#' Zeek's output files go.
#'
#' - `redef FTP::default_capture_password = T` will turn off Zeek's default
#' masking of FTP passwords.
#'
#' - `redef HTTP::default_capture_password=T` will turn off Zeek's default
#' state of not capturing HTTP passwords.
#'
#' - `redef Intel::read_files += { "/opt/zeek_file_badlist.txt" }` will load in
#' custom IoCs (see the [Intelligence Framework](https://docs.zeek.org/en/master/frameworks/intel.html))
#' for more info.
#'
#' @name zeek_redefs
#' @rdname zeek_redefs
NULL