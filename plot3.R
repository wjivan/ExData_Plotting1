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

#Third table
png(filename="plot3.png", width=480,height=480)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
with(data,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=2)
dev.off()
