download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip","curl")
unzip("household_power_consumption.zip")
df <- read.table("household_power_consumption.txt",sep=";",na.strings="?",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),colClasses=c("character","character",rep("numeric",7)),comment.char="",nrows=3000,skip=tail(grep("31/1/2007", readLines("household_power_consumption.txt")),1))
df[, "Date"] <- as.Date(df[, "Date"],"%d/%m/%Y")
df <- subset(df,Date < "2007-02-03")

png("plot1.png")
hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()