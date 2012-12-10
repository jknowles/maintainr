# Workflow

# Backup

# User defines:

droppath<-"C:/Users/Jared/Dropbox/Apps/maintainr"

newLib<-"C:/R/lib"

save_pkgs<-function(path){
  a<-library()$results
  write.csv(a[,1:2],file=paste0(path,"/pkglist.csv"),row.names=FALSE)
}

save_pkgs(droppath)

read_pkgs<-function(path){
  read.csv(file=paste0(path,"/pkglist.csv"),stringsAsFactors=FALSE)
}

a<-read_pkgs(droppath)
head(a)


install_pkgs<-function(mypkgs,newlib){
  install.packages(mypkgs[,1],lib=newlib)
}

install_pkgs(a,newLib)

# Remove old libs

add_new_lib<-function(newlib){
  .libPaths(c(.libPaths(),newlib))
}

add_new_lib(newLib)

Sys.setenv("R_LIBS_SITE" = newLib )

identical(Sys.getenv("R_LIBS_SITE"),newLib)

# http://www.r-statistics.com/wp-content/uploads/2010/04/upgrading-R-on-windows.r.txt
# http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows

set_library<-function(){
  if(grepl("/", R.home(), fixed = T))
  { R_parent_lib <- paste(head(strsplit(R.home(), "/", fixed = T)[[1]], -1), collapse = "/") }
  if(grepl("\\", R.home(), fixed = T))
  { R_parent_lib <- paste(head(strsplit(R.home(), "\\", fixed = T)[[1]], -1), collapse = "/") }
  # if global.library.folder isn't defined, then we assume it is of the form: "C:\\Program Files\\R\\library"
  #R_parent_lib <- paste(head(strsplit(R.home(), "/", fixed = T)[[1]], -1), collapse = "/")
  global.library.folder <- paste(R_parent_lib, "/lib", sep = "")

  Renviron.site.loc <- paste(R.home(), "\\etc\\Renviron.site", sep = "")
  if(!file.exists(Renviron.site.loc))
    {	# If "Renviron.site" doesn't exist (which it shouldn't be) - create it and add the global lib line to it.
    cat(paste("R_LIBS='",global.library.folder, "'\n",sep = "") ,
      file = Renviron.site.loc)				 
    cat(paste("The file:" , Renviron.site.loc, "didn't exist - we created it and added your 'Global library link' (",global.library.folder,") to it.\n"))
} else {
  cat(paste("The file:" , Renviron.site.loc, "existed and we could NOT add some lines!  make sure you add the following line by yourself:","\n"))
  cat(paste("R_LIBS=",global.library.folder,"\n", sep = "") )
  cat(paste("To the file:",Renviron.site.loc,"\n"))
}
}

.Library.site
.Library.site <- file.path(chartr("\\", "/", R.home()), "site-library")


