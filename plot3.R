#Set work directory
setwd("E:/Coursera/Exploratory Data Analysis/Week1/exdata-data-household_power_consumption")

#Read subset of data from 2007-Feb-1 to 2007-Feb-2 by setting skip and nrow parameters.
#In this way, text lines prior to "1/2/2007" would be skipped and as the reading was taken 
#by every minute, the subset of data had 60*24*2 = 2880 readings (the final data point was
#the first reading of 2007-Feb-3).
data <- read.table("household_power_consumption.txt", 
                   skip = grep("1/2/2007", readLines("household_power_consumption.txt")), 
                   sep = ";", nrows = 2880, 
                   col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Convert data to the dataframe
data <- as.data.frame(data)

#Concatenate the Date and Time columns to a new column "datetime"
data$datetime <- paste(data$Date, data$Time)

#Convert the format of the datetime column to %Y-%m-%d %H:%M:%S
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")

#Open png graph device
png(file = "plot3.png", width = 480, height = 480)

#Plot datetime vs Sub_metering_1, the datetime values will be converted to
#abrreviated weekdays automatically as the x axis txt
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
#Add lines of datetime vs Submetering_2 or 3
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
#Add legends 
legend("topright", colnames(data[,7:9]),
       col=c("black", "red", "blue"), lty = 1)

#Close device
dev.off()