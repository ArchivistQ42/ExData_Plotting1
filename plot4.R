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
                              Global_active_power = as.numeric(Global_active_power),
                              Global_reactive_power = as.numeric(Global_reactive_power),
                              Voltage = as.numeric(Voltage),
                              Global_intensity = as.numeric(Global_intensity),
                              Sub_metering_1 = as.numeric(Sub_metering_1),
                              Sub_metering_2  = as.numeric(Sub_metering_2),
                              Sub_metering_3 = as.numeric(Sub_metering_3))

#Create Plot

##structure
par(mfrow = c(2,2))

##Top Left
plot(eleData$Global_active_power ~ eleData$Time, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##Top Right
plot(eleData$Voltage ~ eleData$Time, 
     type = "l", xlab = "datetime", ylab = "Voltage")

##Bottom Left
plot(eleData$Sub_metering_1 ~ eleData$Time, 
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(eleData$Sub_metering_2 ~ eleData$Time, type = "l", col = "red")
lines(eleData$Sub_metering_3 ~ eleData$Time, type = "l", col = "blue")
legend("topright", c("Sub_metering_1     ", "Sub_metering_2      ", "Sub_metering_3      "), 
       lwd = 1, col = c("black", "red", "blue"), bty = "n")

##Bottom Right
plot(eleData$Global_reactive_power ~ eleData$Time, 
     type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#Save and close
dev.copy(png, "plot4.png")
dev.off()
remove(list = ls())