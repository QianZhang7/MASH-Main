% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MBITES-Generic-Setup.R
\name{MBITES.Generic.Setup}
\alias{MBITES.Generic.Setup}
\title{Initialize Generic Methods for M-BITES}
\usage{
MBITES.Generic.Setup(overwrite = TRUE, tattering = "mean",
  energy = "mean", batchSize = "bms", eggMatT = "off")
}
\arguments{
\item{tattering}{character switch in \code{"mean","exact"}, mean will sample wing tattering from \code{\link{mbitesGeneric_rTatterSize}} regardless of flight distance}

\item{energy}{character switch in \code{"mean","exact"}, mean will sample energy consumption}

\item{batchSize}{character switch in \code{"bms","norm"} for egg batch sizes dependent on bloodmeal size or normally distributed}

\item{eggMatT}{character switch in \code{"off","norm"} for egg batch maturation time turned off or normally distributed}
}
\value{
writes methods to \code{\link{MosquitoFemale}} and \code{\link{MosquitoMale}} classes.
}
\description{
This function initializes generic methods for M-BITES models; please note that the
switches for this function modify only the methods that are added to the \code{\link{MosquitoFemale}}
and \code{\link{MosquitoMale}} classes.
}
