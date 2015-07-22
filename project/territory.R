

##### GENKII TERRITORY

df <- 
c(
length(
territory$area_km2[which(territory$area_km2<2)]
), length(
territory$area_km2[which(territory$area_km2<10&  territory$area_km2>=2)]
), length(
territory$area_km2[which(territory$area_km2<500&  territory$area_km2>=10)]
), length(
territory$area_km2[which(territory$area_km2<5000&  territory$area_km2>=500)]
), length(
territory$area_km2[which( territory$area_km2>=5000)]
))

col <- c("blue", "green", "yellow", "orange", "red")

lbls <- c("[0, 2)", "[2, 10)","[10, 500)","[500, 5000)","[5000, +inf)")

bp<-barplot(df, col =col, xlab="Area km2", ylab="Number Users", main= "Genkii Territory")
axis(1, at=bp, labels=lbls)
legend("topright", 
       legend = c("House Dweller", "Neighborhood Dweller ", "Commuter", "Long Distance Commuter","Traveller"), 
       fill = col)

