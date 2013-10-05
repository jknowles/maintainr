##' Write a new .Rprofile
##'
##' Export a custom .Rprofile for syncing between installs.
##' 
##' @param pkglist A pkglist produced by \code{\link{savePkgs}}
##' @seealso \url{http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows}
writeProfile<-function(pkglist){
  dir.create("tmp")
  sink('tmp/.Rprofile',append=TRUE)
  cat(".First<-function(){")
  cat("\n")
  for(i in 1:length(pkglist)){
  cat("library(",pkglist[i],")",sep="")
  cat("\n")
}
  cat("}")
  cat("\n")
  cat(".Last<-function(){")
  cat("\n")
  cat("cat('\n Goodbye at ',date(),'\n')")
  cat("\n")
  cat("}")
  cat("\n")
  sink()
}

