'''Usando  el  dataset Banco, escriba  un  script  en Python  usando  Spark  para  responder  a 
las siguientes preguntas: 
    a. Nombre y apellidos de los clientes capricornianos. 
    b. Nombre y apellido de los clientes de nacionalidad argentina. 
    c. Del resultado de a) cuántos nacieron en verano. 
    d. Del resultado de b) quién es el cliente más joven y quién el más viejo. 
    e. El ID de la caja que tiene asociado el préstamo con mayor cantidad de cuotas y 
    entre las que tienen la misma cantidad, el de mayor monto. 
    f. Los ID de clientes (únicos) con al menos una caja de ahorro (en positivo) cuyo 
    saldo es mayor a 300 U$S. 
    g. Del  dataset  Movimientos,  el  monto  del  mayor  movimiento  y  el  id  de  caja  del 
    último movimiento.'''

from re import split
import os, sys
os.environ["PYSPARK_PYTHON"] = sys.executable
os.environ["PYSPARK_DRIVER_PYTHON"] = sys.executable

from pyspark import SparkContext

sc = SparkContext("local[*]", "Banco-RDD")

#Lectura de archivos
cajas = sc.textFile("Practica5\Banco\CajasDeAhorro.txt") 
clientes = sc.textFile("Practica5\Banco\Clientes.txt") 
movimientos = sc.textFile("Practica5\Banco\Movimientos.txt")
prestamos = sc.textFile("Practica5\Banco\Prestamos.txt") 

#mapeo a los clientes para separarlos y poder trabajar con los valores
clientes = clientes.map(lambda t: t.split("\t"))
clientes = clientes.map(lambda t : (int(t[0]), t[1] + " " + t[2], int(t[3]), t[4], t[5])) #ID	NOMBRE	APELLIDO	DNI	AAAA-MM-DD	PAIS

#a. Nombre y apellidos de los clientes capricornianos. 22 de diciembre al 19 de enero
clienCapricornio = clientes.filter(
    lambda t: (
        (int(t[3][5:7]) == 12 and int(t[3][8:10]) >= 22) or
        (int(t[3][5:7]) == 1 and int(t[3][8:10]) <= 19)
    )
).map(lambda t: "Nombre: " + t[1] + " " + "Fecha: " + t[3])

'''for nombre in clienCapricornio.collect():
    print(nombre)'''

#b. Nombre y apellido de los clientes de nacionalidad argentina. 
clienARG = clientes.filter(lambda t: (t[4] == "ARG"))
'''for clien in clienARG.collect():
    print(clien)'''

#c. Del resultado de a) cuántos nacieron en verano. todos en realidad pero filtro
clienCapricornioAndVerano = clienCapricornio.filter(lambda t: (
        (int(t[3][5:7]) == 12 and int(t[3][8:10]) >= 21) or
        (int(t[3][5:7]) == 1) or
        (int(t[3][5:7]) == 2) or
        (int(t[3][5:7]) == 3 and int(t[3][8:10]) <= 21)
    ))

'''for clien in clienCapricornioAndVerano.collect():
    print(clien)'''

#d. Del resultado de b) quién es el cliente más joven y quién el más viejo. 
clienMasJoven = clienARG.reduce(lambda t1, t2: t1 if t1[3]<t2[3] else t2) #reduce devuelve tuplas 
clienMasViejo = clienARG.reduce(lambda t1, t2: t1 if t1[3]>t2[3] else t2)

'''print("Mas joven: " + clienMasJoven[1] + clienMasJoven[3])
print("Mas viejo: " + clienMasViejo[1] + clienMasViejo[3])'''

#e. El ID de la caja que tiene asociado el préstamo con mayor cantidad de cuotas y entre las que tienen la misma cantidad, el de mayor monto.
prestamos = prestamos.map(lambda t: t.split("\t"))
prestamos = prestamos.map(lambda t: (int(t[0]), int(t[1]), float(t[2]))) #ID_Caja Cuotas Monto
IDcuotasMax = prestamos.reduce(lambda t1, t2: t1 if (t1[1] > t2[1] or (t1[1] == t2[1] and t1[2] > t2[2])) else t2)[0]

#f. Los ID de clientes (únicos) con al menos una caja de ahorro (en positivo) cuyo saldo es mayor a 300 U$S. 
cajas = cajas.map(lambda t: t.split("\t"))
cajas = cajas.map(lambda t: (int(t[0]), int(t[1]), float(t[2]))) #ID_Caja ID_Cliente Saldo
cajas2 = cajas.filter(lambda t: t[2] > 300).map(lambda t: t[1]).distinct()

#g. Del  dataset  Movimientos,  el  monto  del  mayor  movimiento  y  el  id  de  caja  del último movimiento
movimientos = movimientos.map(lambda t: t.split("\t")).map(lambda t: (int(t[0]), float(t[1]), str(t[2])))
maxMov = movimientos.reduce(lambda t1, t2: t1 if t1[1]>t2[1] else t2)
ultimoMov = movimientos.reduce(lambda t1, t2: t1 if t1[2] > t2[2] else t2)[0]