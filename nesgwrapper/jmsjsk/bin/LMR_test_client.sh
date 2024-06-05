#!/bin/bash
#*******************************************************************************
# Copyright (c) 2021 L3Harris Technologies
#
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#*******************************************************************************

# Server hostname and port
SERVER=<REPLACE>
PORT=8188

# Username and password
USER=<REPLACE>
PASS=<REPLACE>

# Data type to request data for
DATA_TYPE=<DATA_TYPE>

# Date range to request data for
START_DATE=2022-09-06T18:47:00Z
END_DATE=2022-09-06T23:47:00Z

# Maximum amount of retries for a zip retrieval
MAX_ZIP_RETRIES=50


# Creates directories if they don't exist
mkdir -p ./generated_links
mkdir -p ./zips

# Starting the initial request for the list of zip links
timestamp=$(date +%Y-%m-%d-%H:%M:%SZ)

startTime=$(date +%s.%N)
echo
echo "Requesting data from http://$SERVER:$PORT/cxf/crws/int/$DATA_TYPE/request?startDate=$START_DATE&endDate=$END_DATE"

# Used to show the error message
curlLinkText=($(curl -s -u $USER:$PASS -XGET "http://$SERVER:$PORT/cxf/crws/int/$DATA_TYPE/request?startDate=$START_DATE&endDate=$END_DATE"))
echo $curlLinkText | python -m json.tool > ./generated_links/Generated_Links_$timestamp.json

stopTime=$(date +%s.%N)
responseTime=$(echo "$stopTime - $startTime" | bc -l)

results=($(grep "url" ./generated_links/Generated_Links_$timestamp.json))

numOfResults=$((${#results[@]}/2))
#The sed matches everything before and after the ':' and returns the items after it
totalMessages=$(grep 'totalNumberOfMessages' "./generated_links/Generated_Links_$timestamp.json" | sed -r 's/^[^:]*:\s(.*)$/\1/')

# If there is an error, print out the curl body
if [[ "$totalMessages" == "" ]]
then
	echo "Error when getting the generated links:"
	for linkText in ${curlLinkText[@]}
	do
		echo $linkText
	done 
	exit 1
fi

echo "Link response time: $responseTime"
echo "Total zip links received: $numOfResults"
echo "Total number of messages: $totalMessages"
echo


requestData() {
	echo "Attempting download of $2..."
	curlText=($(curl -s -o $2 -w "%{http_code} %{time_starttransfer}s" -m 300 -u $USER:$PASS -XGET $1))
	httpCode=${curlText[0]}
	retries=0

	while [[ ${httpCode} -ne 200 ]] && [[ $retries -lt $MAX_ZIP_RETRIES ]]
	do
		sleep 1
		echo "Zip failed to download: $httpCode. Retrying"
		curlText=($(curl -s -o $2 -w "%{http_code} %{time_starttransfer}s" -m 300 -u $USER:$PASS -XGET $1))
		httpCode=${curlText[0]}
		((retries++))
	done

	if [[ $retries -eq $MAX_ZIP_RETRIES ]]
	then
		echo "Max zip retrieval retries reached, exiting"
		exit 1;
	fi

	echo "Zip response time before download: ${curlText[1]}"
	echo "Finished downloading $2..."
}

zips=()

# Starting the zip retrieval requests
echo "Conducting initial download attempts..."
for result in "${results[@]}"
do
	if [[ "$result" != *"url"* ]]
	then
		zip=./zips/${result:42:$((${#result}-43))}.zip
		zips+=( $zip )
		requestData http://$SERVER:$PORT/${result:2:$((${#result}-3))} $zip
	fi
done
