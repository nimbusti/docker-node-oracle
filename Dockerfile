#
# Node.js w/ Bower & Grunt Dockerfile
#
# https://github.com/dockerfile/nodejs-bower-grunt
#
# Pull base image.

FROM node:4.2.1

# Install Bower & Grunt
RUN npm install -g bower grunt-cli sails

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]