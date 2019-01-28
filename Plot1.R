##############################################################################
#                                 Plot1.R                                    #
##############################################################################



#Get plotting Data

if(!file.exists("./data_plot1")){dir.create("./data_plot1")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./data_plot1/household_power_consumption.zip")

#Unzip dataset

unzip(zipfile = "./data_plot1/household_power_consumption.zip", exdir = "./data_plot1")


#Set working Directory

setwd("./data_plot1")


#read the household_power_consumption.txt into a table

file = "household_power_consumption.txt"

hpcdata <- read.csv2(file, header = TRUE, sep = ";")


# Subset the data to 2007-02-01 and 2007-02-02

library(dplyr)

subsetData <- filter(hpcdata,hpcdata$Date == "1/2/2007" | hpcdata$Date == "2/2/2007")

# Create plot1.png

png("plot1.png", width=480, height=480)


# Set up Histogram title and labels 

hist(as.numeric(as.character(subsetData$Global_active_power)), col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")


# Close

dev.off()