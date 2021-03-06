
[![Travis-CI Build Status](https://travis-ci.org/jknowles/maintainr.svg?branch=master)](https://travis-ci.org/jknowles/maintainr)

maintainr
=========

Stupid simple R package installation tracking.

Introduction
------------

`maintainr` is a simple package with a simple goal -- to produce an export of installed packages on an R installation and read in that export from another R installation. Currently, `maintainr` provides the ability to backup this list of installed packages and their version to a Dropbox account via the excellent `rdrop2` package.

This package is not meant to be a way to standardize installs for production systems. Instead, it is to solve two specific problems I have with using R:

1.  Upgrading my R installation seamlessly on Windows
2.  Keeping track of installed packages across multiple machines used for analysis (work, home, virtual test environment)

Installation
------------

To install `maintainr`:

``` r
library(devtools)
install_github("jknowles/maintainr")
library(maintainr)
```

Backup Packages
---------------

``` r
library(maintainr)
myPkgs <- pkg_list()
knitr::kable(head(myPkgs))
```

|           | Package   | LibPath  | Version |
|-----------|:----------|:---------|:--------|
| abind     | abind     | C:/R/lib | 1.4-5   |
| acepack   | acepack   | C:/R/lib | 1.4.1   |
| ada       | ada       | C:/R/lib | 2.0-5   |
| AER       | AER       | C:/R/lib | 1.2-4   |
| Amelia    | Amelia    | C:/R/lib | 1.7.4   |
| animation | animation | C:/R/lib | 2.4     |

I want to keep this in sync across two machines so I store the list of installed packages to a central location.

``` r
pkg_backup(cloudProvider = "dropbox", dest = "/zzz")
```

This stores a csv file in the specified location.

Now I can sync or restore.

``` r
# Path for dropbox is from the root of the Dropbox directory
out <- pkg_restore(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   cloudProvider = "dropbox", install = FALSE)
head(out)

pkgList <- read_cloud(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   provider = "dropbox")

sync_pkgs(pkgList = pkgList, keep_all = TRUE)

out <- pkg_restore(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   cloudProvider = "dropbox", install = FALSE)
head(out)
```

Functions
---------

-   `pkg_list`
-   `pkg_backup`
-   `save_pkgs`
-   `read_pkgs`
-   `install_pkgs`
-   `sync_pkgs`
-   `read_cloud`
-   `write_cloud`

Backup R Configuration Files
----------------------------

Coming soon...

To Do
-----

-   Write a package vignette
-   Unit tests?
-   Sync R Profile Site
-   Make Renviron point to library independently
-   Make setting the R library path independent
-   Set R Profile Site configuration

### Links that help

[Upgrading R on Windows](http://www.r-statistics.com/wp-content/uploads/2010/04/upgrading-R-on-windows.r.txt)

[Install New R on Windows](http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows)

### Contributing

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
