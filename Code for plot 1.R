#loading packages#
library(ggplot2)
library(dplyr)

##loading the data from website Coursera
#Downloading the fiel from link in the instruction
filename<-"Course Project 2.zip"
if(!file.exists(filename)){
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileUrl,filename,method = "curl")
}

#check the folder 
if(!file.exists("PM2.5 Emissions Data")){
        unzip(filename)
}

#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##solving the first question
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total 
#PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#building the total emission subset
totalEmissions <- tapply(PM25_Emissions_Data$Emissions, PM25_Emissions_Data$year, sum)
View(totalEmissions)

#plotting the output
barplot(totalEmissions,col = "black",
        xlab = "Year",ylab = "Total Emission (ton)", 
        main="Total Emission for Each Year")
dev.copy(png,file="Plot1.png",height=593,width=466)
dev.off()