import redis
import time
import os
import signal

# This looks for an environment variable named REDIS_HOST. 
# If it doesn't find one, it defaults to "localhost".
redis_host = os.getenv("REDIS_URL", "redis")
r = redis.Redis(host=redis_host, port=6379)

def process_job(job_id):
    print(f"Processing job {job_id}")
    time.sleep(2)  # simulate work
    r.hset(f"job:{job_id}", "status", "completed")
    print(f"Done: {job_id}")

while True:
    job = r.brpop("job", timeout=5)
    if job:
        _, job_id = job
        process_job(job_id.decode())