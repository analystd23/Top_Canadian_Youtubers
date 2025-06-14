/*
1.Define variables
2.Create CTE that rounds the average views per video
3.Select the rolls that require for analysis
4.Filter the results by youtube channels with the highest subscriber bases
5.Order by net_profit (Highest to Lowest) */



-- 1,
SET @conversionRate = 0.04;  -- The conversation rate 4%
SET @productCost = 11.00; -- The product Cost @ 11 dollars
SET @campaignCost = 6000000.00; -- The Campaign cost @ 6 million 

-- 2,
WITH channel_data AS (
    SELECT 
        CHANNEL_NAME,
        TOTAL_VIEWS,
        TOTAL_VIDEOS,
        ROUND(CAST(TOTAL_VIEWS AS FLOAT) / TOTAL_VIDEOS, -4) AS rounded_avg_views_per_videos,
        CEIL(TOTAL_VIEWS/TOTAL_VIDEOS) as original_avg_views_per_videos
    FROM youtube_db.top_influencers
)
SELECT * FROM channel_data;


-- 3
WITH channel_data AS (
    SELECT 
        CHANNEL_NAME,
        TOTAL_VIEWS,
        TOTAL_VIDEOS,
        TOTAL_SUBS,
        ROUND(CAST(TOTAL_VIEWS AS FLOAT) / TOTAL_VIDEOS, -4) AS rounded_avg_views_per_videos,
        CEIL(TOTAL_VIEWS/TOTAL_VIDEOS) as original_avg_views_per_videos
    FROM youtube_db.top_influencers
)
SELECT 
CHANNEL_NAME,
rounded_avg_views_per_videos,
(rounded_avg_views_per_videos * @ConversionRate) as Potential_units_sold_per_video,
(rounded_avg_views_per_videos * @ConversionRate * @productCost) as Potential_revenue_per_video,
(rounded_avg_views_per_videos * @ConversionRate * @productCost) - @campaignCost as net_profit 

FROM channel_data

-- 4 & 5

ORDER BY TOTAL_SUBS DESC
LIMIT 3;


