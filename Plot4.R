# packages needed
library(dplyr)
library(lubridate)
library(downloader)

# download and unzip
file.create("data.zip")
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(dataUrl, dest="data.zip", mode="wb")
unzip ("data.zip", exdir = "./")
file.remove("data.zip")

# clean data

data <- tbl_df(read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE))
data[,1] <- lapply(as.list(data[,1]), dmy)
df <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
df[,1] <- paste(df$Date, df$Time)
df[,1] <- lapply(as.list(df[,1]), ymd_hms)

# Plot 4 

png(filename = "Plot4.png")
par(mfcol=c(2,2), mar=c(4,4,2,2), oma=c(1,1,0,0))
plot(df$Date, df$Global_active_power, type="l", main="", xlab="", ylab="Global active power (kw)", cex.lab=1, cex.axis=1)
plot(df$Date, df$Sub_metering_1, type="l", main="", xlab="", ylab="Energy sub metering", cex.lab=1, cex.axis=1)
points(df$Date, df$Sub_metering_2, type="l", col="red")
points(df$Date, df$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c("solid","solid","solid"), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.7)
plot(df$Date, df$Voltage, type="l", cex.axis=1, cex.lab=1, xlab="datetime", ylab="voltage")
with(df, plot(Date, Global_reactive_power, type="l", cex.axis=1, cex.lab=1, xlab="datetime"))
dev.off()

file.remove("household_power_consumption.txt")