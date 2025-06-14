import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

# Load environment variables
load_dotenv()

# Get API key from environment variables or use directly if testing
# For production, use: API_KEY = os.getenv("YOUTUBE_API_KEY")
API_KEY = "?"  # Replace with your actual API key
API_VERSION = 'v3'

youtube = build('youtube', API_VERSION, developerKey=API_KEY)

def get_channel_stats(youtube, channel_id):
    """Get channel statistics using channel ID"""
    try:
        request = youtube.channels().list(
            part='snippet,statistics',
            id=channel_id
        )
        response = request.execute()

        if response['items']:
            data = dict(
                channel_name=response['items'][0]['snippet']['title'],
                total_subscribers=response['items'][0]['statistics']['subscriberCount'],
                total_views=response['items'][0]['statistics']['viewCount'],
                total_videos=response['items'][0]['statistics']['videoCount'],
            )
            return data
        else:
            print(f"No data found for channel ID: {channel_id}")
            return None
    except Exception as e:
        print(f"Error fetching data for channel ID {channel_id}: {str(e)}")
        return None

def get_channel_id_from_username(youtube, username):
    """Get channel ID from username or handle"""
    try:
        # Try to get channel by username
        request = youtube.channels().list(
            part="id",
            forUsername=username
        )
        response = request.execute()
        
        if response.get('items'):
            return response['items'][0]['id']
        
        # If not found by username, try search
        request = youtube.search().list(
            part="snippet",
            q=username,
            type="channel",
            maxResults=1
        )
        response = request.execute()
        
        if response.get('items'):
            return response['items'][0]['snippet']['channelId']
        
        print(f"Could not find channel ID for: {username}")
        return None
    except Exception as e:
        print(f"Error finding channel ID for {username}: {str(e)}")
        return None

# Read CSV into dataframe
df = pd.read_csv("C:\\Users\\user\\Desktop\\Top 100 Influencers\\canada\\youtube_data_canada.csv")

# Initialize a list to keep track of channel stats
channel_stats = []

# Process each row in the dataframe
for index, row in df.iterrows():
    channel_name = row['NAME']
    
    # Extract username from channel name if it contains @
    if '@' in channel_name:
        username = channel_name.split('@')[-1].strip()
    else:
        username = channel_name
    
    # Get channel ID from username
    channel_id = get_channel_id_from_username(youtube, username)
    
    if channel_id:
        # Get channel stats using the ID
        stats = get_channel_stats(youtube, channel_id)
        if stats:
            # Add the original row index to match with original dataframe
            stats['original_index'] = index
            channel_stats.append(stats)
            print(f"Successfully retrieved stats for {channel_name}")
        else:
            print(f"Could not get stats for {channel_name}")
    else:
        print(f"Could not find channel ID for {channel_name}")

# Convert the list of stats to a dataframe
if channel_stats:
    stats_df = pd.DataFrame(channel_stats)
    
    # Merge the original dataframe with the stats dataframe
    # Use the original_index to ensure correct matching
    stats_df.set_index('original_index', inplace=True)
    
    # Create a copy of the original dataframe
    result_df = df.copy()
    
    # Add the new columns from stats_df
    for col in stats_df.columns:
        result_df[col] = stats_df[col]
    
    # Save the merged dataframe back into a CSV file
    result_df.to_csv('updated_youtube_data_canada.csv', index=False)
    
    print(f"Successfully updated data for {len(channel_stats)} channels")
    print("Data saved to 'updated_youtube_data_canada.csv'")
    
    # Display the first 10 rows
    print(result_df.head(10))
else:
    print("No channel stats were retrieved. Check the error messages above.")