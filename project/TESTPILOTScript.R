

## PAST CAMPAIGN SCRIPT


library(dygraphs)

summary(report)

data <- read.table("report.csv", header = TRUE, sep = ",")
data <- report;

#report['user_id']

#Gesture Accuracy
accuracy <- ((data['gesture_id'] - data['gesture_confirmation_id']) ==0)
mean(accuracy)

#count(accuracy == FALSE)
as.data.frame(table(accuracy))

barplot(table(accuracy) , names.arg = c('Inaccurate Predictions N=35', 'Acurate Predictions N=163'),main = 'Frequency of Gesture Prediction')

#confirmed_circles <- data where (data['gesture_confirmation_id']  ==0)
barplot(table(data['gesture_confirmation_id']), names.arg = c('Happy', 'Okay', 'Sad'), main = 'Frequency of Reported Gestures')

#genkiiness over time
n <- data[c('gesture_confirmation_id','timestamp')]
plot(n$timestamp, n$gesture_confirmation_id)

library(plyr)

freq_table <- ddply(data, ~gesture_confirmation_id, summarize, reported1=sum(gesture_id==1), reported2=sum(gesture_id==2), reported3= sum(gesture_id==3) )

prob_table <- freq_table[,-1]/nrow(data)

#Accuracy per hand
left_handed <-hand_gesture[which(hand_gesture$hand=='Left'),]
right_handed <-hand_gesture[which(hand_gesture$hand=='Right'),]
mean(((left_handed['gesture_id'] - left_handed['gesture_confirmation_id']) ==0))
mean(((right_handed['gesture_id'] - right_handed['gesture_confirmation_id']) ==0))

#latex table
library(xtable)
xtable(prob_table)

#----percentage of yahoo users
#number yahoo users
no_yahoo_users <- sum(user$isYahoo)
#number of users
no_users <- nrow(user)
percentage_yahoo <- no_yahoo_users/no_users

barplot(table(user['isYahoo']), names.arg = c('Not Yahoo', 'Yahoo'), main = 'Frequency of Yahoo Crowdsource Participants')

#####
barplot(table(ever['user_id']), names.arg = unique(ever['user_id'])$user_id, main = 'Frequency of Reported Gestures by User', xlab='User IDs')
nrow(unique(ever['user_id']))

user_reports<- as.data.frame(table(ever['user_id']))
boxplot(user_reports$Freq)
median(user_reports$Freq)
quantile(user_reports$Freq)
mean(user_reports$Freq)
sd(user_reports$Freq)

z=dnorm(mean=mean(user_reports$Freq), sd(user_reports$Freq)) 


hist(user_reports$Freq, prob=F, main="Distribution of User Reports", xlab='Number of user reports')

yahoo_users <- ever[which(ever['isYahoo']== '1'),]
non_yahoo_users <- ever[which(ever['isYahoo']== '0'),]
yahoo_users <-as.data.frame(table(yahoo_users$user_id))
non_yahoo_users <-as.data.frame(table(non_yahoo_users$user_id))

boxplot(yahoo_users$Freq,non_yahoo_users$Freq,ylab="Number Reports",names=c("Yahoo","Non Yahoo"), main="Box Plot for the Reporting Frequency")

t.test(yahoo_users$Freq,non_yahoo_users$Freq)