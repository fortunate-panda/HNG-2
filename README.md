# hng14-stage2-devops
# Job Processing Microservices Stack

[![CI/CD Pipeline]]
This repository contains a containerized job processing microservices application. It features a fully automated CI/CD pipeline ensuring code quality, security, and zero-downtime deployments.

##  Architecture Overview

The system consists of four main components communicating over an isolated internal Docker network:

1. **Frontend (Node.js):** A web interface for users to submit and track jobs.
2. **API (FastAPI/Python):** The core backend that receives requests and queues jobs.
3. **Worker (Python):** A background processor that consumes jobs from the queue and updates their status.
4. **Redis:** The message broker and queue connecting the API and Worker.

---

##  Prerequisites

To run this stack on a clean machine, you only need the following installed:

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/get-docker/)
* [Docker Compose](https://docs.docker.com/compose/install/) (Included with Docker Desktop)

*Note: You do not need Node.js or Python installed locally. Everything runs inside isolated containers.*

---

## Getting Started (Local Deployment)

Follow these steps to bring the entire stack up from scratch.

### 1. Clone the Repository
```bash
git clone [https://github.com/chukwukelu2023/hng14-stage2-devops.git](https://github.com/chukwukelu2023/hng14-stage2-devops.git)
cd hng14-stage2-devops


cp .env.example .env



docker compose up -d --build

To ensure all services have started correctly and passed their health checks, run:

docker compose ps