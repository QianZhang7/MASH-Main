% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MBITES-Complex-Setup.R
\name{MBITES.Complex.Setup}
\alias{MBITES.Complex.Setup}
\title{M-BITES: Initialize Additional Methods & Fields in \code{\link{MosquitoPopFemale}} and \code{\link{MosquitoFemale}}}
\usage{
MBITES.Complex.Setup(overwrite = TRUE, aquaModule = "emerge",
  timing = "exponential")
}
\arguments{
\item{batchSize}{character switch in \code{"bms","norm"} for egg batch sizes dependent on bloodmeal size or normally distributed}

\item{eggMatT}{character switch in \code{"off","norm"} for egg batch maturation time turned off or normally distributed}
}
\value{
writes methods to \code{\link{MosquitoFemale}} and \code{\link{MosquitoMale}} classes.
}
\description{
Initialize M-BITES lifecycle model (complex form). This model includes:
\itemize{
\item Blood Feeding Search Bout: see \code{\link{mbites_boutF}}
\item Blood Feeding Attempt Bout: see \code{\link{mbites_boutB}}
\item Post-Prandial Resting Bout: see \code{\link{mbites_boutR}}
\item Egg Laying Search Bout: see \code{\link{mbites_boutL}}
\item Egg Laying Attempt Bout: see \code{\link{mbites_boutO}}
\item Sugar Feeding Attempt Bout: see \code{\link{mbites_boutS}}
\item Mating Bout: see \code{\link{mbites_boutM}}
}
}
