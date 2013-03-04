\name{savePkgs}
\alias{savePkgs}
\title{Save Packages}
\usage{
  savePkgs(path, filename)
}
\arguments{
  \item{path}{A string that lists a valid path for R to the
  place to export the list of packages. Ideally to a remote
  backup solution.}

  \item{filename}{a name of a csv file to save the package
  list to}
}
\description{
  Export package names to a CSV file to be restored later.
}

