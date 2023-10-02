FROM jupyter/pyspark-notebook:spark-3.4.1

USER root
COPY requirements.txt .
# COPY notebooks/example.ipynb .
RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG NB_GID=100

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN groupadd -f ${USER} && \
    chown -R ${USER}:${USER} ${HOME}

USER ${NB_USER}

RUN export PACKAGES="io.delta:delta-core_2.12:0.7.0"
RUN export PYSPARK_SUBMIT_ARGS="--packages ${PACKAGES} pyspark-shell"