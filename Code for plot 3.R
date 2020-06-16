#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##Solving the issues
#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
View(PM25_Emissions_Data)
Baltimore<-filter(PM25_Emissions_Data,fips=="24510")
View(Baltimore)
summarized_stat<-aggregate(Emissions~year+type, Baltimore,sum)
View(summarized_stat)

#Plotting the third issue
plot3<-ggplot(summarized_stat,aes(year,Emissions,color=type))
plot3+geom_line()+xlab("Year")+
        ylab("PM2.5 Emissions in total")+ggtitle("Baltimore's Total Emissions for Each Year")+ 
        theme_set(theme_bw())

dev.copy(png,file="Plot3.png",height=593,width=466)
dev.off()