# Stage 1: Builder
FROM python:3.10-slim AS builder
WORKDIR /app
COPY requirements.txt .

# Removed --no-deps so pip fetches all necessary sub-dependencies
RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt

# Stage 2: Runner
FROM python:3.10-slim
WORKDIR /app

# Create a non-root user and install curl for the healthcheck
RUN groupadd -r appuser && useradd -r -g appuser appuser

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy installed wheels and requirements from builder
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .

# Use the correct --no-cache-dir flag and standard --find-links method
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt

# Copy the application code and set ownership in ONE step to pass Hadolint
COPY --chown=appuser:appuser . .

# Switch to the non-root user
USER appuser

# The working Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]