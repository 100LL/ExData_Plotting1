download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "household_power_consumption.zip",
              "curl")
unzip("household_power_consumption.zip")
df <- read.table("household_power_consumption.txt",
                 sep=";",
                 na.strings="?",
                 col.names=c("Date",
                             "Time",
                             "Global_active_power",
                             "Global_reactive_power",
                             "Voltage",
                             "Global_intensity",
                             "Sub_metering_1",
                             "Sub_metering_2",
                             "Sub_metering_3"),
                 colClasses=c("character",
                              "character",
                              rep("numeric",7)),
                 comment.char="",
                 nrows=3000,
                 #skip forward to the start of the data of interest
                 skip=tail(grep("31/1/2007", readLines("household_power_consumption.txt")),1))

df[, "Date"] <- as.Date(df[, "Date"],"%d/%m/%Y")
df <- subset(df,Date < "2007-02-03")

png("plot3.png")
plot(strptime(paste(df$Date,df$Time),"%Y-%m-%d %T"),
     df$Sub_metering_1,type="l",
     ylab="Energy sub metering",
     xlab="")
lines(strptime(paste(df$Date,df$Time),"%Y-%m-%d %T"),
      df$Sub_metering_2,
      type="l",
      xlab="",
      col="red")
lines(strptime(paste(df$Date,df$Time),"%Y-%m-%d %T"),
      df$Sub_metering_3,
      type="l",
      xlab="",
      col="blue")
legend("topright",
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,lwd=1)
dev.off()