
from os import walk
import csv
import random
from collections import defaultdict

##
## Calculatesthe genkii territory for a csv with the table reports from the database
##
## Outputs a file with the area associated with every user_id considered
## 

##   area = abs((point_1[0]*point_2[1]-point_2[0]*point_1[1]) + (point_2[0]*point_3[1]-point_3[0]*point_2[1]) + (point_3[0]*point_4[1]-point_4[0]*point_3[1])+ (point_4[0]*point_1[1]-point_1[0]*point_4[1]))/2
## point_1 = (lattitude_max , longitude_min)
## point_2 = (lattitude_max , longitude_max)
## point_3 = (lattitude_min , longitude_max)
## point_4 = (lattitude_min , longitude_min)
## http://www.mathopenref.com/coordpolygonarea.html
##
##

def area_polygon4(point_1, point_2, point_3, point_4):
    return abs((point_1[0]*point_2[1]-point_2[0]*point_1[1]) + (point_2[0]*point_3[1]-point_3[0]*point_2[1]) + (point_3[0]*point_4[1]-point_4[0]*point_3[1])+ (point_4[0]*point_1[1]-point_1[0]*point_4[1]))/2 

def reproject(latitude, longitude):
    """Returns the x & y coordinates in meters using a sinusoidal projection"""
    from math import pi, cos, radians
    earth_radius = 6371009 # in meters
    lat_dist = pi * earth_radius / 180.0

    y = [lat * lat_dist for lat in latitude]
    x = [longe * lat_dist * cos(radians(lat)) 
                for lat, longe in zip(latitude, longitude)]
    return x, y

lattitude_max=2
lattitude_min =0
longitude_min=0
longitude_max=4
point_1 = (lattitude_max , longitude_min)
point_2 = (lattitude_max , longitude_max)
point_3 = (lattitude_min , longitude_max)
point_4 = (lattitude_min , longitude_min)

print area_polygon4(point_1, point_2, point_3, point_4)






field_names = ["user_id", "area", "area_km2" , 'lat_min', 'lat_max','lon_min', 'lon_max' ]
## [lat_min,lat_max, long_min, long_max]
init = [999,0,999,0] 
user_report_dic= defaultdict(list)
user_report_reward= defaultdict(list)
with open('genkii_territory.csv', 'r') as red:
    reader = csv.DictReader(red)
    
    for row in reader:
        if len(user_report_dic[row['user_id']]) ==0:
            user_report_dic[row['user_id']]= [row['latitude'],row['latitude'],row['longitude'],row['longitude']]
            
        else:           
            if user_report_dic[row['user_id']][0] < row['latitude']:
                user_report_dic[row['user_id']][0] =row['latitude']
            elif user_report_dic[row['user_id']][1]>row['latitude']:
                user_report_dic[row['user_id']][1] =row['latitude']
            if user_report_dic[row['user_id']][2] < row['longitude']:
                user_report_dic[row['user_id']][2] =row['longitude']
            elif user_report_dic[row['user_id']][3]>row['longitude']:
                user_report_dic[row['user_id']][3] =row['longitude']


            
with open('territory.csv', 'wb') as f:  # Just use 'w' mode in 3.x
    w = csv.DictWriter(f, field_names)
    w.writeheader()
    for i in user_report_dic.keys():
        #print user_report_dic[i]
        
        latitude = (float(user_report_dic[i][0]) , float(user_report_dic[i][1]))
        longitude = (float(user_report_dic[i][2]) , float(user_report_dic[i][3]))
        projected = reproject(latitude, longitude)
        print projected
        lattitude_max= projected[0][1]
        lattitude_min =projected[0][0]
        longitude_min=projected[1][0]
        longitude_max=projected[1][1]
        point_1 = (lattitude_max , longitude_min)
        point_2 = (lattitude_max , longitude_max)
        point_3 = (lattitude_min , longitude_max)
        point_4 = (lattitude_min , longitude_min)

        


        area = area_polygon4(point_1, point_2, point_3, point_4)
        w.writerow({ field_names[0]:i, field_names[1]:area, field_names[2]:area/100/100/100 , field_names[3]:float(user_report_dic[i][0]), field_names[4]:float(user_report_dic[i][1]), field_names[5]:float(user_report_dic[i][2]), field_names[6]:float(user_report_dic[i][3])})

