# sqlalchemy-python

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
rye add sqlalchemy
```

## Running The App

```bash
python main.py
```

mydb.db will be generated and the table can be explored using VSCode. Recommended to install "SQLite extension" in VSCode to view the DB table.  
