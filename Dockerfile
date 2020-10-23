FROM centos/python-38-centos7

USER root
WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Create user "atlas" with sudo powers
RUN useradd -m atlas && \
    # usermod -aG sudo atlas && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/atlas/ && \
    mkdir /home/atlas/data && \
    chown -R --from=root atlas /home/atlas

WORKDIR /home/atlas/data
ENV HOME /home/atlas
ENV USER atlas
USER atlas
ENV PATH /home/atlas/.local/bin:$PATH
# Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
RUN touch $HOME/.sudo_as_admin_successful

CMD [ "/bin/bash" ]