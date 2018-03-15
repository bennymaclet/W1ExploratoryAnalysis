library(dplyr)

#Read the data table 
filename <-  "household_power_consumption.txt"
cons <-read.table(filename,header = TRUE, sep = ";",na.strings = "?")

## Format date to Type Date
cons$Date <- as.Date(cons$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
cons <- subset(cons,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#Only completed cases are considered:
cons <- cons[complete.cases(cons),]

# Mutate the dataset Date and Time variables
cons$Time = as.POSIXct(strptime(paste(cons$Date, ' ', cons$Time), '%Y-%m-%d %H:%M:%S'))

#generate plot4
png(filename='plot4.png', width=480, height=480, units='px')

par(mfrow = c(2,2), mar=c(4,4,1,1))
with(cons, {
  
  plot(Time, Global_active_power, type="l", ylab = "Global active power")
  plot(Time, Voltage, type = "l", ylab="Voltage")
  plot(Time, Sub_metering_1, type='l', col = 'black', ylab = "Energy sub metering")
  lines(Sub_metering_2~Time,col='Red')
  lines(Sub_metering_3~Time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  plot(Time, Global_reactive_power, type = "l", ylab = "Global reactive power")
})

dev.off()
    