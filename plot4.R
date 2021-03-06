#-----------------------------------------------------------------
# plot4.R - panels of plots from the Individual Household Electric
# Power Consumption data set
#-----------------------------------------------------------------

library(sqldf)


#
# Load the original data. Use read.csv2.sql to only load the desired
# records into memory, thereby reducing memory usage.
#

myFile <- "./household_power_consumption.txt"
mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
df <- read.csv2.sql(myFile,mySql)


#
# Extract and massage the desired subset ... this was necessary
# when using read.csv to read in the entire data set, harmless
# to leave this in now that we're using read.csv2.sql (overhead
# is negligible).
#

df$Date <- as.Date( df$Date, '%d/%m/%Y' );

dfs <- subset( subset( df, 
                           Date <= as.Date('2007-02-02')), 
                           Date >= as.Date('2007-02-01') );

dfs$DateTime <- strptime( sprintf("%s %s", dfs$Date, dfs$Time), 
                          format="%Y-%m-%d %H:%M:%S" );

dfs$Global_active_power <- as.numeric(dfs$Global_active_power)


#
# Plot to png.
#

png( file="plot4.png", height=480, width=480, units="px" );

par(mfrow=c(2,2))

# panel 1
plot( dfs$DateTime, dfs$Global_active_power, type='n', main='', 
      ylab='Global Active Power', xlab='' )
lines( dfs$DateTime, dfs$Global_active_power )

# panel 2
plot( dfs$DateTime, dfs$Voltage, type='n', main='',
      ylab='Voltage', xlab='datetime' )
lines( dfs$DateTime, dfs$Voltage )

# panel 3
plot( dfs$DateTime, dfs$Sub_metering_1, type='n', main='',
      ylab='Energy sub metering', xlab='' )
with( dfs, {
   lines( DateTime, Sub_metering_1, col="Black" )
   lines( DateTime, Sub_metering_2, col="Red" )
   lines( DateTime, Sub_metering_3, col="Blue" )
})
legend( "topright", 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col=c("Black", "Red", "Blue"), 
        lty=c(1,1,1), lwd=2, bty="n" )

# panel 4
plot( dfs$DateTime, dfs$Global_reactive_power, type='n',
      main='', xlab='datetime', ylab='Global_reactive_power' )
lines( dfs$DateTime, dfs$Global_reactive_power)

dev.off()

