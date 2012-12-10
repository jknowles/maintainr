##' Save Packages
##'
##' Export package names to a CSV file to be restored later.
##'
##' @param path A string that lists a valid path for R to the place to export the list
##' of packages. Ideally to a remote backup solution.
##' @export
save_pkgs<-function(path){
  a<-library()$results
  write.csv(a[,1:2],file=paste0(path,"/pkglist.csv"),row.names=FALSE)
}


##' Read Packages
##'
##' Read package names from a CSV file to an R object.
##'
##' @param path A string that lists a valid path for R to the place to import the list
##' of packages. Ideally to a remote backup solution.
##' @export
read_pkgs<-function(path){
  read.csv(file=paste0(path,"/pkglist.csv"),stringsAsFactors=FALSE)
}

##' Restore Packages from a Backup
##'
##' Read package names from a CSV file to an R object.
##'
##' @param mypkgs An R vector of package names, ideally read in from \code{read_pkgs}
##' @param newLib A path to a valid directory where R can install the packages
##' @export
install_pkgs<-function(mypkgs,newlib){
  install.packages(mypkgs[,1],lib=newlib)
}

##' Add a new library
##'
##' Tell R where to find new packages in a new library in the current session.
##'
##' @param newLib A path to a valid directory where R has installed packages
add_new_lib<-function(newlib){
  .libPaths(c(.libPaths(),newlib))
}