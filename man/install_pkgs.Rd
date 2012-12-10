\name{install_pkgs}
\alias{install_pkgs}
\title{Restore Packages from a Backup}
\usage{
  install_pkgs(mypkgs, newlib)
}
\arguments{
  \item{mypkgs}{An R vector of package names, ideally read
  in from \code{read_pkgs}}

  \item{newLib}{A path to a valid directory where R can
  install the packages}
}
\description{
  Read package names from a CSV file to an R object.
}

