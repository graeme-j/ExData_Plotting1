#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")

#readLines("household_power_consumption.txt",150:200)

library(dplyr)
library(lubridate)

dat <- read.table("household_power_consumption.txt",sep=";",header=T,stringsAsFactors = F)

dat$DateTime = dmy_hms(paste(dat$Date,dat$Time))
dat$Global_active_power <- as.numeric(dat$Global_active_power)

filtered_dat <- dat %>%
                select(DateTime, Global_active_power) %>%
                filter(DateTime<=dmy_hms("2/2/2007 23:59:59"),DateTime>=dmy("1/2/2007"))

png("plot1.png",width = 480, height = 480)

hist(filtered_dat$Global_active_power, main="Global Active Power"
     , xlab = "Global Active Power (kilowatts)", col="red")          

dev.off()
