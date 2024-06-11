FROM apache/zeppelin:0.11.1

USER root

RUN curl -O https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz && \
    tar -xvf spark-3.5.1-bin-hadoop3.tgz && \
    mv spark-3.5.1-bin-hadoop3 /opt/spark && \
    rm spark-3.5.1-bin-hadoop3.tgz

RUN find . -type f -name '._*' -delete
RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.11 python3.11-distutils
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
RUN update-alternatives  --set python3 /usr/bin/python3.11
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
RUN pip3.11 install --upgrade pip
RUN pip3.11 install jupyter-client==8.6.1 grpcio==1.64.0 protobuf==5.26.1

RUN rm -rf /opt/zeppelin/lib/nimbus*.jar
COPY lib/* /opt/zeppelin/lib/

