from azure.eventhub import EventHubProducerClient, EventData
import pandas as pd
import json
import time

# ==========================================
# Event Hub Connection String
# ==========================================

CONNECTION_STRING = (
    "Endpoint=sb://socialmedia-eventhub.servicebus.windows.net/;"
    "SharedAccessKeyName=RootManageSharedAccessKey;"
    "SharedAccessKey=nCxt6nE1qV3pyZHbmFFh7BZBScVdLQSaP+AEhOq4lB0=;"
    "EntityPath=valid-tweets-hub"
)

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STRING
)

# ==========================================
# Read CSV
# ==========================================

df = pd.read_csv("../bronze_valid_tweets_raw.csv")

print("Starting Valid Tweets Producer...")

# ==========================================
# Send Events
# ==========================================

for _, row in df.iterrows():

    event = {
        "tweet_id": row["tweet_id"],
        "topic_category": row["topic_category"],
        "tweet_text": row["tweet_text"],
        "tweet_timestamp": row["tweet_timestamp"],
        "impressions": row["impressions"],
        "likes": row["likes"],
        "retweets": row["retweets"],
        "replies": row["replies"],
        "engagement_count": row["engagement_count"],
        "sentiment_score": row["sentiment_score"]
    }

    event_json = json.dumps(event, default=str)

    batch = producer.create_batch()
    batch.add(EventData(event_json))

    producer.send_batch(batch)

    print(event_json)

    time.sleep(0.0001)

producer.close()

print("All Valid Tweets records sent successfully.")