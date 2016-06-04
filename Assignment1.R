#Code for Exploratory Data Analysis Week 1 Assignment

setwd("C:/Users/Teng Family/Desktop/Ziyang/Data Science/MOOC courses/JHU data science specialization/Exploratory Data Analysis/Week 1/Assignment")
library(dplyr)
library(data.table)


dta<- fread("household_power_consumption.txt",na.strings = "?", stringsAsFactors = FALSE)
#filtering out the required data
pwrcons<- filter(dta, grep("^[1,2]/2/2007", Date))

#Converting all variables to numeric
pwrcons$Global_active_power <- as.numeric(as.character(pwrcons$Global_active_power))
pwrcons$Global_reactive_power<- as.numeric(as.character(pwrcons$Global_reactive_power))
pwrcons$Voltage <- as.numeric(as.character(pwrcons$Voltage))
pwrcons$Global_intensity <- as.numeric(as.character(pwrcons$Voltage))
pwrcons$Sub_metering_1<- as.numeric(as.character(pwrcons$Sub_metering_1))
pwrcons$Sub_metering_2<- as.numeric(as.character(pwrcons$Sub_metering_2))
pwrcons$Sub_metering_3<- as.numeric(as.character(pwrcons$Sub_metering_3))

#creating a new Time/date variable
pwrcons$DateTime<- paste(pwrcons$Date, pwrcons$Time)

#plot1
png("plot1.png")
hist(pwrcons$Global_active_power, col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

#Plot2
png("plot2.png")
with(pwrcons, plot(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Global_active_power, type = "l",  xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

#Plot3
png("plot3.png")
with(pwrcons,
     plot(strptime(DateTime,"%d/%m/%Y %H:%M:%S"), Sub_metering_1, type = "l", col = "grey", xlab = "", ylab = "Energy sub metering")

     )

with(pwrcons, lines(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Sub_metering_2, type = "l", col= "red"))
with(pwrcons, lines(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Sub_metering_3, type = "l", col= "blue"))
#Adding Legends
legend("topright", lty = 1, col = c("grey", "red", "blue"), legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"))
dev.off()

#Plot4
png("plot4.png")
par(mfrow = c(2,2))
with(pwrcons, plot(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

with(pwrcons, plot(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(pwrcons,
     plot(strptime(DateTime,"%d/%m/%Y %H:%M:%S"), Sub_metering_1, type = "l", col = "grey", xlab = "", ylab = "Energy sub metering"))
with(pwrcons, lines(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Sub_metering_2, type = "l", col= "red"))
with(pwrcons, lines(strptime(DateTime, "%d/%m/%Y %H:%M:%S"), Sub_metering_3, type = "l", col= "blue"))
legend("topright", lty = 1, col = c("grey", "red", "blue"), legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"))

with(pwrcons, plot(strptime(DateTime,"%d/%m/%Y %H:%M:%S"), Global_reactive_power, type ="l", xlab="datetime"))

dev.off()

