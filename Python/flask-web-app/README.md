
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
rye set 3 
# Install Flask
rye add flask
```

## Running The App

```bash
python main.py
```

## Viewing The App

Go to `http://127.0.0.1:5000`
