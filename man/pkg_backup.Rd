% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cloudUploaders.R
\name{pkg_backup}
\alias{pkg_backup}
\title{Backup R package list}
\usage{
pkg_backup(backupPath = NULL, filename = NULL, cloudProvider = NULL, ...)
}
\arguments{
\item{backupPath}{The path to where \code{\link{save_pkgs}} should write the
list of packages, optional}

\item{filename}{The name of the csv file to save the package names, optional}

\item{cloudProvider}{Optional, if specified the package will attempt to write
the package list to a tempfile and then upload that tempfile to a cloud service}

\item{...}{Additional arguments to pass to \code{\link{write_cloud}}}
}
\value{
Nothing
}
\description{
Backup R package list
}

