## CREATES COUSERA JOHN HOPKINS EXPLORATORY DATA ANALYSIS PROJECT 1 PLOT 3
setwd("C:/WORKINGDIRECTORY")

## LOAD PACKAGES
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

if (!require("lubridate")) {
  install.packages("lubridate")
}

require(data.table)
require(dplyr)
require(lubridate)

library(data.table)
library(dplyr)
library(lubridate)

## LOAD FILE
file <- "household_power_consumption.txt"

if(file.exists(file)==FALSE){
  zipfile <- "exdata_data_household_power_consumption.zip"
  unzip(zipfile, files = NULL, list = FALSE, overwrite = TRUE,
        junkpaths = FALSE, exdir = ".", unzip = "internal",
        setTimes = FALSE)
}

## LOAD DATA
if (exists("alldata")== FALSE) {
  alldata <- data.table(read.table("household_power_consumption.txt",na.strings = "?", sep=";",header=TRUE))
}

if (exists("prjdata")==FALSE) {
  ## SPECIFY DATE RANGE OF INTEREST
  date1 <- dmy_hms("01-02-2007 00:00:00")
  date2 <- dmy_hms("03-02-2007 00:00:00")
  
  ## CREATE PLOT DATA
  prjdata <- alldata %>%
    mutate(DateTime = dmy_hms(paste(Date, Time)))  %>%
    select(DateTime, Global_active_power:Sub_metering_3, -Date, -Time) %>%
    filter(date1 <= DateTime & DateTime < date2)
}

## PLOT 3
x <- prjdata$DateTime
y1 <- prjdata$Sub_metering_1
y2 <- prjdata$Sub_metering_2
y3 <- prjdata$Sub_metering_3
png(filename="C:/WORKINGDIRECTORY/plot3.png")
  par(mfrow=c(1,1))
  plot(x,y1,type="n",xlab="",ylab="Energy sub metering")
  points(x,y1,type="l", col="black", lwd = .75, cex = .75)
  points(x,y2,type="l",col="red", lwd = .75, cex = .75)
  points(x,y3,type="l",col="blue", lwd = .75, cex = .75)
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lwd = .75, cex = .75)
dev.off()

