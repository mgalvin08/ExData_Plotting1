##############################################################################
#                                 Plot2.R                                    #
##############################################################################

if(!file.exists("./data_plot2")){dir.create("./data_plot2")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./data_plot2/household_power_consumption.zip")

#Unzip
unzip(zipfile = "./data_plot2/household_power_consumption.zip", exdir = "./data_plot2")


#Set working Directory

setwd("./data_plot2")

dataFull <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                     nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
data1 <- subset(dataFull, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

# Create plot2.png
with(data1, {plot(Global_active_power~Datetime, type="l",
                  ylab="Global Active Power (kilowatts)", xlab="")})

dev.copy(png, file="plot2.png", height=480, width=480)

# Close
dev.off()