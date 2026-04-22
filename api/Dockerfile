# Stage 1: Builder
FROM python:3.10-slim AS builder
WORKDIR /app
COPY requirements.txt .
# Build wheels instead of installing directly to keep the final image clean
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# Stage 2: Runner
FROM python:3.10-slim
WORKDIR /app

# Create a non-root user
RUN useradd -m appuser && apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy installed wheels from builder and install them
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache /wheels/*

# Copy the actual application code
COPY . .

# Set permissions and switch user
RUN chown -R appuser:appuser /app
USER appuser

# The working Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]