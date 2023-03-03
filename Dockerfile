FROM jupyter/pyspark-notebook

USER root
COPY requirements.txt .
COPY notebooks/example.ipynb .
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt
RUN $SPARK_HOME/bin/pyspark --packages io.delta:delta-core_2.12:1.0.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
USER $NB_UID