

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

barplot(df, col =col)

