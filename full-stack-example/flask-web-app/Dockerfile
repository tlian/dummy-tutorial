# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /flask-web-app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code into the container
COPY . .

# Expose the port on which your app runs
EXPOSE 5000

# Set environment variable
ENV FLASK_APP=main.py

# Define the command to run your app
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
