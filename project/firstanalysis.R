

##First campaign analysis


#Gesture Accuracy
accuracy <- ((report1st['gesture_id'] - report1st['gesture_confirmation_id']) ==0)
mean(accuracy)
