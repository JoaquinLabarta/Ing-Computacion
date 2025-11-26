from pyspark import SparkContext
from pyspark.sql import SQLContext, Row

sc = SparkContext("local[*]", "TP2-punto1")
sqlContext = SQLContext(sc)

base = r"C:\Users\maxim\OneDrive\Desktop\2do cuatri\big data\INPUT\dataset"
combates = sc.textFile(base + r"\jugadores.txt") \
        .map(lambda line: line.strip().split()) \
        .map(lambda t:
             Row(id_retador = int(t[0]),
                 id_retado  = int(t[1])))

combatesDF = sqlContext.createDataFrame(combates)
combatesDF.registerTempTable("Combates")

#------------------------------------------------------------------------------------------------------

mas_retador = sqlContext.sql("""
    SELECT id_retador, COUNT(*) AS cantidad
    FROM Combates
    GROUP BY id_retador
    ORDER BY cantidad DESC
    LIMIT 1
    """)
print("Jugador más retador:")
mas_retador.show()


mas_retado = sqlContext.sql("""
    SELECT id_retado, COUNT(*)  AS cantidad
    FROM Combates
    GROUP BY id_retado
    ORDER BY cantidad DESC
    LIMIT 1
""")

print("Jugador más retado:")
mas_retado.show()

#------------------------------------------------------------------------------------------------------

