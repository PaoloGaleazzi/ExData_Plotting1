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

# Plot1

png(filename = "Plot1.png")
hist(as.numeric(df$Global_active_power), col="red", xlab= "Global active power (kilowatts)", main="Global active power")
dev.off()

file.remove("household_power_consumption.txt")
