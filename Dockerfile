# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app/

# Collect static files
RUN python /app/ubs_smu_mou_demo/manage.py collectstatic --noinput

# Expose port 8000 for the Django app
EXPOSE 8000

# Command to run the Django development server
CMD ["python", "/app/ubs_smu_mou_demo/manage.py", "runserver", "0.0.0.0:8000"]
