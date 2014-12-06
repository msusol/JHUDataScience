source("loadData.R")

## Plot 4: 
png("plot4.png", width = 480, height = 480)

## prepare a 2 x 2 grid for each plot to be placed
par(mfrow=c(2,2))

## 1,1
plot(data$Time, data$Global_active_power, xaxt="n", xlab = "",
     ylab="Global Active Power", type="l", lty="solid")
axis.POSIXct(side=1, data$Time, format="%a")

## 1,2
plot(data$Time, data$Voltage, xaxt="n", xlab = "datetime",
     ylab="Voltage", type="l", lty="solid")
axis.POSIXct(side=1, data$Time, format="%a")

## 2,1
plot(data$Time, data$Sub_metering_1, xaxt="n", xlab = "", ylab="Energy Sub Metering", type="l", lty="solid")
lines(data$Time, data$Sub_metering_2, col="red", type="l")
lines(data$Time, data$Sub_metering_3, col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1),col=c("black","red", "blue"),cex=0.5) 
axis.POSIXct(side=1, data$Time, format="%a")

#2,2
plot(data$Time, data$Global_reactive_power, xaxt="n", xlab = "datetime",
     ylab="Global Reactive Power", type="l", lty="solid")
axis.POSIXct(side=1, data$Time, format="%a")

dev.off()
