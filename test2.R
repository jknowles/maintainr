# Set up the dropbox 2

library(devtools)
install_github("ROAuth","duncantl")
install_github("rDrop","karthikram")

library(RCurl)

library(rDrop)

options(RCurlOptions=list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),verbose=TRUE))

dropbox_credentials2<-dropbox_auth('n8n6tq2a8h2jgb5','3822v57fu9qm8ka',.opts=list(cainfo = 
                                                                                   system.file("CurlSSL", "cacert.pem", package = "RCurl"),verbose=TRUE))
# Credentials 2 is the full app
# Credentials 1 is the folder only

dropbox_acc_info(dropbox_credentials2)
dropbox_dir(dropbox_credentials2)


file2<-dropbox_get(dropbox_credentials,"Apps/maintainr/midwest_district_probability.csv",binary=FALSE)
exists.in.dropbox(dropbox_credentials,"/Apps/maintainr",is_dir=TRUE)

