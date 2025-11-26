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

#------------------------------------------------------------------------------------------------------

#lista de todos los juguadores
todos_jugadores = sqlContext.sql("""
    SELECT id_retador AS id FROM Combates
    UNION
    SELECT id_retado AS id FROM Combates
""")
todos_jugadores.registerTempTable("Jugadores")

#------------------------------------------------------------------------------------------------------

#suma de puntos totales y cantidad de combates para cada retador
stats_retador = sqlContext.sql("""
    SELECT id_retador, SUM(puntos) AS suma_puntos, COUNT(*) AS cant_combates
    FROM Combates
    GROUP BY id_retador
""")
stats_retador.registerTempTable("StatsRetador")

#------------------------------------------------------------------------------------------------------

#PP para cada jugador
pp = sqlContext.sql("""
    SELECT j.id AS jugador, (COALESCE(s.suma_puntos, 0) + 1) / (COALESCE(s.cant_combates, 0) + 1) AS PP
    FROM Jugadores j
    LEFT JOIN StatsRetador s ON (j.id = s.id_retador)
""")
#se usa colease por si es null

pp.registerTempTable("PPJugadores")

#------------------------------------------------------------------------------------------------------

#jugador con mas PP
mejor_pp = sqlContext.sql("""
    SELECT jugador, PP
    FROM PPJugadores
    ORDER BY PP DESC
    LIMIT 1
""")

print("Jugador con mejor PP:")
mejor_pp.show()

#------------------------------------------------------------------------------------------------------