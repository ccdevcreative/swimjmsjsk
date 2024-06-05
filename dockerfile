# Use an official Python runtime as a parent image
FROM openjdk:8-jdk-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install Python
RUN apt-get update && \
    apt-get install -y python3-pip

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run consumer_wrapper.py when the container launches
CMD ["python3", "consumer_wrapper.py"]