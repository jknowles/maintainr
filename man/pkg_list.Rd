% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg_list.R
\name{pkg_list}
\alias{pkg_list}
\title{Extract a list of installed packages and format it}
\usage{
pkg_list()
}
\value{
A data.frame with three columns, Package, LibPath, and Version
}
\description{
Extract a list of installed packages and format it
}
\examples{
myPkgs <- pkg_list()
head(myPkgs)
}

