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
    "EntityPath=user-metadata-hub"
)

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STRING
)

# ==========================================
# Read CSV
# ==========================================

df = pd.read_csv("../bronze_user_metadata_raw.csv")

print("Starting User Metadata Producer...")

# ==========================================
# Send Events
# ==========================================

for _, row in df.iterrows():

    event = {
        "user_id": row["user_id"],
        "country": row["country"],
        "topic_category": row["topic_category"],
        "account_created_date": row["account_created_date"],
        "followers_count": row["followers_count"],
        "following_count": row["following_count"],
        "likes_count": row["likes_count"],
        "shares_count": row["shares_count"],
        "posts_count": row["posts_count"],
        "verified": row["verified"]
    }

    event_json = json.dumps(event, default=str)

    batch = producer.create_batch()
    batch.add(EventData(event_json))

    producer.send_batch(batch)

    print(event_json)

    time.sleep(0.0001)

producer.close()

print("All User Metadata records sent successfully.")