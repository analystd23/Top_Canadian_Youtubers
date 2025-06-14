/* 
1. check for duplicate rows
2. group by channel name  
3. filter for groups with more than one row
*/

SELECT channel_name, COUNT(*) AS duplicate_count  
FROM youtube_db.top_influencers  
GROUP BY channel_name  
HAVING COUNT(*) > 1;