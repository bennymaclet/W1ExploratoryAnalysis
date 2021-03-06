
library(dplyr)
filename <-  "household_power_consumption.txt"

#Read the data set
cons <-read.table(filename,header = TRUE, sep = ";",na.strings = "?")

## Format date to Type Date
cons$Date <- as.Date(cons$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
cons <- subset(cons,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#Only completed cases are considered:
cons <- cons[complete.cases(cons),]

# Mutate the dataset Date and Time variables
cons$Time = as.POSIXct(strptime(paste(cons$Date, ' ', cons$Time), '%Y-%m-%d %H:%M:%S'))


#Generate the histogram plot 
png(filename='plot1.png', width=480, height=480, units='px')
hist(cons$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()



