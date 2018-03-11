#!/bin/bash

date

if [ -z "$AWS_BATCH_JOB_ID" ]
then
   AWS_BATCH_JOB_ID="100"
else
   echo "\$AWS_BATCH_JOB_ID is NOT empty"
fi

echo "Args: $@"
echo "jobId: $AWS_BATCH_JOB_ID"

Num=$FOO
Fib=""
f1=0
f2=1
echo "The Fibonacci sequence for $Num is:"
for (( i=0; i<=Num; i++ ))
do
   Fib+="$f1 "
   fn=$((f1+f2))
   f1=$f2
   f2=$fn
done

echo $Fib
echo "{\"jobID\": {\"S\": \"$AWS_BATCH_JOB_ID\"}, \"Fibi\": {\"S\": \"$Fib\"}}" > item.json
cat item.json
RESP=$(aws dynamodb put-item --region us-east-1 --table-name fetch_and_run --item file://item.json)
echo $RESP

sleep 1
echo "That's all folks"