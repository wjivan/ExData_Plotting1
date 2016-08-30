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

#Fourth table
png(filename="plot4.png")
par(mfrow=c(2,2))
#Table 4.1
data$Global_active_power<- as.numeric(data$Global_active_power)
install.packages("lubridate")
library(lubridate)
data$datetime<-paste(data$Date,data$Time)
data$datetime<-dmy_hms(data$datetime)
with(data, plot(datetime,Global_active_power/1000,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

#Table 4.2
data$Voltage<-as.numeric(data$Voltage)
with(data,plot(data$datetime,data$Voltage,type="l",ylab = "Voltage",xlab="datetime"))

#Table 4.3
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
with(data,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=2,bty="o")

#Table 4.4
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
with(data,plot(datetime,Global_reactive_power,type="l",ylab="Global_Reactive_Power",xlab="datetime"))
dev.off()
