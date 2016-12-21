##' Save Packages
##'
##' Export package names to a CSV file to be restored later.
##'
##' @param path A string that lists a valid path for R to the place to export the list
##' of packages. Ideally to a remote backup solution.
##' @param filename a name of a csv file to save the package list to
##' @export
save_pkgs <- function(path, filename){
  pkgList <- pkg_list()
  write.csv(pkgList, file = paste0(path,"/", filename),
            row.names = FALSE)
}

#' Extract a list of installed packages and format it
#'
#' @return A data.frame with three columns, Package, LibPath, and Version
#' @export
#'
#' @examples
#' myPkgs <- pkg_list()
#' head(myPkgs)
pkg_list <- function(){
  pkgList <- as.data.frame(installed.packages())
  pkgList <- pkgList[, 1:3]
  pkgList <- sapply(pkgList, as.character)
  pkgList <- as.data.frame(pkgList, stringsAsFactors = FALSE)
  return(pkgList)
}

#' Check versions to install only newer packages
#'
#' @param pkgList A new list of packages
#' @param keep_all logical, should all packages in the new list that are not
#' installed on the system get synced up
#'
#' @return A list of packages to be installed that are not installed or out of date
#' @export
sync_pkgs <- function(pkgList, keep_all = TRUE){
  if(!all(names(pkgList) %in% c("Package", "LibPath", "Version"))){
    stop("Your package list must have columns Package, LibPath, Version")
  }
  old <- pkg_list()
  installList <- merge(old, pkgList, by = c("Package", "Version"),
                       all.y = keep_all)
  installList$flag <- installList$LibPath.x != installList$LibPath.y
  installList <- installList[installList$flag, c(1, 4, 2)]
  if(nrow(installList) < 1){
    message("All local packages up to date with remote")
  }
  names(installList) <- c("Package", "LibPath", "Version")
  return(installList)
}



##' Read Packages
##'
##' Read package names from a CSV file to an R object.
##'
##' @param path A string that lists a valid path for R to the place to import the list
##' @param filename A string that denotes the filename where the packages are stored
##' of packages. Ideally to a remote backup solution.
##' @export
read_pkgs <- function(path, filename){
    read.csv(file=paste0(path,"/", filename), stringsAsFactors=FALSE)
  # check formatting is correct
}

##' Restore Packages from a Backup
##'
##' Read package names from a CSV file to an R object.
##'
##' @param pkgList An R vector of package names, ideally read in from \code{\link{read_pkgs}}
##' @param libpath A path to a valid directory where R can install the packages
##' @param update A logical, should packages be updated first? Default is false
##' @param keep_all A logical, should all packages in pkgList not local be installed?
##' @param ... additional arguments to pass to \code{\link{sync_pkgs}}
##' @export
install_pkgs <- function(pkgList, libpath = NULL, update = FALSE, keep_all = TRUE){
  if(update){
    update.packages(ask=FALSE)
  }
  pkgList <- sync_pkgs(pkgList = pkgList, keep_all = keep_all)
  pkgList <- unique(pkgList[, 1])
  if(missing(libpath)){
    message("No libpath specified, defaulting to first .libPaths() entry")
    libpath <- .libPaths()[1]
  }
  if(length(pkgList) < 1){
    message("All packages are up to date")
  } else{
    install.packages(pkgList, lib = libpath)
  }

}

##' Add a new library
##'
##' Add the new library to the R .libPaths() list.
##'
##' @param newlib A path to a valid directory where R has installed packages
addNewLib <- function(newlib){
  .libPaths(c(.libPaths(), newlib))
}

##' Set the library
##'
##' Tell R where to find new packages in a new library in the current session.
##' @author Tal Galili
##' @seealso \url{http://www.r-statistics.com/2010/04/changing-your-r-upgrading-strategy-and-the-r-code-to-do-it-on-windows/}
setLibrary <- function(){
  if(grepl("/", R.home(), fixed = T))
  { R_parent_lib <- paste(head(strsplit(R.home(), "/", fixed = T)[[1]], -1), collapse = "/") }
  if(grepl("\\", R.home(), fixed = T))
  { R_parent_lib <- paste(head(strsplit(R.home(), "\\", fixed = T)[[1]], -1), collapse = "/") }
  # if global.library.folder isn't defined, then we assume it is of the form: "C:\\Program Files\\R\\library"
  #R_parent_lib <- paste(head(strsplit(R.home(), "/", fixed = T)[[1]], -1), collapse = "/")
  global.library.folder <- paste(R_parent_lib, "/lib", sep = "")

  Renviron.site.loc <- paste(R.home(), "\\etc\\Renviron.site", sep = "")
  if(!file.exists(Renviron.site.loc))
  {  # If "Renviron.site" doesn't exist (which it shouldn't be) - create it and add the global lib line to it.
    cat(paste("R_LIBS='",global.library.folder, "'\n",sep = "") ,
        file = Renviron.site.loc)
    cat(paste("The file:" , Renviron.site.loc, "didn't exist - we created it and added your 'Global library link' (",global.library.folder,") to it.\n"))
  } else {
    cat(paste("The file:" , Renviron.site.loc, "existed and we could NOT add some lines!  make sure you add the following line by yourself:","\n"))
    cat(paste("R_LIBS=",global.library.folder,"\n", sep = "") )
    cat(paste("To the file:",Renviron.site.loc,"\n"))
  }
}
