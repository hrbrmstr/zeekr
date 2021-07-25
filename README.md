
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![R-CMD-check](https://github.com/hrbrmstr/zeekr/workflows/R-CMD-check/badge.svg)](https://github.com/hrbrmstr/zeekr/actions?query=workflow%3AR-CMD-check)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/zeekr.svg?branch=master)](https://travis-ci.org/hrbrmstr/zeekr)  
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.6.0-blue.svg)
![License](https://img.shields.io/badge/License-AGPL-blue.svg)

# zeekr

Tools to Make Analyses Using Zeek Easier

## Description

[Zeek](https://zeek.org/) is an open source network security monitoring
system. Tools are provided to make it a bit easier to work with Zeek to
perform analyses with R.

## What’s Inside The Tin

The following functions are implemented:

-   `find_zeek`: Find the Zeek binary
-   `get_zeek`: Get Zeek
-   `pcap_to_zeek`: Process a PCAP with Zeek and create Parquet files
-   `read_zeek_logs`: Read zeek logs from a processed PCAP into a list
-   `zeek_man`: Zeek Manual Page Quick Reference
-   `zeek_redefs`: (WIP) Common redefinitions for Zeek when processing
    PCAPs
-   `zeek`: Call the Zeek binary with optional custom environment
    variables and options

## Installation

``` r
remotes::install_git("https://git.rud.is/hrbrmstr/zeekr.git")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(zeekr)

# current version
packageVersion("zeekr")
## [1] '0.1.0'
```

``` r
loc <- pcap_to_zeek(system.file("pcap/ssh.pcap", package = "zeekr"))

list.files(loc)
## [1] "conn.parquet"          "packet_filter.parquet" "ssh.parquet"

zeek <- read_zeek_logs(loc)

str(zeek, 3)
## List of 3
##  $ conn         :Classes 'tbl_df', 'tbl' and 'data.frame':   49 obs. of  18 variables:
##   ..$ ts           : num [1:49] 1.32e+09 1.32e+09 1.32e+09 1.32e+09 1.32e+09 ...
##   ..$ uid          : chr [1:49] "CAmnTGoJHwg6hNFea" "CvHC1J1yB5yLVQuXR7" "CE6UIa40hIdUlMZCS2" "CK2bU24sjXqxWxiSpl" ...
##   ..$ id_orig_h    : chr [1:49] "172.16.238.1" "172.16.238.1" "172.16.238.1" "172.16.238.1" ...
##   ..$ id_orig_p    : int [1:49] 58389 58389 58389 58389 58397 58389 58389 58398 58389 58399 ...
##   ..$ id_resp_h    : chr [1:49] "172.16.238.135" "172.16.238.135" "172.16.238.135" "172.16.238.135" ...
##   ..$ id_resp_p    : int [1:49] 22 22 22 22 22 22 22 22 22 22 ...
##   ..$ proto        : chr [1:49] "tcp" "tcp" "tcp" "tcp" ...
##   ..$ duration     : num [1:49] 4.23 NA NA NA 17.78 ...
##   ..$ orig_bytes   : int [1:49] 0 NA NA NA 1733 NA NA 1733 NA 1589 ...
##   ..$ resp_bytes   : int [1:49] 0 NA NA NA 2007 NA NA 2007 NA 1943 ...
##   ..$ conn_state   : chr [1:49] "SH" "SH" "SH" "SH" ...
##   ..$ missed_bytes : int [1:49] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ history      : chr [1:49] "F" "F" "F" "F" ...
##   ..$ orig_pkts    : int [1:49] 6 1 1 1 21 1 1 21 1 19 ...
##   ..$ orig_ip_bytes: int [1:49] 312 52 52 52 2837 52 52 2837 52 2589 ...
##   ..$ resp_pkts    : int [1:49] 0 0 0 0 17 0 0 18 0 16 ...
##   ..$ resp_ip_bytes: int [1:49] 0 0 0 0 2899 0 0 2951 0 2783 ...
##   ..$ service      : chr [1:49] NA NA NA NA ...
##  $ packet_filter:Classes 'tbl_df', 'tbl' and 'data.frame':   1 obs. of  5 variables:
##   ..$ ts     : num 1.63e+09
##   ..$ node   : chr "zeek"
##   ..$ filter : chr "ip or not ip"
##   ..$ init   : logi TRUE
##   ..$ success: logi TRUE
##  $ ssh          :Classes 'tbl_df', 'tbl' and 'data.frame':   40 obs. of  17 variables:
##   ..$ ts             : num [1:40] 1.32e+09 1.32e+09 1.32e+09 1.32e+09 1.32e+09 ...
##   ..$ uid            : chr [1:40] "CUegdV3IvAoKWGu681" "Ci9sXu2lSlpqg3Au47" "Csw04n3ZhbvBDjJTNd" "C3qrkm4EaQi2uvlpD6" ...
##   ..$ id_orig_h      : chr [1:40] "172.16.238.1" "172.16.238.1" "172.16.238.1" "172.16.238.1" ...
##   ..$ id_orig_p      : int [1:40] 58395 58396 58397 58398 58399 58402 58403 58404 58405 58406 ...
##   ..$ id_resp_h      : chr [1:40] "172.16.238.168" "172.16.238.129" "172.16.238.136" "172.16.238.136" ...
##   ..$ id_resp_p      : int [1:40] 22 22 22 22 22 22 22 22 22 22 ...
##   ..$ version        : int [1:40] 2 2 2 2 2 2 2 2 2 2 ...
##   ..$ auth_success   : logi [1:40] TRUE TRUE FALSE FALSE FALSE FALSE ...
##   ..$ auth_attempts  : int [1:40] 3 1 2 2 1 2 2 2 4 2 ...
##   ..$ client         : chr [1:40] "SSH-2.0-OpenSSH_5.6" "SSH-2.0-OpenSSH_5.6" "SSH-2.0-OpenSSH_5.6" "SSH-2.0-OpenSSH_5.6" ...
##   ..$ server         : chr [1:40] "SSH-2.0-OpenSSH_5.3" "SSH-2.0-OpenSSH_5.3" "SSH-2.0-OpenSSH_5.8p1 Debian-7ubuntu1" "SSH-2.0-OpenSSH_5.8p1 Debian-7ubuntu1" ...
##   ..$ cipher_alg     : chr [1:40] "aes128-ctr" "aes128-ctr" "aes128-ctr" "aes128-ctr" ...
##   ..$ mac_alg        : chr [1:40] "hmac-md5" "hmac-md5" "hmac-md5" "hmac-md5" ...
##   ..$ compression_alg: chr [1:40] "none" "none" "none" "none" ...
##   ..$ kex_alg        : chr [1:40] "diffie-hellman-group-exchange-sha256" "diffie-hellman-group-exchange-sha256" "diffie-hellman-group-exchange-sha256" "diffie-hellman-group-exchange-sha256" ...
##   ..$ host_key_alg   : chr [1:40] "ssh-rsa" "ssh-rsa" "ssh-rsa" "ssh-rsa" ...
##   ..$ host_key       : chr [1:40] "a5:3c:40:6e:e8:bf:5d:09:79:c8:4b:2c:65:5f:eb:12" "a5:3c:40:6e:e8:bf:5d:09:79:c8:4b:2c:65:5f:eb:12" "87:11:46:da:89:c5:2b:d9:6b:ee:e0:44:7e:73:80:f8" "87:11:46:da:89:c5:2b:d9:6b:ee:e0:44:7e:73:80:f8" ...
```

## zeekr Metrics

| Lang | # Files |  (%) | LoC |  (%) | Blank lines |  (%) | # Lines |  (%) |
|:-----|--------:|-----:|----:|-----:|------------:|-----:|--------:|-----:|
| R    |       8 | 0.36 | 100 | 0.37 |          38 | 0.32 |     175 | 0.42 |
| YAML |       2 | 0.09 |  23 | 0.09 |           2 | 0.02 |       2 | 0.00 |
| Rmd  |       1 | 0.05 |  12 | 0.04 |          19 | 0.16 |      30 | 0.07 |
| SUM  |      11 | 0.50 | 135 | 0.50 |          59 | 0.50 |     207 | 0.50 |

clock Package Metrics for zeekr

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
