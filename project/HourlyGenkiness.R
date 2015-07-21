### GENKII OVER HOUR


as.POSIXct(report2nd$timestamp/1000.0,, origin="1970-01-01", tz="Japan")


#(time %% 86400) / 3600)
plot( table(floor(((genkii_over_hour$timestamp/1000%% 86400) / 3600)+9)%%24),  main="Report Frequency Over a Day Cycle", xlab="Hour", ylab="Frequency" )


sum(table(floor(((genkii_over_hour$timestamp%% 86400) / 3600)+9)%%24))

genkii_over_hour$hour <- floor(((genkii_over_hour$timestamp/1000%% 86400) / 3600)+9)%%24

df<-NULL;
i= 0
while(i<24){
  #Some code that generates new row
  aux<-as.data.frame(ftable(table(genkii_over_hour$hour)))
  #data<-report2nd[which(as.data.frame(table(report2nd$user_id))$Freq ==aux[1][i,]),]
  data <- genkii_over_hour[ which(genkii_over_hour$hour ==i) ,]
  rbind(df,c(nrow(data[data['gesture_confirmation_id']==1,])/nrow(data), nrow(data[data['gesture_confirmation_id']==2,])/nrow(data), nrow(data[data['gesture_confirmation_id']==3,])/nrow(data)))->df
  data
  i<-i+1
  #  nrow(data[data['gesture_confirmation_id']==1,])/nrow(data)
  #  nrow(data[data['gesture_confirmation_id']==2,])/nrow(data)
  #  nrow(data[data['gesture_confirmation_id']==3,])/nrow(data)
}
#as.data.frame(table(report2nd$user_id))[which(as.data.frame(table(report2nd$user_id))$Freq ==aux[1][2,]),1]
color <-  c("forestgreen", "skyblue4", "indianred", "indianred", "skyblue4",
            +             "lightblue")



bp<-barplot(t(df) *as.data.frame(table(floor(((genkii_over_hour$timestamp/1000%% 86400) / 3600)+9)%%24))$Freq  , col=color, xlab='Hour', main="Genkiiness Over a Day Cycle")
axis(1, at=bp, labels=as.data.frame(table(genkii_over_hour$hour))$Var1)
legend("topright", 
       legend = c("Happy", "OK", "Sad"), 
       fill = color)

length(which(genkii_over_hour$gesture_confirmation_id == 1))
length(which(genkii_over_hour$gesture_confirmation_id == 2))
length(which(genkii_over_hour$gesture_confirmation_id == 3))

bp<-barplot(t(df)   , col=color, xlab='Hour', main="Genkiiness Over a Day Cycle")
axis(1, at=bp, labels=as.data.frame(table(genkii_over_hour$hour))$Var1)
legend("topright", 
       legend = c("Happy", "OK", "Sad"), 
       fill = color)
lines(0.49)

