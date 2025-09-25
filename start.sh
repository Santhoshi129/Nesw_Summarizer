#!/bin/bash

# Start FastAPI backend
uvicorn api:app --host 0.0.0.0 --port 8000 &

# Wait for FastAPI to become available
echo "Waiting for FastAPI to start..."
while ! nc -z localhost 8000; do
  sleep 1
done

# Start Streamlit frontend
echo "Starting Streamlit..."
streamlit run app.py --server.port 8501 --server.address 0.0.0.0