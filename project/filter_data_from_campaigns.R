

# Use http://www.epochconverter.com/ to get epoch ms
#Epoch timestamp: 1434672000
#Timestamp in milliseconds: 1434672000000
#Human time (GMT): Fri, 19 Jun 2015 00:00:00 GMT
#Human time (your time zone): 6/19/2015, 9:00:00 AM

# Epoch timestamp: 1435330800
# Timestamp in milliseconds: 1435330800000
# Human time (your time zone): 6/27/2015, 12:00:00 AM
# Human time (GMT): Fri, 26 Jun 2015 15:00:00 GMT

# First campaign ran from 19/06/2015 to 26/06/2015

report1st<- report[ (report$timestamp >= 1434672000000) & (report$timestamp < 1435330800000),]

user1st <- user
#new users who joined during the campaign for the first time
user1st_new<- user[ (user$joined >= 1434672000000) & (user$joined < 1435330800000),]

user1stTaskFinished<- user[ (user$yahooTaskFinished >= 1434672000000) & (user$yahooTaskFinished < 1435330800000),]

#get date field
report1st$date = as.Date(as.POSIXct(report1st$timestamp/1000.0, origin="1970-01-01"))