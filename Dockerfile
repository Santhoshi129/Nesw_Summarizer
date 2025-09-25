FROM python:3.9-slim

WORKDIR /app

# Install system dependencies (including netcat for health checks)
RUN apt-get update && apt-get install -y netcat && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download NLTK data
RUN python -c "import nltk; nltk.download('punkt'); nltk.download('stopwords'); nltk.download('vader_lexicon')"

# Copy application code
COPY . .

# Make startup script executable
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8000 8501

CMD ["./start.sh"]