from confluent_kafka import Consumer
#from config import config

conf = {
"bootstrap.servers":"localhost:9092",
"group.id":'1',
'auto.offset.reset':'earliest'
}

consumer = Consumer(conf)
consumer.subscribe('Delivery')

running = True

while running:
    msg = consumer.poll(1)
    if msg is None: continue
    else:
        print(msg.value())
