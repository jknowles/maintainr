mylist<-c("ggplot2","eeptools","plyr")

write.profile<-function(pkglist){
  #dir.create('tmp')
#   catf <- function(..., file="tmp/.Rprofile", append=TRUE){
#     cat(..., file=file, append=append)
#   }
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

write.profile(mylist)

dir.create('tmp')
sink('tmp/.Rprofile')
cat(".First<-function(){")
cat("\n")
cat("library(ggplot2)")
cat("\n")
cat("}")
cat("\n")
cat(".Last<-function(){")
cat("\n")
cat("cat('\n Goodbye at ',date(),'\n')")
cat("\n")
cat("}")
cat("\n")
sink()

file.show("tmp/.Rprofile")

readLines(con="tmp/.Rprofile",n=1)


.Last <- function(){
  pkgs <- installed.packages()[,1]
  if (length(pkgs) > length(installed)){
    save(pkgs,file="G:\Setinfo\R\packagelist.RData")
  }
}
