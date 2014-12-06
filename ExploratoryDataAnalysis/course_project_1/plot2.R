source("loadData.R")

## Plot 2: Global Active Power vs datetime
png("plot2.png", width = 480, height = 480)

plot(data$Time, data$Global_active_power, xaxt="n", xlab = "",
     ylab="Global Active Power (kilowatts)", type="l", lty="solid")
axis.POSIXct(side=1, data$Time, format="%a")

dev.off()