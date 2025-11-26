from pyspark import SparkContext
from pyspark.sql import SQLContext, Row

sc = SparkContext("local[*]", "TP2-punto1")
sqlContext = SQLContext(sc)

base = r"C:\Users\maxim\OneDrive\Desktop\2do cuatri\big data\INPUT\dataset"
combates = sc.textFile(base + r"\jugadores.txt") \
        .map(lambda line: line.strip().split()) \
        .map(lambda t:
             Row(id_retador = int(t[0]),
                 id_retado  = int(t[1]),
                 puntos = int(t[2])))

combatesDF = sqlContext.createDataFrame(combates)
combatesDF.registerTempTable("Combates")

H = 10

jugadores_mas_H = sqlContext.sql(f"""
    SELECT id_retador AS jugador, COUNT(DISTINCT id_retado) AS cant_oponentes_distintos
    FROM Combates
    GROUP BY id_retador
    HAVING COUNT(DISTINCT id_retado) > {H}
""")

print(f"Jugadores que retaron a más de {H} oponentes distintos:")
jugadores_mas_H.show()
