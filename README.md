# Docker - Working with delta tables inside Jupyter notebooks

This Docker Compose file sets up a Spark master node and a Jupyter Notebook server. The Spark master node is based on the bitnami/spark Docker image, and the Jupyter Notebook server is built from the current directory (.) using the Dockerfile included in the directory. All changes made in both volumes will be stored in the folders from the host.

## Requirements

- Docker and Docker Compose installed on your local machine.

### Setup

- Clone this repository to your local machine.
- Open a terminal window and navigate to the directory where you cloned the repository.
- Run the following command to start the Spark and Jupyter containers:

```sh
docker-compose up --build
```

- Wait for the containers to start. Once they are running, you should be able to access the Jupyter Notebook server at http://localhost:8888. The token and password are empty, as specified in the command section of the jupyter service.

- Inside jupyter notebook, use the following command to create the spark session:
```python
import pyspark
from delta import *

builder = pyspark.sql.SparkSession.builder.appName("LocalDelta") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")

spark = configure_spark_with_delta_pip(builder).getOrCreate()
```

## Example
There is an example notebook (example.ipynb) to get you started.
