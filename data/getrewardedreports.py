
from os import walk
import csv
import random
from collections import defaultdict

##
## Write a csv with report_id user_id reward_unlocked
##
## Reward unlocked 0- no reward
## number of reward if there's an unlock


field_names = ["id", "user_id", "reward"]

user_report_dic= defaultdict(list)
user_report_reward= defaultdict(list)
with open('filteredresults1st.csv', 'r') as red:
    reader = csv.DictReader(red)
    with open('reward_unlocked.csv', 'wb') as f:  # Just use 'w' mode in 3.x
            w = csv.DictWriter(f, field_names)
            w.writeheader()

            for row in reader:
                if len(user_report_dic[row['user_id']]) ==0:
                    user_report_dic[row['user_id']].append(row['timestamp'])
                    user_report_reward[row['user_id']].append(1)
                else:           
                    last_reward=0
                    last_reward_number=0
                    for i in range(0, len(user_report_reward[row['user_id']])):
                        if user_report_reward[row['user_id']][i]>0:
                            last_reward=user_report_dic[row['user_id']][i] 
                            last_reward_number=user_report_reward[row['user_id']][i]
                    
                    dif =  (float(row['timestamp']) - float(last_reward))/1000.0/3600.0

                    if dif >4:
                        user_report_dic[row['user_id']].append(row['timestamp'])
                        user_report_reward[row['user_id']].append(last_reward_number+1)
                    else:
                        user_report_dic[row['user_id']].append(row['timestamp'])
                        user_report_reward[row['user_id']].append(0)
            
                w.writerow({field_names[0]:row['id'], field_names[1]:row['user_id'], field_names[2]:user_report_reward[row['user_id']][-1]})

