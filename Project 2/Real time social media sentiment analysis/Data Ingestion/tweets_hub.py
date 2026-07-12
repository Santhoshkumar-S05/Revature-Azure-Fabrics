from azure.eventhub import EventHubProducerClient, EventData
import pandas as pd
import json

# ==========================================
# Event Hub Connection String
# ==========================================

CONNECTION_STRING = (
    "Endpoint=sb://socialmedia-eventhub.servicebus.windows.net/;"
    "SharedAccessKeyName=RootManageSharedAccessKey;"
    "SharedAccessKey=nCxt6nE1qV3pyZHbmFFh7BZBScVdLQSaP+AEhOq4lB0=;"
    "EntityPath=tweets-hub"
)

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STRING
)

# ==========================================
# Read CSV
# ==========================================

df = pd.read_csv(r"C:\Revature\Final project\REAL TIME SOCIAL MEDIA\bronze_tweets_raw.csv")

print("Starting Tweets Producer...")

# ==========================================
# Create Batch
# ==========================================

batch = producer.create_batch()

record_count = 0

# ==========================================
# Send Events
# ==========================================

for _, row in df.iterrows():

    event = {
        "tweet_id": row["tweet_id"],
        "user_id": row["user_id"],
        "tweet_text": row["tweet_text"],
        "timestamp": row["timestamp"],
        "timestamp_1": row["timestamp.1"],
        "likes": row["likes"],
        "retweets": row["retweets"],
        "replies": row["replies"],
        "impressions": row["impressions"],
        "engagement": row["engagement"]
    }

    event_json = json.dumps(event, default=str)

    try:
        batch.add(EventData(event_json))
        record_count += 1

    except ValueError:
        producer.send_batch(batch)
        print(f"{record_count} records sent...")

        batch = producer.create_batch()
        batch.add(EventData(event_json))
        record_count += 1

# ==========================================
# Send Remaining Records
# ==========================================

if len(batch) > 0:
    producer.send_batch(batch)

producer.close()

print(f"Successfully sent {record_count} records to Tweet Event Hub.")