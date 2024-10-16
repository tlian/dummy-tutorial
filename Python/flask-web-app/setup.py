from setuptools import setup
setup(
    name="flask-web-app",
    version="1.0.0",
    description="A simple/dummy flask web application",
    author="Thawngzapum Lian",
    author_email="tzplian@gmail.com",
    packages=["website"],
    install_requires=[
        "sqlalchemy",
        "flask"
    ],
)