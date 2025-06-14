/*

# Data quality tests 

1. The data needs to be 100 records of YouTube channels (row count test)	--- (passed!!!)
2. The data needs 4 fields (column count test)								--- (passed!!!)
3. The channel name column must be string format, and the other columns must be numerical data types (data type check)    --- (passed!!!)
4. Each record must be unique in the dataset (duplicate count check)  --- (passed!!!)


Row count - 100 
Column count - 4


Data types

channel_name = VARCHAR
total_subscribers = INTEGER
total_views = INTEGER
total_videos = INTEGER

Duplicate count = 0


*/

-- 1. Row count check 
SELECT count(*) as row_check
FROM top_influencers
;

-- 2. Column count check 

SELECT COUNT(*)  
FROM INFORMATION_SCHEMA.COLUMNS  
WHERE TABLE_SCHEMA = 'youtube_db'  
AND TABLE_NAME = 'top_influencers';

-- 3. Data type check 

SELECT COLUMN_NAME, DATA_TYPE  
FROM INFORMATION_SCHEMA.COLUMNS  
WHERE TABLE_SCHEMA = 'youtube_db'  
AND TABLE_NAME = 'top_influencers';

-- 4. Duplicate records check

SELECT channel_name, COUNT(*) AS row_count  
FROM youtube_db.influencers  
GROUP BY channel_name  
HAVING COUNT(*) > 1;