# Course: Exploratory Data Analysis
# Assignment: Course Project 1
# Name: Tadhg Adderley
# Date: 06/01/2016

############################################################################################
# Plot 3
############################################################################################


############################################################################################
# Code for Loding in Power Data Set
############################################################################################

# Clear Global Environment
rm(list = ls())
# Set URL for Data download from Coursera Course
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# If zip file does not exist then download
if(!file.exists("household_power_consumption.zip")){
        # Download data from Coursera Site to Working Directory
        download.file(url, destfile = "household_power_consumption.zip")      
}

# If txt file does not exist then unzip from downloaded file
if(!file.exists("household_power_consumption.txt")){
        # Unzip Data 'exdata-data-household_power_consumption.zip' into working directory
        unzip("household_power_consumption.zip")      
}


# Check memory size of Power Data set
powerDataSize <- format(object.size(read.table("household_power_consumption.txt",
                                               sep = ";", header = TRUE)), units = "Mb")
powerDataSize

# Load in Power Data
powerData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na = "?")

# Convert Date POSIXct
powerData$Date <- as.POSIXlt(powerData$Date, format = "%d/%m/%Y")

# Select only data from 2007-02-01 & 2007-02-02
powerData <- subset(powerData, powerData$Date == "2007-02-01" | powerData$Date == "2007-02-02")

# Merge Date & Time to once column and format as POSIXct
powerData$DateTime <- paste(powerData$Date, powerData$Time, sep = ":")
powerData$DateTime <- as.POSIXct(powerData$DateTime, format = "%Y-%m-%d:%H:%M:%S")

# Reorder Columns so DateTime is First and remove original Date & Time columns
powerData <- powerData[, c(10, 3:9)]


############################################################################################
# Code for Saving Plot as PNG
############################################################################################

png(file = "plot3.png", width = 480, height = 480)

with(powerData, plot(DateTime, Sub_metering_1,
                     xlab = " ",
                     ylab = "Energy sub metering",
                     type = "n"))
with(powerData, lines(DateTime, Sub_metering_1))
with(powerData, lines(DateTime, Sub_metering_2, col = "red"))
with(powerData, lines(DateTime, Sub_metering_3, col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

############################################################################################