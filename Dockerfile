
FROM pyhf/pyhf:v0.5.3
ENTRYPOINT /bin/sh

# install pyhf and dependencies
COPY requirements.txt ./
COPY fix_1Lbb_xml.py ./
USER atlas
RUN python -m pip install --upgrade pip && \
    python -m pip install --no-cache-dir -r requirements.txt

WORKDIR /home
ENV HOME /home
USER root
RUN sudo usermod -aG root atlas 
USER atlas
