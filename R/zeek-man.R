#' Zeek Manual Page Quick Reference
#'
#' `zeek` - passive network traffic analyzer
#'
#' ## SYNOPSIS
#'
#' **`zeek`** `[*options*] [*file* ...]`
#'
#' ## DESCRIPTION
#'
#' Zeek is primarily a security monitor that inspects all traffic on a link in depth for signs of suspicious activity. More generally, however, Zeek supports a wide range of traffic analysis tasks even #' outside of the security domain, including performance measurements and helping with trouble-shooting.
#'
#' Zeek comes with built-in functionality for a range of analysis and detection tasks, including detecting malware by interfacing to external registries, reporting vulnerable versions of software seen on #' the network, identifying popular web applications, detecting SSH brute-forcing, validating SSL certificate chains, among others.
#'
#' ## OPTIONS
#'
#' * **`&lt;file>`**:   policy file, or read stdin
#' * **`-a`**, `--parse-only`:   exit immediately after parsing scripts
#' * **`-b`**, `--bare-mode`:   don't load scripts from the base/ directory
#' * **`-d`**, `--debug-policy:`   activate policy file debugging
#' * **`-e`**, `--exec &lt;zeek code>`:   augment loaded policies by given code
#' * **`-f`**, `--filter &lt;filter>`:   tcpdump filter
#' * **`-h`**, `--help|-?`:   command line help
#' * **`-i`**, `--iface &lt;interface>`:   read from given interface
#' * **`-p`**, `--prefix &lt;prefix>`:   add given prefix to policy file resolution
#' * **`-r`**, `--readfile &lt;readfile>`:   read from given tcpdump file
#' * **`-s`**, `--rulefile &lt;rulefile>`:   read rules from given file
#' * **`-t`**, `--tracefile &lt;tracefile>`:   activate execution tracing
#' * **`-w`**, `--writefile &lt;writefile>`:   write to given tcpdump file
#' * **`-v`**, `--version`:   print version and exit
#' * **`-x`**, `--print-state &lt;file.bst>`:   print contents of state file
#' * **`-C`**, `--no-checksums`:   ignore checksums
#' * **`-F`**, `--force-dns`:   force DNS
#' * **`-I`**, `--print-id &lt;ID name>`:   print out given ID
#' * **`-N`**, `--print-plugins`:   print available plugins and exit (**-NN** for verbose)
#' * **`-P`**, `--prime-dns`:   prime DNS
#' * **`-Q`**, `--time`:   print execution time summary to stderr
#' * **`-R`**, `--replay &lt;events.bst>`:   replay events
#' * **`-S`**, `--debug-rules`:   enable rule debugging
#' * **`-T`**, `--re-level &lt;level>`:   set 'RE_level' for rules
#' * **`-U`**, `--status-file &lt;file>`:   Record process status in file
#' * **`-W`**, `--watchdog`:   activate watchdog timer
#' * **`-X`**, `--zeekygen &lt;cfgfile>`:   generate documentation based on config file
#' * **`--pseudo-realtime[=**&lt;speedup>]`:   enable pseudo-realtime for performance evaluation (default 1)
#' * **`--load-seeds`** `&lt;file>`:   load seeds from given file
#' * **`--save-seeds`** `&lt;file>`:   save seeds to given file
#'
#' The following option is available only when Zeek is built with the `--enable-debug` configure option:
#'
#' **`-B`**, `--debug &lt;dbgstreams>`:   Enable debugging output for selected streams ('-B help' for help)
#'
#' The following options are available only when Zeek is built with `gperftools` support (use the `--enable-perftools` and `--enable-perftools-debug` configure options):
#'
#' **`-m`**, `--mem-leaks`:   show leaks
#' **`-M`**, `--mem-profile`:   record heap
#'
#' ## ENVIRONMENT
#'
#' - **`ZEEKPATH`**:   file search path
#' - **`ZEEK_PLUGIN_PATH`**:   plugin search path
#' - **`ZEEK_PLUGIN_ACTIVATE`**:   plugins to always activate
#' - **`ZEEK_PREFIXES`**:   prefix list
#' - **`ZEEK_DNS_FAKE`**:   disable DNS lookups
#' - **`ZEEK_SEED_FILE`**:   file to load seeds from
#' - **`ZEEK_LOG_SUFFIX`**:   ASCII log file extension
#' - **`ZEEK_PROFILER_FILE`**:   Output file for script execution statistics
#' - **`ZEEK_DISABLE_ZEEKYGEN`**:   Disable Zeekygen (Broxygen) documentation support
#'
#' ## AUTHOR
#'
#' **zeek** was written by The Zeek Project &lt;info@zeek.org>.
#'
#' @name zeek_man
#' @rdname zeek_man
#' @export
#' @examples
#' zeek_man()
#' man_zeek
#' ?zeek_man
zeek_man <- function() {
  help("zeek_man")
}

#' @rdname zeek_man
#' @export
man_zeek <- zeek_man