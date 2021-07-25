#' Call the Zeek binary with optional custom environment variables and options
#'
#' This is just a convenience wrapper around [system2()]. See [find_zeek()] for
#' information on helping this package find the Zeek binary.
#'
#' @param zeek_bin specify a complate path or let [find_zeek()] do the dirty work.
#' @param args same as [system2()] `args`
#' @param env same as [system2()] `env`
#' @return `list` with `stderr`, `stdout`, `status` and `errmsg` (invisibly)
#' @export
zeek <- function(zeek_bin = find_zeek(), args = c(), env = c()) {

  errf <- tempfile()
  on.exit(unlink(errf))

  outf <- tempfile()
  on.exit(unlink(outf))

  system2(
    command = zeek_bin,
    args = args,
    env = env,
    stderr = errf,
    stdout = outf
  ) -> res

  invisible(list(
    stderr = readLines(errf, warn = FALSE),
    stdout = readLines(outf, warn = FALSE),
    status = attr(res, "status"),
    errmsg = attr(res, "errmsg")
  ))

}