from pyspark import SparkContext, StorageLevel
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


aristas = sqlContext.sql("""
    SELECT DISTINCT
        id_retador AS i,
        id_retado  AS j
    FROM Combates
""")
aristas.registerTempTable("Aristas")

PH = sqlContext.sql("""
    SELECT id AS jugador, 1.0 AS PH
    FROM Jugadores
""")
PH.registerTempTable("PH")

sqlContext.table("PPJugadores").persist(StorageLevel.MEMORY_ONLY)
sqlContext.table("PPJugadores").count()

sqlContext.table("Aristas").persist(StorageLevel.MEMORY_ONLY)
sqlContext.table("Aristas").count()

sqlContext.table("Jugadores").persist(StorageLevel.MEMORY_ONLY)
sqlContext.table("Jugadores").count()


cota = 0.01
error = 999
alpha = 0.1

iteracion = 0

while error > cota:

    iteracion += 1

    contrib = sqlContext.sql(f"""
        SELECT a.i AS jugador_i, SUM(PHj.PH * PPi.PP / PPj.PP) AS suma_contrib
        FROM Aristas a
        JOIN PH PHj ON a.j = PHj.jugador
        JOIN PPJugadores PPi ON a.i = PPi.jugador
        JOIN PPJugadores PPj ON a.j = PPj.jugador
        GROUP BY a.i
    """)
    contrib.registerTempTable("Contrib")

    PH_new = sqlContext.sql(f"""
        SELECT j.id AS jugador, CASE
                                    WHEN c.suma_contrib IS NULL THEN 1.0
                                    ELSE {alpha} * c.suma_contrib + (1.0 - {alpha})
                                END AS PH
        FROM Jugadores j
        LEFT JOIN Contrib c ON j.id = c.jugador_i
    """).persist(StorageLevel.MEMORY_ONLY)
    PH_new.count()

    PH_new.registerTempTable("PH_new")

    #calculo distancia entre PH_new y PH viejo
    dif = sqlContext.sql("""
        SELECT SUM( (PH_new.PH - PH.PH) * (PH_new.PH - PH.PH) ) AS suma
        FROM PH_new
        JOIN PH ON PH_new.jugador = PH.jugador
    """)

    #traigo al diver el error
    error = dif.collect()[0]["suma"]

    print(f"Iteración {iteracion}, error = {error}")

    #reemplazo PH = PH_new 
    PH.unpersist()
    PH = PH_new
    PH.registerTempTable("PH")

#top 10
top10 = sqlContext.sql("""
    SELECT jugador, PH
    FROM PH
    ORDER BY PH DESC
    LIMIT 10
""")

print("Top 10 por puntaje heroico:")
top10.show()
print("iteraciones: ", iteracion)