if ( !file.exists("household_power_consumption.rda") ) {
  ## raw character Date column: d/m/Y ex: 2/2/2007 not 02/02/2007
  data <- read.table(
    pipe('grep -e \'^Date\' -e \'^1/2/2007\' -e \'^2/2/2007\' household_power_consumption.txt'), 
    sep = ";", 
    header=T,
    colClasses = "character",
    na.strings = c("?")
  )
  ## convert date/time columns
  ## Date: "16/12/2006" -> 2006-12-16
  ## Time: "17:24:00"   -> 2006-12-16 17:24:00
  data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")
  data$Time <- strptime(paste(data$Date, data$Time),format="%Y-%m-%d %H:%M:%S")
  ## convert remaining columns to numeric
  data[,3:9] <- apply(data[,3:9], 2, function(x) as.numeric(as.character(x)))
  ## clean the NA data (converted from "?")
  data<-na.omit(data)
  save(data, file="household_power_consumption.rda")
} else {
  load("household_power_consumption.rda")
}