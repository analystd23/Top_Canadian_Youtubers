/* 
1. check for duplicate rows
2. group by channel name  
3. filter for groups with more than one row
*/

SELECT CHANNEL_NAME, COUNT(*) AS duplicate_count  
FROM youtube_db.top_influencers  
GROUP BY CHANNEL_NAME  
HAVING COUNT(*) > 1;
