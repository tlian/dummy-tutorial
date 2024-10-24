
[!NOTE]
This tutorial was not developed by me except for a few changes such as 
- SHA256 was no longer supported and had to make some changes
- Used [Rye](https://rye.astral.sh/) instead of Python [venv](https://docs.python.org/3/library/venv.html)

The full tutorial can be found at 
https://www.youtube.com/watch?v=dam0GPOAvVI

This excellent tutorial was made by "Tech with Tim" 

# Flask Web App Tutorial

## Setup & Installation

[Use Rye for Python](https://mac.install.guide/python/use-rye)


```bash
git clone <repo-url>
```

```bash
# set environment to Python 3.X
rye pin 3

# Inititate rye project
rye init
rye fetch

# Install Flask
rye add flask
```

## Running The App

```bash
python main.py
```

## Viewing The App

Go to `http://127.0.0.1:5000`


## Run the application in Docker Container 


```bash 
# Build Docker image
--format--> docker build -t [whatever-application-name] [path-to-application]
docker build -t flask-web-app .

# List Docker images 
docker image list

# Run Docker container 
docker run -d -p 8000:5000 flask-web-app

# List Docker Containers 
docker ps

# Connect/Attach to Docker container
docker exec -it <container-id> sh

# Access the application from the host
http://0.0.0.0:8000