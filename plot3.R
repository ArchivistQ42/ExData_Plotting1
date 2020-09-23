## Global Active Power Histogram

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
                              Sub_metering_1 = as.numeric(Sub_metering_1),
                              Sub_metering_2  = as.numeric(Sub_metering_2),
                              Sub_metering_3 = as.numeric(Sub_metering_3))

#Create Plot
par(mfrow = c(1,1))
plot(eleData$Sub_metering_1 ~ eleData$Time, 
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(eleData$Sub_metering_2 ~ eleData$Time, type = "l", col = "red")
lines(eleData$Sub_metering_3 ~ eleData$Time, type = "l", col = "blue")
legend("topright", c("Sub_metering_1     ", "Sub_metering_2     ", "Sub_metering_3     "), 
       lwd = 1, col = c("black", "red", "blue"))

#Save and close
dev.copy(png, "plot3.png")
dev.off()
remove(list = ls())