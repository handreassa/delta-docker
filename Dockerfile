FROM jupyter/pyspark-notebook

USER root
COPY requirements.txt .
# COPY notebooks/example.ipynb .
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG NB_GID=100

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN groupadd -f ${USER} && \
    chown -R ${USER}:${USER} ${HOME}

USER ${NB_USER}

RUN export PACKAGES="io.delta:delta-core_2.12:1.0.0"
RUN export PYSPARK_SUBMIT_ARGS="--packages ${PACKAGES} pyspark-shell"