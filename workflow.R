# Workflow

# Backup

# User defines:

droppath<-"C:/Users/Jared/Dropbox/Apps/maintainr"

newlib<-"C:/R/lib"

savePkgs<-function(path){
  a<-library()$results
  write.csv(a[,1:2],file=paste0(path,"/pkglist.csv"),row.names=FALSE)
}

savePkgs(droppath)

readPkgs<-function(path){
  read.csv(file=paste0(path,"/pkglist.csv"),stringsAsFactors=FALSE)
}

a<-read_pkgs(droppath)
head(a)


install_pkgs<-function(mypkgs,newlib){
  install.packages(mypkgs[,1],lib=newlib)
}

installPkgs(a,newLib)

# Remove old libs

add_new_lib<-function(newlib){
  .libPaths(c(.libPaths(),newlib))
}

addNewLib(newLib)

Sys.setenv("R_LIBS_SITE" = newLib )

identical(Sys.getenv("R_LIBS_SITE"),newLib)

# http://www.r-statistics.com/wp-content/uploads/2010/04/upgrading-R-on-windows.r.txt
# http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows

setLibrary<-function()



