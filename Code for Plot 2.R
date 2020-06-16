#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##solving the first question
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
library(dplyr)
View(PM25_Emissions_Data)
Baltimore<-filter(PM25_Emissions_Data,fips==24510)
View(Baltimore)

total_baltimore<-tapply(Baltimore$Emissions, Baltimore$year, sum)
barplot(total_baltimore,
        xlab = "Year", ylab = "Total Emission (ton)",
        main = "Baltimore's Total Emission for each year ")

dev.copy(png,file="Plot2.png",height=593,width=466)
dev.off()