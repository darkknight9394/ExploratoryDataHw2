require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

Baltimore <- aggregate(data[, 'Emissions'], by=list(data$year), sum)
colnames(Baltimore) <- c('year', 'Emissions')

png('plot5.png')

p<-ggplot(data=Baltimore, aes(x=year, y=Emissions)) + geom_bar( stat="identity") + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
    ylab(expression('PM'[2.5])) + xlab('Year') +  
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1)) +
    theme(legend.position='none')

print(p)
dev.off()