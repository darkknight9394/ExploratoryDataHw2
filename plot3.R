require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")

data <- aggregate(baltimore$Emissions, list(baltimore$type, baltimore$year), FUN = sum)

names(data) <- c("Type", "Year", "Emissions")

png(filename='plot3.png')

p <- qplot(Year, Emissions, color = Type, data = data, geom = "path",size=1.25) + 
    ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore City aggregated by Emission Source")) +
    xlab("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))

print(p)
dev.off()