library(dplyr)

data <- as_data_frame(read.table("household_poweR_consumption.txt", header = TRUE, sep = ";"))

data$Date <- as.Date(data$Date, "%d/%m/%Y")

reduced_database <- filter(data, Date>= "2007-02-01" & Date <= "2007-02-02")

reduced_database$Time <- strptime(reduced_database$Time, "%H:%M:%S")

cols <- 3:9

reduced_database[,cols] <-  apply(reduced_database[,cols], 2, function(x) as.numeric(as.character(x)))



dev.print(png, file = "plot1.png", width = 480, height = 480)

png(file = "plot1.png", bg = "transparent")
hist(reduced_database$Global_active_power)
dev.off()
