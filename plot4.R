##############################################################################
#                                 Plot4.R                                    #
##############################################################################



#Get plotting Data

if(!file.exists("./data_plot4")){dir.create("./data_plot4")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./data_plot4/household_power_consumption.zip")

#Unzip dataset

unzip(zipfile = "./data_plot4/household_power_consumption.zip", exdir = "./data_plot4")


#Set working Directory

setwd("./data_plot4")


#read the household_power_consumption.txt into a table

file = "household_power_consumption.txt"

hpcdata <- read.csv2(file, header = TRUE, sep = ";")


# Subset the data to 2007-02-01 and 2007-02-02

library(dplyr)

subsetData <- filter(hpcdata,hpcdata$Date == "1/2/2007" | hpcdata$Date == "2/2/2007")

# Change date  Date Class 

subsetData$Date <- as.Date(subsetData$Date, format="%d/%m/%Y")



## Add a POSIX datetime variable that can be used for the plot

dateTime <- paste(as.Date(subsetData$Date), subsetData$Time)

subsetData$Datetime <- as.POSIXct(dateTime)


# Create plot4.png

png("plot4.png", width=480, height=480)
par(mfcol = c(2, 2)) ## Create plots by Column

# Set left top plot title/labels 
plot(as.numeric(as.character(subsetData$Global_active_power))
     ~ subsetData$Datetime, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")

# Set up left bottom plot title/labels
plot(subsetData$Datetime,as.numeric(as.character(subsetData$Sub_metering_1)), type = "l", ylab="Energy sub metering", xlab="")
lines(subsetData$Datetime ,as.numeric(as.character(subsetData$Sub_metering_2)),type = "l", col='Red')
lines(subsetData$Datetime,as.numeric(as.character(subsetData$Sub_metering_3)),type = "l", col='Blue')

# Create legand 
legend("topright", col=c("black", "red", "blue"), lty= 1, lwd=1, 
       
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty = "n")


# Set top right plot title/labels 
plot(subsetData$Datetime, as.numeric(as.character(subsetData$Voltage)), type="l", xlab="Datetime", ylab="Voltage")

# Set bottom right plot title/labels
plot(subsetData$Datetime, as.numeric(as.character(subsetData$Global_reactive_power)), type="l", xlab="Datetime", ylab="Global_reactive_power")

# Close the device
dev.off()