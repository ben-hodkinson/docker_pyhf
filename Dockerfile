FROM atlas/analysisbase:latest

USER root
WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

ENV PYTHON_VERSION "3.8.5"

RUN yum -y update \
    && yum install -y python3 \ 
    && yum clean all

# RUN curl -SLO https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
#     && tar xvf Python-${PYTHON_VERSION}.tgz \
#     && cd Python-${PYTHON_VERSION} \
#     && ./configure --enable-optimizations \
#     && make \
#     && make altinstall \
#     && cd / \
#     && rm -rf Python-${PYTHON_VERSION}*

ENV PATH "/usr/local/bin:${PATH}"

COPY requirements.txt ./

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=en_US.utf-8
ENV LANG=en_US.utf-8

# Create user "atlas" with sudo powers
# RUN useradd -m atlas && \
#     usermod -aG sudo atlas && \
#     echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
#     cp /root/.bashrc /home/atlas/ && \
#     mkdir /home/atlas/data && \
#     chown -R --from=root atlas /home/atlas

# WORKDIR /home/atlas/data
# ENV HOME /home/atlas
# ENV USER atlas
USER atlas
ENV PATH /home/atlas/.local/bin:$PATH
# # Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
# RUN touch $HOME/.sudo_as_admin_successful

CMD [ "/bin/bash" ]