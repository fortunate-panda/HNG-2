#!/bin/bash

# Give services time to boot
sleep 10 

TIMEOUT=60
ELAPSED=0

# Create a job (Adjust the payload if your API expects something different)
JOB_ID=$(curl -s -X POST http://localhost:8000/jobs -H "Content-Type: application/json" -d '{"task": "integration-test"}' | jq -r .id)

if [ "$JOB_ID" == "null" ] || [ -z "$JOB_ID" ]; then
  echo "Failed to create job."
  exit 1
fi

while [ $ELAPSED -lt $TIMEOUT ]; do
  STATUS=$(curl -s http://localhost:8000/jobs/$JOB_ID | jq -r .status)
  
  if [ "$STATUS" == "completed" ]; then
    echo "Integration test passed!"
    exit 0
  fi
  
  sleep 5
  ELAPSED=$((ELAPSED+5))
done

echo "Integration test failed: Timeout reached."
exit 1