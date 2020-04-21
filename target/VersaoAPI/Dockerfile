# Auto Generated Dockerfile

FROM wso2/wso2micro-gw:3.0.2
LABEL maintainer="dev@ballerina.io"

COPY VersaoAPI.balx /home/ballerina 

COPY micro-gw.conf /home/ballerina/conf/micro-gw.conf

CMD ballerina run  --config /home/ballerina/conf/micro-gw.conf VersaoAPI.balx
