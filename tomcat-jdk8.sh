#!/bin/bash

docker run -d \
  --name=tomcat8 \
  --restart=always \
  -p 8080:8080 \
  tomcat:8.5-jdk8
