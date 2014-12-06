source("loadData.R")

## Plot 3: Energy Sub Metering
png("plot3.png", width = 480, height = 480)

plot(data$Time, data$Sub_metering_1, xaxt="n", xlab = "", ylab="Energy Sub Metering", type="l", lty="solid")
lines(data$Time, data$Sub_metering_2, col="red", type="l")
lines(data$Time, data$Sub_metering_3, col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1),col=c("black","red", "blue")) 
axis.POSIXct(side=1, data$Time, format="%a")

dev.off()