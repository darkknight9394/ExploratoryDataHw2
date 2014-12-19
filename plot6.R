require(ggplot2)

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(NEI, type == 'ON-ROAD')
data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

Bal <- subset(data, fips == '24510')
LA <- subset(data, fips == '06037')

Bal <- aggregate(Bal[, 'Emissions'], by=list(Bal$year), sum)
colnames(Bal) <- c('year', 'Emissions')
Bal$City <- paste(rep('Baltimore', 4))

LA <- aggregate(LA[, 'Emissions'], by=list(LA$year), sum)
colnames(LA) <- c('year', 'Emissions')
LA$City <- paste(rep('LA', 4))

data <- as.data.frame(rbind(Bal, LA))

png('plot6.png')

p<-ggplot(data=data, aes(x=year, y=Emissions)) + geom_bar( stat="identity") + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources in \n Baltimore vs. LA') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

print(p)
dev.off()
