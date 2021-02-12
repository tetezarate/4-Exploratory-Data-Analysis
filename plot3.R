library(dplyr)

data <- read.table("household_poweR_consumption.txt", header = TRUE, sep = ";")

data$Date <- as.Date(data$Date, "%d/%m/%Y")

reduced_database <- filter(data, Date>= "2007-02-01" & Date <= "2007-02-02")

reduced_database$Time <- strptime(reduced_database$Time, "%H:%M:%S")

cols <- 3:9

reduced_database[,cols] <-  apply(reduced_database[,cols], 2, function(x) as.numeric(as.character(x)))

reduced_database[1:1440,"Time"] <- format(reduced_database[1:1440,"Time"],"2007-02-01 %H:%M:%S")
reduced_database[1441:2880,"Time"] <- format(reduced_database[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


dev.print(png, file = "plot3.png", width = 480, height = 480)

png(file = "plot3.png", bg = "transparent")

plot(reduced_database$Time,  reduced_database$Sub_metering_1, type = "l", col = "black")
lines(reduced_database$Time,  reduced_database$Sub_metering_2, type = "l", col = "red")
lines(reduced_database$Time,  reduced_database$Sub_metering_3, type = "l",col ="blue")

legend("topright", legend=c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)

dev.off()