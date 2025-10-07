import os, sys
os.environ["PYSPARK_PYTHON"] = sys.executable
os.environ["PYSPARK_DRIVER_PYTHON"] = sys.executable
from pyspark.sql import SparkSession

# Crear la sesión de Spark
spark = SparkSession.builder.appName("HelloSpark").getOrCreate()

# Dataset de prueba
data = [("Juan", 23), ("Ana", 31), ("Luis", 45)]
df = spark.createDataFrame(data, ["nombre", "edad"])

# Mostrar el DataFrame
df.show()

# Contar filas
print("Cantidad de filas:", df.count())

spark.stop()