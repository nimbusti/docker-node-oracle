# INSTALL UBUNTU
FROM node:4.2

#INSTALL LIBAIO1 & UNZIP (NEEDED FOR STRONG-ORACLE)
RUN apt-get update \
  && apt-get install -y libaio1 \
  && apt-get install -y build-essential \
  && apt-get install -y unzip \
  && apt-get install -y curl

#ADD ORACLE INSTANT CLIENT
RUN mkdir -p opt/oracle
ADD https://s3-sa-east-1.amazonaws.com/nimbusti/public/oracle/linux/evn-vars-linux.sh .
ADD https://s3-sa-east-1.amazonaws.com/nimbusti/public/oracle/linux/instantclient-basic-linux.x64-12.1.0.2.0.zip .
ADD https://s3-sa-east-1.amazonaws.com/nimbusti/public/oracle/linux/instantclient-sdk-linux.x64-12.1.0.2.0.zip .
RUN unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle
RUN unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle
RUN mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient
RUN ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
RUN ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig

# Create app directory
RUN mkdir -p /app/user
WORKDIR /app/user

# Install app dependencies
COPY package.json /app/user
RUN npm install

# Bundle app source
COPY . /app/user

EXPOSE 80

CMD [ "npm", "start" ]
