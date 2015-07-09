

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
sd(as.data.frame(table(report1st$user_id))$Freq)
mean(as.data.frame(table(report1st$user_id))$Freq)
median(as.data.frame(table(report1st$user_id))$Freq)
var(as.data.frame(table(report1st$user_id))$Freq)
sd(as.data.frame(table(report1st$user_id))$Freq)

summary(as.data.frame(table(report1st$user_id)))

plot(as.data.frame(ftable(table(report1st$user_id))), xlab= "Number of reports made by a user", main="Frequency of the Number of Reports Made by the Users")
Axis(as.data.frame(ftable(table(report1st$user_id))), at = c(0,5,10,15,20,25,30,35,40),side=2)
axTicks(side=2)
grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted",lwd = par("lwd"))
legend(text.font=12)
#histogram of the frequency of reports
hist(as.POSIXct(report1st$timestamp/1000.0, origin="1970-01-01"),"days", freq=TRUE, xlab="Campaign days", ylab="Number of Reports", main="Frequency of Reports During the Campaign") 

#new of users joining
hist(as.POSIXct(user1st_new$joined/1000.0, origin="1970-01-01"),"days", freq=TRUE, xlab="Campaign days", ylab="Number of Users that Joined", main="New Users")

#people who reportonly once
data<-report1st[which(as.data.frame(table(report1st$user_id))$Freq ==1),]
barplot(table(data['gesture_confirmation_id']), names.arg = c('Happy', 'Okay', 'Sad'), main = 'Frequency of Reported Gestures')


df<-NULL;
i= 1
while(i<21){
  #Some code that generates new row
  aux<-as.data.frame(ftable(table(report1st$user_id)))
  #data<-report1st[which(as.data.frame(table(report1st$user_id))$Freq ==aux[1][i,]),]
  data <- report1st[ report1st$user_id %in% as.data.frame(table(report1st$user_id))[which(as.data.frame(table(report1st$user_id))$Freq ==aux[1][i,]),1] ,]
  rbind(df,c(nrow(data[data['gesture_confirmation_id']==1,])/nrow(data), nrow(data[data['gesture_confirmation_id']==2,])/nrow(data), nrow(data[data['gesture_confirmation_id']==3,])/nrow(data)))->df
 data
  i<-i+1
#  nrow(data[data['gesture_confirmation_id']==1,])/nrow(data)
#  nrow(data[data['gesture_confirmation_id']==2,])/nrow(data)
#  nrow(data[data['gesture_confirmation_id']==3,])/nrow(data)
}
#as.data.frame(table(report1st$user_id))[which(as.data.frame(table(report1st$user_id))$Freq ==aux[1][2,]),1]
color <-  c("forestgreen", "skyblue4", "indianred", "indianred", "skyblue4",
              +             "lightblue")
barplot(t(df), col=color)
