

##First campaign analysis


#Gesture Accuracy
accuracy <- ((report1st['gesture_id'] - report1st['gesture_confirmation_id']) ==0)
mean(accuracy)

#count(accuracy == FALSE)
as.data.frame(table(accuracy))

barplot(table(accuracy) , names.arg = c('Inaccurate Predictions N=64', 'Acurate Predictions N=372'),main = 'Frequency of Gesture Prediction')





## Frequency of reports made by each user
table(report1st$user_id)
plot(table(report1st$user_id))

#frequency table
ftable(table(report1st$user_id))

plot(as.data.frame(ftable(table(report1st$user_id))), xlab= "Number of reports made by a user", main="Frequency of the Number of Reports Made by the Users")


#histogram of the frequency of reports
hist(as.POSIXct(report1st$timestamp/1000.0, origin="1970-01-01"),"days", freq=TRUE, xlab="Campaign days", ylab="Number of Reports", main="Frequency of Reports During the Campaign") 

#new of users joining
hist(as.POSIXct(user1st_new$joined/1000.0, origin="1970-01-01"),"days", freq=TRUE, xlab="Campaign days", ylab="Number of Users that Joined", main="New Users")