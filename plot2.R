#Clean up workspace
rm(list=ls())
setwd("./ExData_Plotting1")

#Download the data file
filename<-"powerdata.zip"
if(!file.exists(filename)){
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url,filename,method="curl")        
        unzip(filename)
}

#filters out the data table needed
raw<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
data<-raw[which(raw$Date=="1/2/2007"|raw$Date=="2/2/2007"),]

#Second table
png(filename = "plot2.png")
data$Global_active_power<- as.numeric(data$Global_active_power)

install.packages("lubridate")
library(lubridate)
data$datetime<-paste(data$Date,data$Time)
data$datetime<-dmy_hms(data$datetime)
with(data, plot(datetime,Global_active_power/1000,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()
