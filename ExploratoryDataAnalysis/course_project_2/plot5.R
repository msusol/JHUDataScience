load("NEI_data.rsa")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510",]

png("plot5.png", width = 480, height = 480, units = "px")

library(ggplot2)

ggp <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "blue", width = 0.75) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore, 1999-2008"))

print(ggp)

dev.off()