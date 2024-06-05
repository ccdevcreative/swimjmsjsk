import subprocess

class ProducerWrapper:
    def __init__(self, args):
        self.args = args

    def run(self):
        command = ['cmd', '/c', 'path\\to\\producer.bat']

        if self.args.property_file:
            command.extend(['-pf', self.args.property_file])
        if self.args.message_rate:
            command.extend(['-mr', str(self.args.message_rate)])
        if self.args.message_number:
            command.extend(['-mn', str(self.args.message_number)])
        if self.args.message:
            command.extend(['-m', self.args.message])
        if self.args.data:
            command.extend(['-d', self.args.data])
        if self.args.delay_multiplier:
            command.extend(['-dm', str(self.args.delay_multiplier)])
        if self.args.producer_number:
            command.extend(['-pn', str(self.args.producer_number)])
        if self.args.latency:
            command.append('-l')
        if self.args.ttl:
            command.extend(['-ttl', str(self.args.ttl)])
        if self.args.priority:
            command.extend(['-pr', str(self.args.priority)])

        subprocess.run(command)