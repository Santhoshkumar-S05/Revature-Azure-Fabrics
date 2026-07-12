from azure.eventhub import EventHubProducerClient, EventData
import pandas as pd
import json

CONNECTION_STRING = "Endpoint=sb://socialmedia-eventhub.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=nCxt6nE1qV3pyZHbmFFh7BZBScVdLQSaP+AEhOq4lB0="

EVENT_HUB_NAME = "trends-hub"

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STRING,
    eventhub_name=EVENT_HUB_NAME
)

df = pd.read_csv("../bronze_trends_raw.csv")

print(f"Total Records : {len(df)}")

for index, row in df.iterrows():

    event = row.to_dict()

    batch = producer.create_batch()

    batch.add(
        EventData(json.dumps(event, default=str))
    )

    producer.send_batch(batch)

    print(f"Sent Record {index+1}")

producer.close()

print("Data Sent Successfully")