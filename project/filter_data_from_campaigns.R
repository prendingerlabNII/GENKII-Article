

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
user1st$date = as.Date(as.POSIXct(user1st$joined/1000.0, origin="1970-01-01"))

#get date field
report1st$date = as.Date(as.POSIXct(report1st$timestamp/1000.0, origin="1970-01-01"))


#we only count users that joined prior to 24
filtered_user_reports1st <- report1st[report1st$user_id<196,]

filtered_user_reports1st <- merge(x=filtered_user_reports1st, y=reward_unlocked, by = "id")

reports_rewards <-filtered_user_reports1st[filtered_user_reports1st$reward>0 & filtered_user_reports1st$reward<11,]



################################## 2nd Campaign
#
# Epoch timestamp: 1436313622
# Timestamp in milliseconds: 1436313622000
# Human time (GMT): Wed, 08 Jul 2015 00:00:22 GMT
# Human time (your time zone): 7/8/2015, 9:00:22 AM

# Epoch timestamp: 1436918422
# Timestamp in milliseconds: 1436918422000
# Human time (GMT): Wed, 15 Jul 2015 00:00:22 GMT
# Human time (your time zone): 7/15/2015, 9:00:22 AM

report2nd<- report2[ (report2$timestamp >= 1436313622000) & (report2$timestamp < 1436918422000),]

user2nd <- user2
#new users who joined during the campaign for the first time
user2nd_new<- user2[ (user2$joined >= 1436313622000) & (user2$joined < 1436918422000),]

user2ndTaskFinished<- user2[ (user2$yahooTaskFinished >= 1436313622000) & (user2$yahooTaskFinished < 1436918422000),]
user2nd$date = as.Date(as.POSIXct(user2nd$joined/1000.0, origin="1970-01-01"))

#get date field
report2nd$date = as.Date(as.POSIXct(report2nd$timestamp/1000.0, origin="1970-01-01"))


#we only count users that joined prior to 24
filtered_user_reports2nd <- report2nd[report2nd$user_id<330,]

filtered_user_reports2nd <- merge(x=filtered_user_reports2nd, y=reward_unlocked2, by = "id")

reports_rewards2 <-filtered_user_reports2nd[filtered_user_reports2nd$reward>0 & filtered_user_reports2nd$reward<11,]

##### GENKII TERRITORY
## in orderto calculate the genkii territory we're going to select all the users from the 2 campaigns
genkii_territory <- report2[ ((report2$timestamp >= 1434672000000) & (report2$timestamp < 1435330800000)) | ((report2$timestamp >= 1436313622000) & (report2$timestamp < 1436918422000)),]
genkii_territory$date = as.Date(as.POSIXct(genkii_territory$timestamp/1000.0, origin="1970-01-01"))
##we also want the users who made at least 6 reports
genkii_territory_users <- as.data.frame(table(genkii_territory$user_id))
genkii_territory_users <- genkii_territory_users[genkii_territory_users$Freq>=6,]
genkii_territory <- genkii_territory[genkii_territory$user_id %in% genkii_territory_users$Var1 ,]

#### GENKII Evolution

genkii_over_hour <- report2[ ((report2$timestamp >= 1434672000000) & (report2$timestamp < 1435330800000)) | ((report2$timestamp >= 1436313622000) & (report2$timestamp < 1436918422000)),]



