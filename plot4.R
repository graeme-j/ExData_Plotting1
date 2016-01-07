#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")

#readLines("household_power_consumption.txt",150:200)

library(dplyr)
library(lubridate)

dat <- read.table("household_power_consumption.txt",sep=";",header=T,stringsAsFactors = F)

dat$DateTime = dmy_hms(paste(dat$Date,dat$Time))
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)

filtered_dat <- dat %>%
  select(DateTime,Global_reactive_power, Global_active_power, Voltage, Sub_metering_1,Sub_metering_2, Sub_metering_3) %>%
  filter(DateTime<=dmy_hms("2/2/2007 23:59:59"),DateTime>=dmy("1/2/2007"))

png("plot4.png",width = 480, height = 480)
par(mfcol = c(2,2),mar=c(4,4,2,2))
plot(filtered_dat$DateTime,filtered_dat$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")          

plot(filtered_dat$DateTime,filtered_dat$Sub_metering_1, type = "l",col='black', ylab = "Energy sub metering", xlab = "")          
lines(filtered_dat$DateTime,filtered_dat$Sub_metering_2,type="l",col="red")
lines(filtered_dat$DateTime,filtered_dat$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(filtered_dat$DateTime,filtered_dat$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")          

plot(filtered_dat$DateTime,filtered_dat$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")          

dev.off()
