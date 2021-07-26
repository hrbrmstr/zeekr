library(zeekr)

if (Sys.info()["sysname"] == "Darwin") {

  Sys.setenv(ZEEK_PATH = "/opt/homebrew/bin:/usr/local/bin")

  loc <- tryCatch(
    pcap_to_zeek(system.file("pcap/ssh.pcap", package = "zeekr")),
    error = function(e) message("No Zeek")
  )

  if (!is.null(loc)) {
    read_zeek_logs(loc)
    unlink(loc)
  }

}

