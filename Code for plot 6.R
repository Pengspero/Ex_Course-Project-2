#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##Solving the issues
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California 
#(\color{red}{\verb|fips == "06037"|}fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

#1, get data for los Angeles
Los_Angeles<-filter(PM25_Emissions_Data,fips=="06037")

#2, get the subset of the vehicle value
Vehicle<-grepl("vehicle",SCC_data$SCC.Level.Two,ignore.case = TRUE)
scc_vehicle<-SCC_data[Vehicle,]

#3, create dataframe and add new variable of city
data_Baltimore<-merge(Baltimore,scc_vehicle,by="SCC")
data_Baltimore$city<-"Baltimore City"
data_Los_Angeles<-merge(Los_Angeles,scc_vehicle,by="SCC")
data_Los_Angeles$city<-"Los Angeles County"

combined_data<-rbind(data_Baltimore,data_Los_Angeles)

#4, get the annual statistics of emissions by type
overall_data<-aggregate(Emissions~year+city,combined_data,sum)

#5, Plot
p<-ggplot(overall_data,
          aes(year, Emissions, color=city))
p+geom_line()+xlab("Year")+ylab("Total PM2.5 Emissions (ton)")+
        ggtitle("Total Emissions from Moter Sources in Baltimore City and Los Angeles County")+
        theme_set(theme_bw())

dev.copy(png,file="Plot6.png",height=593,width=466)
dev.off()