##' Save Packages
##'
##' Export package names to a CSV file to be restored later.
##'
##' @param path A string that lists a valid path for R to the place to export the list
##' of packages. Ideally to a remote backup solution.
##' @param filename a name of a csv file to save the package list to
##' @export
savePkgs <- function(path, filename){
  pkgList <- library()$results
  write.csv(pkgList[,1:2], file = paste0(path,"/", filename),
            row.names = FALSE)
}


##' Read Packages
##'
##' Read package names from a CSV file to an R object.
##'
##' @param path A string that lists a valid path for R to the place to import the list
##' @param filename A string that denotes the filename where the packages are stored
##' of packages. Ideally to a remote backup solution.
##' @export
readPkgs <- function(path, filename){
    read.csv(file=paste0(path,"/", filename), stringsAsFactors=FALSE)
  # check formatting is correct
}

##' Restore Packages from a Backup
##'
##' Read package names from a CSV file to an R object.
##'
##' @param mypkgs An R vector of package names, ideally read in from \code{\link{readPkgs}}
##' @param libpath A path to a valid directory where R can install the packages
##' @param update A logical, should packages be updated first? Default is false
##' @export
installPkgs <- function(mypkgs, libpath = NULL, update = FALSE){
  if(update){
    update.packages(ask=FALSE)
  }
  list <- unique(mypkgs[, 1])
  if(missing(libpath)){
    message("No libpath specified, defaulting to first .libPaths() entry")
    libpath <- .libPaths()[1]
  }
  install.packages(list, lib = libpath)
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
