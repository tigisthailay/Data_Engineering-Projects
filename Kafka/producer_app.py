import os
from confluent_kafka import Producer

conf = {
    "bootstrap.servers":"localhost:9092"
}
producer = Producer(conf)

def acked(err, msg):
    if err is not None:
        print("Failed to deliver message: %s: %s" %(str(msg), str(err)) )
    else:
        print("Message Produced: %s" % (str(msg)))

msg = {
    'Type':'id 13',
    'Log': '23.7N',
    'Lat': '20.895',
    'txt':'my delivery message from kafka '
}

producer.produce(topic='Delivery', partition=0, value=str(msg), callback=acked)
producer.poll(1)



#kafka-topics --bootstrap-server broker:29092 --create --topic Delivery --partitions 2 --replication-factor 1
