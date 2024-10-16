#' Moses Farley
#' A function to get data from the example Rice Rivers Center used in class
#' This function convert the DateTime column to an actual POSIXct date-time object,
#' creates new columns for month, day, and weekday, properly ordered, and standardizes
#' any units that need to be standardized
#'
library( dplyr )
library( knitr )
library( lubridate)
get_rice_data <- function() {
  url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"
  rice <- read.csv( url ) 
  rice <- rice %>%
    mutate(DateTime = mdy_hms(DateTime)) #use lubridate to convert to datetime object
  #TODO: I could probably combine the arguments of the two mutate call into one...
  rice <- rice %>%
    mutate(
      #factor class kinda works like enums in java. Below its used to categorize months and weekdays
      # and rank them in the order they appear. Presumably, earlier dates appear sequentially, so I
      # didn't specify any levels
      Month = factor(month(DateTime, label = TRUE, abbr = TRUE), ordered = TRUE),  # ordered month
      Day = day(DateTime),
      Weekday = factor(wday(DateTime, label = TRUE, abbr = TRUE), ordered = TRUE),  # ordered weekday
      H2O_TempF = H2O_TempC*(9/5)+32 #I believe this is the only conversion I need
    )
  #NOTE: I didn't delete any columns. I don't know use cases for recordID right not, but may need it
  return( rice )
}