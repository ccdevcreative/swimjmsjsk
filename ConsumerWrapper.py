import subprocess

class ConsumerWrapper:
    def __init__(self, args):
        self.args = args
            
    def run(args):
        command = ['cmd', '/c', 'path\\to\\consumer.bat']

        if args.property_file:
            command.extend(['-pf', args.property_file])
        if args.consumer_number:
            command.extend(['-c', str(args.consumer_number)])
        if args.processor_number:
            command.extend(['-pn', str(args.processor_number)])
        if args.no_console:
            command.append('-nc')
        if args.data:
            command.extend(['-d', args.data])
        if args.schema_file:
            command.extend(['-sf', args.schema_file])
        if args.latency:
            command.append('-l')

        subprocess.run(command)
