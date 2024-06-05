import subprocess
import argparse

from ConsumerWrapper import ConsumerWrapper
from ProducerWrapper import ProducerWrapper

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-pf', '--property_file')
    parser.add_argument('-mr', '--message_rate', type=int)
    parser.add_argument('-mn', '--message_number', type=int)
    parser.add_argument('-m', '--message')
    parser.add_argument('-d', '--data')
    parser.add_argument('-dm', '--delay_multiplier', type=int)
    parser.add_argument('-pn', '--producer_number', type=int)
    parser.add_argument('-l', '--latency', action='store_true')
    parser.add_argument('-ttl', '--ttl', type=int)
    parser.add_argument('-pr', '--priority', type=int)


    # parser = argparse.ArgumentParser()
    # parser.add_argument('-pf', '--property_file')
    # parser.add_argument('-c', '--consumer_number', type=int)
    # parser.add_argument('-pn', '--processor_number', type=int)
    # parser.add_argument('-nc', '--no_console', action='store_true')
    # parser.add_argument('-d', '--data')
    # parser.add_argument('-sf', '--schema_file')
    # parser.add_argument('-l', '--latency', action='store_true')

    args = parser.parse_args()

    producer = ProducerWrapper(args)
    producer.run()

    # consumer = ConsumerWrapper(args)
    # consumer.run()

if __name__ == "__main__":
    main()
