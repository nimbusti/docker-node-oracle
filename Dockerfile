#
# Node.js w/ Bower & Grunt Dockerfile
#
# https://github.com/dockerfile/nodejs-bower-grunt
#
# Pull base image.

FROM node:4.2.1

# Install Bower & Grunt
RUN npm install -g bower grunt-cli sails mocha gcc make build-essential
RUN apt-get update -yq
RUN apt-get install -y ruby-dev

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]