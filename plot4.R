# plot4.R 
# Exploratory Data Analysis
# Johns Hopkins University
# Coursera
# Week 1 Project
#
# This R script will download the Electric power consumption dataset from the 
# UC Irvine Machine Learning Repository.  It will unpack the dataset into a 
# working folder called data and import the household_power_consumption.txt.
# It will create a DateTime field from a combination of the Date and Time fields
# using functions from the lubridate package.
#
# It will then create a subset of data covering February 1st, 2007 and February # 2nd, 2007. It will then generate a histogram plot for the Global Active 
# Power (kilowatts).

# set working directory
setwd("~/Coursera/Course4_ExploratoryDataAnalysis/week1/r_working")

library(downloader)
library(data.table)
library(plyr)
library(dplyr)
library(lubridate)

if (!file.exists("data")) {
  dir.create("data")
}

# download dataset and unpack
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileURL,"./data/household_power_consumption.zip",mode="wb")
unzip("./data/household_power_consumption.zip", exdir="./data")

# change working directory to UCI Dataset to read files
setwd("~/Coursera/Course4_ExploratoryDataAnalysis/week1/r_working/data")

# read files
powerusage <- fread("household_power_consumption.txt",na.strings="?")

# create DateTime variable
powerusage<-mutate(powerusage,DateTime=paste(Date,Time))
powerusage$DateTime<-dmy_hms(powerusage$DateTime)

# change Date,Time character variables to Date and Time classes with lubridate
powerusage$Date <- dmy(powerusage$Date)
powerusage$Time <- hms(powerusage$Time)

# Create subset of data for February 1, 2007 and February 2, 2007
# todo, speed this step up
feb2daypower<-filter(powerusage,Date=="2007-02-01" | Date=="2007-02-02")

# Create Plot4
png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow = c(2, 2))
#1TL
plot(feb2daypower2$DateTime,feb2daypower2$Global_active_power,xlab="",ylab="Global Active Power",type="l")
#2TR
plot(feb2daypower2$DateTime,feb2daypower2$Voltage,xlab="datetime",ylab="Voltage",type="l")
#3BL
plot(feb2daypower2$DateTime,feb2daypower2$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(feb2daypower2$DateTime,feb2daypower2$Sub_metering_2, type="l",col="red")
lines(feb2daypower2$DateTime,feb2daypower2$Sub_metering_3, type="l",col="blue")
legend("topright", lty=c(1,1,1), col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_1","Sub_metering_3"), bty='n')
#4B
plot(feb2daypower2$DateTime,feb2daypower2$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
dev.off()

