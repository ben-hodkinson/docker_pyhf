FROM atlas/analysisbase:latest

USER root
WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

# might want to specify python version at some point. Using default python3 (python 3.6) for now
#ENV PYTHON_VERSION "3.8.5"

# install python3.6 and clean to reduce image size
RUN yum -y update \
    && yum install -y python3 \ 
    && yum clean all

# install pyhf and dependencies
COPY requirements.txt ./
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# Use en_US.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=en_US.utf-8
ENV LANG=en_US.utf-8

USER atlas
WORKDIR /home/atlas
ENV HOME /home/atlas

CMD [ "/bin/bash" ]