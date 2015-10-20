#
# Node.js w/ Bower & Grunt Dockerfile
#
# https://github.com/dockerfile/nodejs-bower-grunt
#
# Pull base image.

FROM node:4.2.1

# Install Bower & Grunt
RUN npm install -g bower grunt-cli sails mocha
RUN apt-get update -yq
RUN apt-get install -y ruby-dev gcc make build-essential

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]