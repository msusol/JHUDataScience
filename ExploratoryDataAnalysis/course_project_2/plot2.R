load("NEI_data.rsa")

# Aggregate using sum the Baltimore emissions data by year
baltimoreNEI <- NEI[NEI$fips=="24510",]
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

png("plot2.png", width = 480, height = 480, units = "px")

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  col = c("blue"),
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From Baltimore City Sources"
)

dev.off()