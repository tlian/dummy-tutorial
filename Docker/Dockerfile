FROM ubuntu 

# Skip prompts
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade package
RUN apt update; apt dist-upgrade -y

# Install Apache
RUN apt install -y apache2 vim-nox

# Entry point
ENTRYPOINT apache2ctl -D FOREGROUND