import subprocess
import argparse

def run_producer(args):
    command = ['cmd', '/c', 'path\\to\\producer.bat']

    if args.property_file:
        command.extend(['-pf', args.property_file])
    if args.message_rate:
        command.extend(['-mr', str(args.message_rate)])
    if args.message_number:
        command.extend(['-mn', str(args.message_number)])
    if args.message:
        command.extend(['-m', args.message])
    if args.data:
        command.extend(['-d', args.data])
    if args.delay_multiplier:
        command.extend(['-dm', str(args.delay_multiplier)])
    if args.producer_number:
        command.extend(['-pn', str(args.producer_number)])
    if args.latency:
        command.append('-l')
    if args.ttl:
        command.extend(['-ttl', str(args.ttl)])
    if args.priority:
        command.extend(['-pr', str(args.priority)])

    subprocess.run(command)

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

args = parser.parse_args()

run_producer(args)