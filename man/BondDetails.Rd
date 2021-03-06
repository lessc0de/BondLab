% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BondDetails.R
\name{BondDetails}
\alias{BondDetails}
\title{BondDetails}
\usage{
BondDetails(Cusip = "character", ID = "character", BondType = "character",
  Sector = "character", Issuer = "character", Underwriter = "character",
  OfferAmount = numeric(), Coupon = numeric(), IssueDate = "character",
  DatedDate = "character", Maturity = "character",
  LastPmtDate = "character", NextPmtDate = "character",
  Moody = "character", SP = "character", BondLab = "character",
  Frequency = numeric(), BondBasis = "character", Callable = "logical",
  Putable = "logical", SinkingFund = "logical")
}
\arguments{
\item{Cusip}{A character the bond cusip}

\item{ID}{a character the bond id}

\item{BondType}{A character the type of bond MBS, Bond, etc.}

\item{Sector}{A character the description of the sector}

\item{Issuer}{A character the Issuer}

\item{Underwriter}{A character the Underwriter}

\item{OfferAmount}{A numeric value the initial offer amount}

\item{Coupon}{A numeric value the bond coupon}

\item{IssueDate}{A character the issue date mm-dd-YYYY}

\item{DatedDate}{A character the dated date mm-dd-YYYY}

\item{Maturity}{A character the maturity date mm-dd-YYYY}

\item{LastPmtDate}{A character the last scheduled payment date to the
investor mm-dd-YYYY}

\item{NextPmtDate}{A character the next scheduled payment date to the 
investor mm-dd-YYYY}

\item{Moody}{A character the Moody Rating}

\item{SP}{A character the SP Rating}

\item{BondLab}{A character the BondLab (Investor) assigned rating}

\item{Frequency}{A numeric value the frequency (number) of payments made
each year}

\item{BondBasis}{A character the interest calculation basis}

\item{Callable}{A logical TRUE if the bond is callable}

\item{Putable}{A logical TRUE if the bond is putable}

\item{SinkingFund}{A logical TRUE if the bond is sinking fund bond}
}
\description{
BondDetails creates a BondDetails cusip object in the 
local environment
}
\seealso{
Other BondDetails: \code{\link{MakeBondDetails}}
}

