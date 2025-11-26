from pyspark import SparkContext
sc = SparkContext("local[*]", "TP2")

base = r"C:\Users\maxim\OneDrive\Desktop\2do cuatri\big data\INPUT\dataset"
combates = sc.textFile(base + r"\jugadores.txt") \
        .map(lambda line: line.strip().split()) \
        .map(lambda t:
             (t[0], t[1]))

#------------------------------------------------------------------------------------------------------

retadores = combates.map(lambda t: (t[0], 1)) \
               .reduceByKey(lambda v1, v2: v1 + v2)


mas_retador = retadores.reduce(lambda t1, t2:
                                t1 if t1[1] > t2[1] else t2)

print("el jugador más retador:", mas_retador[0], "con", mas_retador[1], "combates")

#------------------------------------------------------------------------------------------------------

retados = combates.map(lambda x: (x[1], 1)) \
             .reduceByKey(lambda v1, v2: v1 + v2)

mas_retado = retados.reduce(lambda t1, t2:
                            t1 if t1[1] > t2[1] else t2)

print("el jugador más retador:", mas_retado[0], "con", mas_retado[1], "veces retado")

#------------------------------------------------------------------------------------------------------

#el enunciado puede resolverse de diversas maneras con una eficiencia similar, como con DF, spark SQL o con Windows