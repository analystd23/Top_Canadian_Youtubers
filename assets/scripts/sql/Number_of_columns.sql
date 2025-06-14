/*
# 2.Column count check 
count number of columns 

*/

SELECT COUNT(*)  Number_of_columns
FROM INFORMATION_SCHEMA.COLUMNS  
WHERE TABLE_SCHEMA = 'youtube_db'  
AND TABLE_NAME = 'top_influencers';
