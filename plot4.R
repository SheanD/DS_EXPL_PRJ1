
## CREATES COUSERA JOHN HOPKINS EXPLORATORY DATA ANALYSIS PROJECT 1 PLOT 4
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

## PLOT 4
x <- prjdata$DateTime
y <- prjdata$Global_active_power
v <- prjdata$Voltage
y1 <- prjdata$Sub_metering_1
y2 <- prjdata$Sub_metering_2
y3 <- prjdata$Sub_metering_3
z <- prjdata$Global_reactive_power
png(filename="C:/WORKINGDIRECTORY/plot4.png")
  par(mfrow=c(2,2))
  ## PLOT UPPER LEFT
    plot(x,y,type="n",xlab="",ylab="Global Active Power",cex.lab=".75")
    points(x,y,type="l")
  ## PLOT UPPER RIGHT
    plot(x,v,type="n",xlab="datetime",ylab="Voltage")
    points(x,v,type="l")
  ## PLOT LOWER LEFT
    plot(x,y1,type="n",xlab="",ylab="Energy sub metering", cex.lab=".8")
    points(x,y1,type="l", col="black", lwd = .75, cex = .75)
    points(x,y2,type="l",col="red", lwd = .75, cex = .75)
    points(x,y3,type="l",col="blue", lwd = .75, cex = .75)
    legend("topright",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lwd = .75, cex = .65, bty="n")
  ## PLOT LOWER RIGHT
    plot(x,z,type="n", xlab="datetime",ylab="Global_reactive_power",cex.lab=".75", cex.axis=".75")
    points(x,z,type="l")
dev.off()


## BONEYARD CODE
## DateTime <- dmy_hms(paste(alldata$Date, alldata$Time))
## prjdata <-  filter(mutate(DateTime = dmy_hms(paste(alldata$Date, alldata$Time)),select(alldata,-Date, -Time)), date1 <= DateTime & DateTime < date2)
## FORMAT COLUMN NAMES
##cnames <- names(prjdata)[-1]              
##colnames(prjdata) <- gsub("_"," ",)
##cnames<-gsub("\\b([a-z])([a-z]+)","\\U\\1\\E\\2",cnames,perl=TRUE)
##names(prjdata)[-1] <- cnames

