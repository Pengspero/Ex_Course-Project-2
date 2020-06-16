#loading the data
PM25_Emissions_Data<-readRDS("summarySCC_PM25.rds")
SCC_data<-readRDS("Source_Classification_Code.rds")

##Solving the issues
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#1.get the subset
Vehicle<-grepl("vehicle",SCC_data$SCC.Level.Two,ignore.case = TRUE)
scc_vehicle<-SCC_data[Vehicle,]

#2.create the dataframe
vehicle_new<-merge(Baltimore,scc_vehicle,by="SCC")

#3.Get the annual statistics of emission by type 
total_emissions_vehicle<-tapply(vehicle_new$Emissions,vehicle_new$year,sum)

#4.Plot
barplot(total_emissions_vehicle,
        xlab = "Year",ylab = "Total Emission (ton)",
        main = "Total Emission from motor vehicle in Baltimore",
        col = rgb(0.5,1,0))

dev.copy(png,file="Plot5.png",height=593,width=466)
dev.off()
