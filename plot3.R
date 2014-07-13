#-----------------------------------------------------------------
# plot3.R - plot Energy Sub Metering versus time from the
# Individual Household Electric Power Consumption data set
#-----------------------------------------------------------------


#
# load the original data
#

df <- read.csv( 'household_power_consumption.txt', sep=';', 
   colClasses=c('character', 'character', 'character', 'character', 
                'character', 'character', 'character', 'character', 
                'character') );


#
# extract and massage the desired subset
#

df$Date <- as.Date( df$Date, '%d/%m/%Y' );

dfs <- subset( subset( df, 
                           Date <= as.Date('2007-02-02')), 
                           Date >= as.Date('2007-02-01') );

dfs$DateTime <- strptime( sprintf("%s %s", dfs$Date, dfs$Time), 
                          format="%Y-%m-%d %H:%M:%S" );


#
# plot to png
#

png( file="plot3.png", height=480, width=480, units="px" );

plot( dfs$DateTime, dfs$Sub_metering_1, type='n', main='',
      ylab='Energy sub metering', xlab='' )

with( dfs, {
   lines( DateTime, Sub_metering_1, col="Black" )
   lines( DateTime, Sub_metering_2, col="Red" )
   lines( DateTime, Sub_metering_3, col="Blue" )
});

legend( "topright", 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col=c("Black", "Red", "Blue"), 
        lty=c(1,1,1), lwd=2, bty="o" )

dev.off();


