# Stage 1: Builder
FROM python:3.10-slim AS builder
WORKDIR /app
COPY requirements.txt .

# Fetch all dependencies and compile them to wheels
RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt

# Stage 2: Runner
FROM python:3.10-slim
WORKDIR /app

# Create a non-root user. 
# We install 'procps' here so we have access to the 'ps' command for our healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*t/lists/*

# Copy installed wheels and requirements from builder
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .

# Install from wheels securely
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt

# Copy the application code and set ownership in ONE step to pass Hadolint
COPY --chown=appuser:appuser . .

# Switch to the non-root user
USER appuser

# The Worker Healthcheck: 
# Checks if a python process is actively running. If the worker crashes, this fails.
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD ps aux | grep "[p]ython" || exit 1

# Note: The '-u' flag forces stdout to be unbuffered so logs show up immediately in Docker
CMD ["python", "-u", "worker.py"]