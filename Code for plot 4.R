#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##Solving the issues
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
coal<-grepl("coal",SCC_data$Short.Name,ignore.case = TRUE)
coal_scc<-SCC_data[coal,]
View(coal)
View(coal_scc)

#Creating new dataframe
Coalnew<-merge(PM25_Emissions_Data,coal_scc,by="SCC")

#listing the annual statistics
total_emissions_coal<-tapply(Coalnew$Emissions,Coalnew$year,sum)

#plotting and solving the issue

barplot(total_emissions_coal,
        xlab = "Year",
        ylab = "Total Emission (ton)",
        main = "Total Emission From Coal", col = rgb(1,1,0))

dev.copy(png,file="Plot4.png",height=593,width=466)
dev.off()
