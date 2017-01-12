library(data.table)

p8789 <- data.table(read.csv(file = '~/git/DLR/loadprofiles/8789.csv',header = FALSE, col.names = c('profile','timestamp','volts','valid','lock')))
p1000 <- data.table(read.csv(file = '~/git/DLR/loadprofiles/1000.csv',header = FALSE, col.names = c('profile','timestamp','amps','valid','lock')))
setkey(p1000, timestamp)

# Join voltage and current load profiles
power1000 <- merge(p1000, p8789)[,.(timestamp, profile.x, profile.y, amps, volts)]
# Calculate power (I*V)
power1000[, 'power' := amps*volts]
# Convert timestamp integer to date-time type
power1000[, timestamp := as.POSIXct(strptime(power1000$timestamp, "%Y-%m-%d %H:%M:%S"))]