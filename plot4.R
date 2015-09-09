library(downloader)
library(dplyr)
library(lubridate)

library(datasets)


url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

dataSetDf <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, quote="", dec=".", numerals = "no.loss")

dataSetDfDplyr <- tbl_df(dataSetDf)
rm(dataSetDf)


dataSetFiltered <- filter(dataSetDfDplyr, dmy(Date) >= dmy("01/02/2007") , dmy(Date) <= dmy("02/02/2007") )
dataSetFiltered$Global_active_power <- as.numeric(as.character(dataSetFiltered$Global_active_power))
dataSetFiltered <- mutate(dataSetFiltered, Datetime = dmy_hms(paste (Date, Time, sep = " ", collapse = NULL)))

png(file <- "plot4.png",width=480,height=480)
#title("Global ActiveP Power")

par(mfrow = c(2,2))

plot(dataSetFiltered$Datetime, dataSetFiltered$Global_active_power, ylab = "Global Active Power", xlab="",type="l")
plot(dataSetFiltered$Datetime, dataSetFiltered$Voltage, ylab = "Voltage", xlab="datetime",type="l")


plot(x =dataSetFiltered$Datetime, y = dataSetFiltered$Sub_metering_1, 
     ylab = "Energy sub metering", xlab="",type="l", col="black")
box()

lines(x =dataSetFiltered$Datetime, y= dataSetFiltered$Sub_metering_2, type="l", col="red")
lines(x =dataSetFiltered$Datetime, y= dataSetFiltered$Sub_metering_3, type="l", col="blue")


legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"),lty=1, bty="n")


plot(dataSetFiltered$Datetime, dataSetFiltered$Global_reactive_power, ylab = "Global_reactive_power", xlab="datetime",type="l")


dev.off()


