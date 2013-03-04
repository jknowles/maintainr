\name{installPkgs}
\alias{installPkgs}
\title{Restore Packages from a Backup}
\usage{
  installPkgs(mypkgs, newlib)
}
\arguments{
  \item{mypkgs}{An R vector of package names, ideally read
  in from \code{\link{read_pkgs}}}

  \item{newlib}{A path to a valid directory where R can
  install the packages}
}
\description{
  Read package names from a CSV file to an R object.
}

