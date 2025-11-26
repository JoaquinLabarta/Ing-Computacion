'''El dataset EstacionesMeteorológicas posee información sobre registros de datos  climaticos tomados  por  sus  estaciones.  
Este  dataset  tiene  tuplas  con  la  siguiente información: <ID_Estación, fecha_registro, temperatura, humedad, precipitación> 
Y además está conformado por dos archivos: 
    a. estacionNorte.txt  almacena  la  información  en  grados  centígrados,  porcentaje 
    de humedad, y milímetros de lluvia. 
    b. estacionSur.txt  almacena  la  información  en  grados  fahrenheit,  porcentaje  de 
    humedad y centímetros de lluvia. 
    Implemente una solución en Spark que permita obtener: 
        • el promedio de temperatura, de humedad y precipitación total entre todas las 
        estaciones.  
        • el ID de la estación y la fecha que registró 
        o la temperatura más fría  
        o la temperatura más calurosa 
        o la de mayor humedad 
        o la de menor humedad 
        o la de más precipitación 
        o la de menor precipitación 
NOTA: En caso de dos estaciones con igual máximo o mínimo, devolver cualquiera de  las dos.'''

from re import split
import os, sys
os.environ["PYSPARK_PYTHON"] = sys.executable
os.environ["PYSPARK_DRIVER_PYTHON"] = sys.executable

from pyspark import SparkContext

sc = SparkContext("local[*]", "Estacion-Meteorologica")
path_norte = "EstacionesMeteorologicas/Norte*.txt"
path_sur = "EstacionesMeteorologicas/Sur*.txt"

rddNorte = sc.textFile(path_norte) 
rddSur = sc.textFile(path_sur)

print(rddNorte.count())
print(rddSur.count())