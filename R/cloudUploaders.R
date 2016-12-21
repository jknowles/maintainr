# Cloud handlers

#' Backup R package list
#'
#' @param backupPath The path to where \code{\link{savePkgs}} should write the
#' list of packages, optional
#' @param filename The name of the csv file to save the package names, optional
#' @param cloudProvider Optional, if specified the package will attempt to write
#' the package list to a tempfile and then upload that tempfile to a cloud service
#' @param ... Additional arguments to pass to \code{\link{writeCloud}}
#' @return Nothing
#' @export
#'
pkg_backup <- function(backupPath = NULL, filename = NULL,
                       cloudProvider = NULL, ...){
  if(missing(backupPath)){
    backupPath <- tempdir()
  }
  if(missing(filename)){
    filename <- paste0("RPackageBackup_", Sys.Date(), ".csv")
    fullFN <- file.path(backupPath, filename)
  }
  savePkgs(backupPath, filename=filename)
  if(missing(cloudProvider)){
    message("List of R packages backed up successfully")
    message(paste0("Package list saved at ", paste(backupPath, filename, sep = "/")))
  } else{
    writeCloud(filename = fullFN, provider = cloudProvider, ...)
    message(paste0("List of R packages backed up to ", cloudProvider))
  }
}

#' Restore R packages from a package list stored somewhere else
#'
#' @param install logical, should packages in the package list be installed?
#' @param backupPath The path to where \code{\link{savePkgs}} should write the
#' list of packages, optional
#' @param filename The name of the csv file to save the package names, optional
#' @param cloudProvider Optional, if specified the package will attempt to write
#' the package list to a tempfile and then upload that tempfile to a cloud service
#' @param libpath Path to the library
#' @param update A logical, should packages be updated first? Default is false
#' @param keep_all A logical, should all packages in pkgList not local be installed?
#' @param ... Additional arguments to pass to \code{\link{readCloud}}
#'
#' @return Nothing.
#' @export
pkg_restore <- function(install = TRUE, backupPath = NULL, filename = NULL,
                        cloudProvider = NULL, libpath = NULL, update = FALSE,
                        keep_all = FALSE, ...){
  if(!missing(cloudProvider)){
    pkgList <- readCloud(filename = filename, provider = cloudProvider, ...)
  } else {
    pkgList <- readPkgs(backupPath, filename=filename)
  }
  if(install){
    # First validate
    installPkgs(pkgList, libpath = libpath, update = update,
                keep_all = keep_all)
  } else{
    pkgList <- sync_pkgs(pkgList = pkgList, keep_all = keep_all)
    pkgList <- unique(pkgList[, 1])
    if(length(pkgList) < 1){
      message("All up to date.")
    } else{
      return(pkgList)
    }
  }
}

#' Cloud upload handler
#'
#' @param filename path and filename of file to be uploaded to cloud storage
#' @param provider a character for the provider to use, currently only "dropbox"
#' is supported
#' @param ... additional arguments to pass to the function that uploads the file
#'
#' @return Nothing.
#' @seealso \code{\link[rdrop2:drop_read_csv]{drop_upload}}
#' @export
writeCloud <- function(filename, provider = c("dropbox"), ...){
  provider <- match.arg(provider,
                        choices = c("dropbox"), several.ok = FALSE)
  if(provider == "dropbox"){
    requireNamespace("rdrop2", quietly = TRUE)
    rdrop2::drop_upload(file = filename, ...)
  }
}

#' Cloud fetch handler
#'
#' @param filename path to file to be uploaded to cloud storage
#' @param provider a character for the provider to use, currently only "dropbox"
#' is supported
#' @param ... additional arguments to pass to the function that uploads the file
#'
#' @return Nothing.
#' @seealso \code{\link[rdrop2:drop_read_csv]{drop_upload}}
#' @export
readCloud <- function(filename, provider = c("dropbox"), ...){
  provider <- match.arg(provider,
                        choices = c("dropbox"), several.ok = FALSE)
  if(provider == "dropbox"){
    requireNamespace("rdrop2", quietly = TRUE)
    rdrop2::drop_read_csv(file = filename, ...)
  }
}
