#!/bin/bash
# integration.sh
TIMEOUT=60
ELAPSED=0

JOB_ID=$(curl -s -X POST http://localhost:8000/jobs -H "Content-Type: application/json" -d '{"task": "test"}' | jq -r .id)

while [ $ELAPSED -lt $TIMEOUT ]; do
    STATUS=$(curl -s http://localhost:8000/jobs/$JOB_ID | jq -r .status)
    if [ "$STATUS" == "completed" ]; then
        echo "Success"
        exit 0
    fi
    sleep 5
    ELAPSED=$((ELAPSED+5))
done

echo "Timeout reached!"
exit 1