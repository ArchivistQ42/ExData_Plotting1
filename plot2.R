## Global Active Power Over Time

library(dplyr)
library(lubridate)

#Read in data and mutate date variable
eleData <- read.table("household_power_consumption.txt", 
                      header = TRUE, 
                      sep = ";")
eleData <- eleData %>% mutate(Date = dmy(Date))

#Filter out the 01-02 Feb 2007 data
eleData <- eleData %>% filter(between(Date, ymd("20070201"), ymd("20070202")))

#Coerce needed values to numeric
eleData <- eleData %>% mutate(Time = ymd_hms(paste(as.character(Date), Time)),
                              Global_active_power = as.numeric(Global_active_power))

#Create Plot
par(mfrow = c(1,1))
plot(eleData$Global_active_power ~ eleData$Time, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Save and close
dev.copy(png, "plot2.png")
dev.off()
remove(list = ls())