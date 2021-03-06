% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SEARCH-Kernel-Utility.R
\name{MicroKernel_FitBeta}
\alias{MicroKernel_FitBeta}
\title{MICRO Kernels: Fit Beta Parameters}
\usage{
MicroKernel_FitBeta(mean, cv)
}
\arguments{
\item{mean}{desired mean of Beta distribution (must be between 0 and 1)}

\item{cv}{desired coefficient of variation of Beta distribution (0,inf)}
}
\value{
list; alpha (shape1) and beta (shape2) parameters of Beta distribution
}
\description{
Fit parameters of a Beta distribution such that it will have a given mean and coefficient of variation.
}
