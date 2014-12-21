load("NEI_data.rsa")

# Aggregate by sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png", width = 480, height = 480, units = "px")

barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  col = c("blue"),
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()