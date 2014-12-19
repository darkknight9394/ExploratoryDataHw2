NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=='24510')

png(filename='plot2.png')
totalBaltimore<-tapply(baltimore$Emissions, INDEX=baltimore$year, sum) 
barplot(totalBaltimore, main=expression("Total Emission in Baltimore City in Maryland state"), xlab="Year", ylab=expression('PM'[2.5]))

dev.off()