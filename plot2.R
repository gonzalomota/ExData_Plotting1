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

png(file <- "plot2.png",width=480,height=480)
plot(dataSetFiltered$Datetime, dataSetFiltered$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="",type="l")
dev.off()


