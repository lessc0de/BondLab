  # Bond Lab is a software application for the analysis of 
  # fixed income securities it provides a suite of applications
  # mortgage backed, asset backed securities, and commerical mortgage backed 
  # securities Copyright (C) 2016  Bond Lab Technologies, Inc.
  # 
  # This program is free software: you can redistribute it and/or modify
  # it under the terms of the GNU General Public License as published by
  # the Free Software Foundation, either version 3 of the License, or
  # (at your option) any later version.
  # 
  # This program is distributed in the hope that it will be useful,
  # but WITHOUT ANY WARRANTY; without even the implied warranty of
  # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  # GNU General Public License for more details.  
  #
  # You should have received a copy of the GNU General Public License
  # along with this program.  If not, see <http://www.gnu.org/licenses/>.


  
  #' @title Is leap year
  #' @family BondBasis
  #' @description Tests if year is a leap year and reurns TRUE or FALSE
  #' @param year The year to test as leap year
  #' @export
  is.leapyear=function(year){
    #http://en.wikipedia.org/wiki/Leap_year
    return(((year %% 4 == 0) & (year %% 100 != 0)) | (year %% 400 == 0))}
  
  #' @title Actual/Actual day count
  #' @family BondBasis
  #' @description Calculates actual days using leap year IDSA method
  #' @param settlement.date The settlement date
  #' @param nextpmt.date The next scheduled interest payment date
  #' @export
  ActualFactor = function(settlement.date, nextpmt.date){
    actual.factor = NULL
    new.year.date = as.Date(paste0(year(nextpmt.date),"/01/01"))
    year.settlement.leap = is.leapyear(year(settlement.date))
    year.payment.leap = is.leapyear(year(nextpmt.date))
    test.leap = year.settlement.leap + year.payment.leap
    
    if(test.leap == 0) actual.factor = as.numeric(
      difftime(nextpmt.date, settlement.date, units = "days"))/360
    
    if(test.leap == 1 | year.settlement.leap == TRUE) actual.factor = sum(
      as.numeric(difftime(new.year.date, settlement.date, units = 'days'))/366,
      as.numeric(difftime(nextpmt.date, new.year.date, units = 'days'))/365)
    
    if(test.leap == 1 | year.settlement.leap == FALSE) actual.factor = sum(
      as.numeric(difftime(new.year.date, settlement.date, units = 'days'))/365,
      as.numeric(difftime(nextpmt.date, new.year.date, units = 'days'))/366)
    
    if(test.leap == 2) actual.factor = as.numeric(
      difftime(nextpmt.date, settlement.date, units = "days"))/365
    
  return(actual.factor)
  }
  
  #'@title Act/Act day count 
  #'@family BondBasis
  #'@description Calculate Act/Act factor IMCA. used for UST corporates, etc
  #'@param settlement.date the settlement date
  #'@param lastpmt.date the last payment bond coupon and or principal payment date 
  #'@param nextpmt.date the next bond coupon and or principal payment date
  #'@export
  ActFactor = function(settlement.date, lastpmt.date, nextpmt.date){
    Actual.Factor = NULL
    Actual.Factor = as.numeric(difftime(nextpmt.date, settlement.date,  units = 'days')/365)
    return(Actual.Factor)
  }
  
  #----------------------------
  #Bond basis function This function set the interest payment day count basis 
  #----------------------------
  # Note use switch to add additional basis default will be 30/360
  
  #' @title Bond Basis (day count) conventions
  #' @family BondBasis
  #' @description Applies the correct bond basis (day count) convention to interest
  #' calculations. Currently supported bond day count conventions:
  #' \itemize{
  #' \item{'30360' }{Agency MBS}
  #' \item{'30E360' }{European 30360}
  #' \item{'Actual360' }{used in money market}
  #' \item{'Actual365' }{}
  #' \item{'ActualActual' }
  #' }
  #' @param issue.date A character value the issue date of the security 'mm-dd-YYY'.
  #' @param start.date A character value the start date for interest payment
  #'  (dated date) 'mm-dd-YYYY'.
  #' @param end.date A character value the final payment date 'mm-dd-YYYY'.
  #' @param settlement.date A character value the settlement date 'mm-dd-YYYY'
  #' @param lastpmt.date  A character value the last payment date to the investor 'mm-dd-YYYY'
  #' @param nextpmt.date A character value the next payment date to the investor 'mm-dd-YYYY'
  #' @param type a character vector the interest basis day count type
  #' @importFrom lubridate year
  #' @importFrom lubridate month
  #' @export
  BondBasisConversion <- function(issue.date, 
                                  start.date, 
                                  end.date, 
                                  settlement.date,
                                  lastpmt.date, 
                                  nextpmt.date,
                                  type){
  # This function converts day count to bond U.S. Bond Basis 30/360 day count
  #  calculation. It returns the number of payments that will be received, 
  #  period, and n for discounting
  # issue.date is the issuance date of the bond
  # start.date is the dated date of the bond
  # end.date is the maturity date of the bond
  # settlement.date is the settlement date of the bond
  # lastpmt.date is the last coupon payment date
  # nextpmt.date is the next coupon payment date


    d1 <- ifelse(settlement.date == issue.date, day(issue.date), day(settlement.date))    
    m1 <- ifelse(settlement.date == issue.date, month(issue.date), month(settlement.date))
    y1 <- ifelse(settlement.date == issue.date, year(issue.date), year(settlement.date))
    d2 <- day(nextpmt.date)
    m2 <- month(nextpmt.date)
    y2 <- year(nextpmt.date)


  switch(type,
  "30360" = (max(0, 30 - d1) + min(30, d2) + 360*(y2-y1) + 30*(m2-m1-1))/360,
  "30E360"= (max(0, 30 - ifelse(d1 > 30, 30, d1)) +  
               min(30, ifelse(d2 > 30, 30, d2)) + 
               360*(y2-y1) + 30*(m2-m1-1))/360,
  "Actual360" = as.numeric(difftime(nextpmt.date, settlement.date, units = "days"))/360,
  "Actual365" = as.numeric(difftime(nextpmt.date, settlement.date, units = "days"))/365,
  "ActualActual" = ActualFactor(settlement.date = settlement.date, nextpmt.date = nextpmt.date),
  "ActAct" = ActFactor(settlement.date = settlement.date, nextpmt.date = nextpmt.date, lastpmt.date = lastpmt.date)
  ) # end of switch function
  } # end of function
