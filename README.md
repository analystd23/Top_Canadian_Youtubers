# Data Portfolio: Excel to Power BI 


![excel-to-powerbi-animated-diagram](assets/images/Excel_to_SQL_to_Power_BI.png)




# Table of contents 

- [Objective](#objective)
- [Data Source](#data-source)
- [Stages](#stages)
- [Design](#design)
  - [Mockup](#mockup)
  - [Tools](#tools)
- [Development](#development)
  - [Pseudocode](#pseudocode)
  - [Data Exploration](#data-exploration)
  - [Data Cleaning](#data-cleaning)
  - [Create the SQL View](#create-the-sql-view)
- [Testing](#testing)
  - [Data Quality Tests](#data-quality-tests)
- [Visualization](#visualization)
  - [Results](#results)
  - [DAX Measures](#dax-measures)
- [Analysis](#analysis)
  - [Findings](#findings)
  - [Validation](#validation)
  - [Discovery](#discovery)
- [Recommendations](#recommendations)
  - [Potential ROI](#potential-roi)
  - [Potential Courses of Actions](#potential-courses-of-actions)
- [Conclusion](#conclusion)




# Objective 

- What is the key pain point? 

The Head of Marketing wants to find out who the top YouTubers are to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.


- What is the ideal solution? 

To create a dashboard that provides insights into the top Candian YouTubers that includes their 
- subscriber count
- total views
- total videos, and
- engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

## User story 

As the Head of Marketing, I want to use a dashboard that analyses YouTube channel data in Canada . 

This dashboard should allow me to identify the top performing channels based on metrics like subscriber base and average views. 

With this information, I can make more informed decisions about which Youtubers are right to collaborate with, and therefore maximize how effective each marketing campaign is.


# Data source 

- What data is needed to achieve our objective?

We need data on the top UK YouTubers in 2024 that includes their 
- channel names
- total subscribers
- total views
- total videos uploaded



- Where is the data coming from? 
The data is sourced from Kaggle (an Excel extract), [see here to find it.](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download)


# Stages

- Design
- Developement
- Testing
- Analysis 
 


# Design 

## Dashboard components required 
- What should the dashboard contain based on the requirements provided?

To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis. 


## Dashboard mockup

- What should it look like? 

Some of the data visuals that may be appropriate in answering our questions include:

1. Table
2. Treemap
3. Scorecards
4. Horizontal bar chart 




![Dashboard-Mockup](assets/images/Mokkup.png)


## Tools 


| Tool | Purpose |
| --- | --- |
| Excel | Exploring the data |
| SQL Server | Cleaning, testing, and analyzing the data |
| Power BI | Visualizing the data via interactive dashboards |
| GitHub | Hosting the project documentation and version control |
| Mokkup AI | Designing the wireframe/mockup of the dashboard | 


# Development

## Pseudocode

- What's the general approach in creating this solution from start to finish?

1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

## Data exploration notes

This is the stage where you have a scan of what's in the data, errors, inconcsistencies, bugs, weird and corrupted characters etc  


- What are your initial observations with this dataset? What's caught your attention so far? 

1. There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data. 
2. The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol - we need to extract the channel names from this.
3. Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.
4. We have more data than we need, so some of these columns would need to be removed





## Data cleaning 
- What do we expect the clean data to look like? (What should it contain? What contraints should we apply to it?)

The aim is to refine our dataset to ensure it is structured and ready for analysis. 

The cleaned data should meet the following criteria and constraints:

- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

Below is a table outlining the constraints on our cleaned dataset:

| Property | Description |
| --- | --- |
| Number of Rows | 100 |
| Number of Columns | 4 |

And here is a tabular representation of the expected schema for the clean data:

| Column Name | Data Type | Nullable |
| --- | --- | --- |
| channel_name | VARCHAR | NO |
| total_subscribers | INTEGER | NO |
| total_views | INTEGER | NO |
| total_videos | INTEGER | NO |



- What steps are needed to clean and shape the data into the desired format?

1. Remove unnecessary columns by only selecting the ones you need
2. Extract Youtube channel names from the first column
3. Rename columns using aliases



### Create the SQL view 

```sql
/*
# 1. Create a view to store the transformed data
# 2. Cast the extracted channel name as VARCHAR(100)
# 3. Select the required columns from the top_uk_youtubers_2024 SQL table 
*/

-- 1.
CREATE VIEW youtube_db.top_influencers AS

-- 2.
SELECT
     CHANNEL_NAME,
     TOTAL_VIEWS,
     TOTAL_VIDEOS,
     TOTAL_SUBS

-- 3.
FROM
    youtube_db.influencers

```


# Testing 

- What data quality and validation checks are you going to create?

Here are the data quality tests conducted:

## Row count check
```sql
/*
# Count the total number of records (or rows) are in the SQL view
*/

select 
     count(*) as Number_of_row
from
      youtube_db.top_influencers;

```

![Row count check](assets/images/Number_of_rows.png)



## Column count check
### SQL query 
```sql
/*
# Count the total number of columns (or fields) are in the SQL view
*/


SELECT 
      COUNT(*)  Number_of_columns
FROM 
     INFORMATION_SCHEMA.COLUMNS  
WHERE 
     TABLE_SCHEMA = 'youtube_db'  
      AND TABLE_NAME = 'top_influencers';
```
### Output 
![Column count check](assets/images/Number_of_columns.png)



## Data type check
### SQL query 
```sql
/*
# Check the data types of each column from the view by checking the INFORMATION SCHEMA view
*/

-- 1.
SELECT 
      COLUMN_NAME,
      DATA_TYPE  
FROM 
     INFORMATION_SCHEMA.COLUMNS  
WHERE
      TABLE_SCHEMA = 'youtube_db'  
      AND TABLE_NAME = 'top_influencers';
```
### Output
![Data type check](assets/images/Data_type.png)


## Duplicate count check
### SQL query 
```sql
/*
# 1. Check for duplicate rows in the view
# 2. Group by the channel name
# 3. Filter for groups with more than one row
*/


-- 1.
SELECT 
       CHANNEL_NAME, 
       COUNT(*) AS duplicate_count  
FROM 
    youtube_db.top_influencers 

--2 
GROUP BY 
        CHANNEL_NAME 

--3
HAVING 
      COUNT(*) > 1;
```
### Output
![Duplicate count check](assets/images/Duplicate_check.png)

# Visualization 


## Results

- What does the dashboard look like?

![GIF of Power BI Dashboard](assets/images/Top_100_Canadian_Youtubers.png)

This shows the Top Candian Youtubers so far. 


## DAX Measures

### 1. Total Subscribers (M)
```sql
Total_subscribers (M) = 
VAR Millions = 1000000
VAR sumofsubscribers = SUM(cleaned_top100_canadian_youtubers[TOTAL_SUBS])
VAR totalsubscribers = DIVIDE(sumofsubscribers, Millions)

RETURN totalsubscribers

```

### 2. Total Views (B)
```sql
Total_views (B) = 
VAR billion = 1000000000
VAR sumoftoyalviews = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIEWS])
VAR totalviews = DIVIDE(sumoftoyalviews, billion)

RETURN totalviews

```

### 3. Total Videos
```sql
Total_vids = 
VAR totalvideos = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIDEOS])

RETURN totalvideos

```

### 4. Average Views Per Video (M)
```sql
Avg_views_Per/video (M) = 
VAR sumoftotalviews = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIEWS])
VAR sumoftotalvideos = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIDEOS])
VAR averageviewsPervideo = DIVIDE(sumoftotalviews, sumoftotalvideos, BLANK())
VAR finalaverageviewsPervideo = DIVIDE(averageviewsPervideo, 1000000, BLANK())

RETURN finalaverageviewsPervideo

```


### 5. Subscriber Engagement Rate
```sql
Subscriber_engagement_rate = 
VAR sumoftotalsubcribers = SUM(cleaned_top100_canadian_youtubers[TOTAL_SUBS])
VAR sumoftotalvideos = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIDEOS])
VAR subscriberEngagementRate = DIVIDE(sumoftotalsubcribers, sumoftotalvideos, BLANK())

RETURN subscriberEngagementRate

```


### 6. Views per subscriber
```sql
viewsPerSubscriber = 
VAR sumoftotalviews = SUM(cleaned_top100_canadian_youtubers[TOTAL_VIEWS])
VAR sumoftotalsubscribers = SUM(cleaned_top100_canadian_youtubers[TOTAL_SUBS])
VAR viewsPerSubscriber = DIVIDE(sumoftotalviews, sumoftotalsubscribers,BLANK())

RETURN viewsPerSubscriber

```




# Analysis 

## Findings

- What did we find?

For this analysis, we're going to focus on the questions below to get the information we need for our marketing client - 

Here are the key questions we need to answer for our marketing client: 
1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?


### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name         | Subscribers (M) |
|------|----------------------|-----------------|
| 1    | Justin Bieber        | 75.40           |
| 2    | Super Simple songs   | 44.30           |
| 3    | The weekend          | 37.90           |
| 4    | WatchMojo.com        | 25.80           |
| 5    | Linus Tech Tips      | 16.30           |
| 6    | Typical Gamer        | 15.70           |
| 7    | Hacksmith Industries | 15.30           |
| 8    | AzzyLand             | 13.00           |
| 9    | HZHtube Kids Fun     | 13.00           |
| 10   | MrsuicideSheep       | 12.90           |


### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name     | Videos Uploaded |
|------|------------------|-----------------|
| 1    | Global News      | 45,751          |
| 2    | WatchMojo.com    | 29,881          |
| 3    | Step News Agency | 13,587          |



### 3. Which 3 channels have the most views?


| Rank | Channel Name                     | Total Views (B) |             
|------|----------------------------------|-----------------|
| 1    | Super Simple Songs -kids songs   | 56.38           |
| 2    | Justin Bieber                    | 34.86           |
| 3    | The Weekend                      | 32.12           |


### 4. Which 3 channels have the highest average views per video?

| Rank   | Channel Name              | Average Views per Video (M) |
|--------|---------------------------|-----------------------------|
| 1      | The WeekendSuper          | 160.59                      |
| 2      | Justin Bieber             | 140.00                      |
| 3      | Simple Songs -kids songs  | 670.37                      |


### 5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel Name                   | Views per Subscriber        |
|------|--------------------------------|---------------------------- |
| 1    | Super Simple Songs -kids songs | 1272.64                     |
| 2    | Super Simple ABCs              | 970.05                      |
| 3    | SpyCakes                       | 961.60                      |



### 6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel Name       | Subscriber Engagement Rate  |
|------|--------------------|---------------------------- |
| 1    | Justin Bieber      |  302,811.26                 |
| 2    | The Weeknd         |  189,500.00                 |
| 3    | Two Super Sister 2 |  165,217.39                 |




### Notes

For this analysis, we'll prioritize analysing the metrics that are important in generating the expected ROI for our marketing client, which are the YouTube channels wuth the most 

- subscribers
- total views
- videos uploaded



## Validation 

### 1. Youtubers with the most subscribers 

#### Calculation breakdown

Campaign idea = product placement 

1. Justin Bieber  
- Average views per video = 140 million
- Product cost = $11
- Potential units sold per video = 6.92 million x 4% conversion rate = 5,600,000 units sold
- Potential revenue per video = 5,600,000 x $11 = $61,600,000
- Campaign cost (one-time fee) = $6,000,000
- **Net profit = $61,600,000 - $6,000,000 = $55,600,000**

2. Super Simple songs - Kid songs

- Average views per video = 67.04 million
- Product cost = $11
- Potential units sold per video = 67.04 million x 4% conversion rate = 2,681,600 units sold
- Potential revenue per video = 2,681,600 x $11 = $29,497,600
- Campaign cost (one-time fee) = $6,000,000
- **Net profit = $29,497,600 - $6,000,000 = $23,497,600**

c. The weekend

- Average views per video = 160.06 million
- Product cost = $11
- Potential units sold per video = 160.06 million x 4% conversion rate = 6,402,400 units sold
- Potential revenue per video = 6,402,400 x $11 = $70,426,400
- Campaign cost (one-time fee) = $6,000,000
- **Net profit = $70,426,000 - $6,000,000 = $64,426,400**


Best option from category: The weekend


#### SQL query 

```sql
/* 

# 1. Define variables 
# 2. Create a CTE that rounds the average views per video 
# 3. Select the column you need and create calculated columns from existing ones 
# 4. Filter results by Youtube channels
# 5. Sort results by net profits (from highest to lowest)

*/


-- 1. 
SET @conversionRate = 0.04;  -- The conversation rate 4%
SET @productCost = 11.00; -- The product Cost @ 11 dollars
SET @campaignCost = 6000000.00; -- The Campaign cost @ 6 million 


-- 2.  
WITH channel_data AS (
    SELECT 
        CHANNEL_NAME,
        TOTAL_VIEWS,
        TOTAL_VIDEOS,
        ROUND(CAST(TOTAL_VIEWS AS FLOAT) / TOTAL_VIDEOS, -4) AS rounded_avg_views_per_videos
    FROM youtube_db.top_influencers
)

-- 3. 
SELECT 
CHANNEL_NAME,
rounded_avg_views_per_videos,
(rounded_avg_views_per_videos * @ConversionRate) as Potential_units_sold_per_video,
(rounded_avg_views_per_videos * @ConversionRate * @productCost) as Potential_revenue_per_video,
(rounded_avg_views_per_videos * @ConversionRate * @productCost) - @campaignCost as net_profit 

FROM channel_data


-- 4 & 5

ORDER BY TOTAL_VIEWS DESC
LIMIT 3;

```

#### Output

![Most subsc](assets/images/Youtuber_with_most_subs.png)


### 2.  Youtubers with the most views 

#### Calculation breakdown

Campaign idea = Influencer marketing 

a. DanTDM

- Average views per video = 5.34 million
- Product cost = $5
- Potential units sold per video = 5.34 million x 2% conversion rate = 106,800 units sold
- Potential revenue per video = 106,800 x $5 = $534,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $534,000 - $130,000 = $404,000**

b. Dan Rhodes

- Average views per video = 11.15 million
- Product cost = $5
- Potential units sold per video = 11.15 million x 2% conversion rate = 223,000 units sold
- Potential revenue per video = 223,000 x $5 = $1,115,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $1,115,000 - $130,000 = $985,000**

c. Mister Max

- Average views per video = 14.06 million
- Product cost = $5
- Potential units sold per video = 14.06 million x 2% conversion rate = 281,200 units sold
- Potential revenue per video = 281,200 x $5 = $1,406,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $1,406,000 - $130,000 = $1,276,000**

Best option from category: Mister Max



#### SQL query 
```sql
/*
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/



-- 1.
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;            -- The product cost @ $5
DECLARE @campaignCost MONEY = 130000.0;      -- The campaign cost @ $130,000



-- 2.
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND(CAST(total_views AS FLOAT) / total_videos, -4) AS avg_views_per_video
    FROM
        youtube_db.dbo.view_uk_youtubers_2024
)


-- 3.
SELECT
    channel_name,
    avg_views_per_video,
    (avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM
    ChannelData


-- 4.
WHERE
    channel_name IN ('Mister Max', 'DanTDM', 'Dan Rhodes')


-- 5.
ORDER BY
    net_profit DESC;

```

#### Output

![Most views](assets/images/youtubers_with_the_most_views.png)



## Discovery

- What did we learn?

We discovered that 


1. NoCopyrightSOunds, Dan Rhodes and DanTDM are the channnels with the most subscribers in the UK
2. GRM Daily, Man City and Yogscast are the channels with the most videos uploaded
3. DanTDM, Dan RHodes and Mister Max are the channels with the most views
4. Entertainment channels are useful for broader reach, as the channels posting consistently on their platforms and generating the most engagement are focus on entertainment and music 




## Recommendations 

- What do you recommend based on the insights gathered? 
  
1. Dan Rhodes is the best YouTube channel to collaborate with if we want to maximize visbility because this channel has the most YouTube subscribers in the UK
2. Although GRM Daily, Man City and Yogcasts are regular publishers on YouTube, it may be worth considering whether collaborating with them with the current budget caps are worth the effort, as the potential return on investments is significantly lower compared to the other channels.
3. Mister Max is the best YouTuber to collaborate with if we're interested in maximizing reach, but collaborating with DanTDM and Dan Rhodes may be better long-term options considering the fact that they both have large subscriber bases and are averaging significantly high number of views.
4. The top 3 channels to form collaborations with are NoCopyrightSounds, DanTDM and Dan Rhodes based on this analysis, because they attract the most engagement on their channels consistently.


### Potential ROI 
- What ROI do we expect if we take this course of action?

1. Setting up a collaboration deal with Dan Rhodes would make the client a net profit of $1,065,000 per video
2. An influencer marketing contract with Mister Max can see the client generate a net profit of $1,276,000
3. If we go with a product placement campaign with DanTDM, this could  generate the client approximately $484,000 per video. If we advance with an influencer marketing campaign deal instead, this would make the client a one-off net profit of $404,000.
4. NoCopyrightSounds could profit the client $642,000 per video too (which is worth considering) 




### Action plan
- What course of action should we take and why?

Based on our analysis, we beieve the best channel to advance a long-term partnership deal with to promote the client's products is the Dan Rhodes channel. 

We'll have conversations with the marketing client to forecast what they also expect from this collaboration. Once we observe we're hitting the expected milestones, we'll advance with potential partnerships with DanTDM, Mister Max and NoCopyrightSounds channels in the future.   

- What steps do we take to implement the recommended decisions effectively?


1. Reach out to the teams behind each of these channels, starting with Dan Rhodes
2. Negotiate contracts within the budgets allocated to each marketing campaign
3. Kick off the campaigns and track each of their performances against the KPIs
4. Review how the campaigns have gone, gather insights and optimize based on feedback from converted customers and each channel's audiences 
