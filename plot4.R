#require(ggplot2)

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

data <- merge(x=NEI, y=SCC.coal, by='SCC')
sumdata <- aggregate(data[, 'Emissions'], by=list(data$year), sum)
colnames(sumdata) <- c('Year', 'Emissions')

png(filename='plot4.png')

p<-ggplot(data=data.sum, aes(x=Year, y=Emissions/100000)) + 
    geom_bar(stat="identity", position=position_dodge()) +
    ggtitle(expression(paste('Coal Combustion-Related Emissions from 1999 to 2008'))) + 
    ylab(expression(paste('PM', ''[2.5], ' in Mega tons')))

print(p)
dev.off()