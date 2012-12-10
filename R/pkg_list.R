
save_pkgs<-function(path){
  a<-library()$results
  write.csv(a[,1:2],file=paste0(path,"/pkglist.csv"),row.names=FALSE)
}

read_pkgs<-function(path){
  read.csv(file=paste0(path,"/pkglist.csv"),stringsAsFactors=FALSE)
}

install_pkgs<-function(mypkgs,newlib){
  install.packages(mypkgs[,1],lib=newlib)
}


add_new_lib<-function(newlib){
  .libPaths(c(.libPaths(),newlib))
}