
Introducing maintainr
=====================

Functions to synchronize package installation and libraries across multiple computers on multiple platforms. This workflow should also make upgrading R on Windows much more straightforward, and allow for the synchronization of packages among versions of R on the same machine or across machines.

The basic workflow is simple, but the idea of the package is to create a way to allow lots of flexibility to users--such as composing and synchronizing an RProfile and Renviron file within R.

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

Why would you want to backup packages?

``` r
myPkgs <- pkg_list()
kable(head(myPkgs))
```

I want to keep this in sync across two machines:

``` r
pkg_backup(cloudProvider = "dropbox", dest = "/zzz")
```

This stores a csv file in the specified location.

Now let's sync/restore.

``` r
out <- pkg_restore(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   cloudProvider = "dropbox", install = FALSE)
head(out)

pkgList <- readCloud(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   provider = "dropbox")

sync_pkgs(pkgList = pkgList, keep_all = TRUE)

out <- pkg_restore(filename="zzz/RPackageBackup_2016-12-08.csv", 
                   cloudProvider = "dropbox", install = FALSE)
head(out)
```

Can install.

The first step is to get a csv file of installed packages (so it is human readable as well) with the function `savePkgs()`.

``` r
# For example
PATH <- "Path/To/My/Dropbox"
savePkgs(PATH, "mypkglist.csv")
```

After packages have been stored, then the user can restore the installed packages either to a new library (to create a sitewide library for example) or on a new machine, using the following workflow:

    PATH <- "Path/to/My/Packagefile"

    mypkgs <- readPkgs(PATH, "mypkglist.csv")

    newlib <- "Path/to/new/pkg_library"

    installPkgs(mypkgs,newlib)

    addNewLib(newlib)

Workflow
--------

### Backup

``` r
# Backup

# User defines:
pkgBackupPath <- "/path/to/my/"
newlib <- "C:/R/lib"

savePkgs(pkgBackupPath, filename='backup.csv')

pkgList <- read_pkgs(pkgBackupPath, filename='backup.csv')
head(pkgList)

installPkgs(pkgList, newLib)

# Remove old libs
addNewLib(newLib)

Sys.setenv("R_LIBS_SITE" = newLib)
identical(Sys.getenv("R_LIBS_SITE"), newLib)
```

Backup R Configuration Files
----------------------------

After we have installed the packages into a new library, we need to tell R how to find that library. For now, the options to do this are quite limited. The best way is to borrow the code from [Tal Galili](http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows) to create a new .Renviron file. Currently this function only allows for a library that is in the parent of the R home directory, but will be updated soon to fix this:

``` r
setLibrary()
```

Once this is done, when R is restarted, the new library will be the default library. Cleaning out old libraries will need to be handled by a separate function yet to be written.

To Do
-----

-   Write a package vignette
-   Unit tests?
-   Sync R Profile Site
-   Make Renviron point to library independently
-   Make setting the R library path independent
-   Allow R to create the path specified if the file does not exist
-   Prompt user to confirm path creation
-   Update libraries
-   Set R Profile Site configuration

### Links that help

[Upgrading R on Windows](http://www.r-statistics.com/wp-content/uploads/2010/04/upgrading-R-on-windows.r.txt)

[Install New R on Windows](http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows)

### Contributing

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
