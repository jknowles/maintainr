a<-library()
a<-a$results
mypkgs<-a[,1]

mylibs<-a[,2]

print(update.packages)

get_mylibraries<-function(){
  a<-library()$results
  cat("The following libraries are available on your machine: \n")
  return(unique(a[,2]))
}

get_mypackages<-function(){
  a<-library()$results
  print("The following packages are installed on your machine:")
  return(a[,1])
}

save_pkgs<-function(){
  a<-library()$results
  write.csv(a[,1:2],file="tmp/pkglist.csv",row.names=FALSE)
}

read_pkgs<-function(){
  # Get list from dropbox
}

a<-read.csv(file="tmp/pkglist.csv")

install_pkgs<-function(a){
  b<-library()$results
  
  
  
}

