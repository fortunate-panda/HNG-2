# Troubleshooting and Fixes - Stage 2 DevOps

## 1. Environment Configuration
**Issue:** The `.env` file was found to be empty (0 bytes), and the `API_URL` was hardcoded to `localhost:8000`.
**Fix:** (Planned) Transition the hardcoded `API_URL` in `frontend/app.js` to use `process.env.API_URL` to allow for seamless Docker container communication.


## 2. Multi-Language Service Identification
**Issue:** The `api` service was initially mistaken for a Node.js service due to the monorepo structure.
**Fix:** Identified the backend as a **Python FastAPI** application. 
- Requirement: Needs a Python virtual environment and `pip install fastapi redis uvicorn`.
- Connection: Confirmed the API uses **Redis** for job queueing (Line 8), which means a Redis container/instance is required for the stack to function.
-

## 3. Worker Service and Redis Integration
**Issue:** Identified a background `worker` service that processes jobs asynchronously via Redis.
**Fix:** - Stack: Python (Redis client).
- Logic: The worker uses `brpop` to listen for jobs on the "job" queue.
- Infrastructure Requirement: Both the `api` and `worker` must point to the same Redis instance.
- Correction: Updated (or planned to update) `host="localhost"` to `host="redis"` across `worker.py` and `main.py` for Docker container networking.
-


