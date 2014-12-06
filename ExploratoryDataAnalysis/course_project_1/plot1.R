source("loadData.R")

## Plot 1: Frequency of Global Active Power
png("plot1.png",width = 480, height = 480)

hist(data$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power", col="Red")

dev.off()