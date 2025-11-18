'''4) Es posible resolver los  siguientes problemas (por  separado) utilizando una única 
función reduce: 
a. El promedio de edades de los clientes 
b. Determinar la cantidad de cuentas con saldo positivo y la cantidad de cuentas 
con saldo negativo.'''

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

# Determinar la cantidad de cuentas con saldo positivo y la cantidad de cuentas  con saldo negativo.
cajas = cajas.map(lambda t: t.split("\t"))
saldo_reduc = cajas.map(lambda t: float(t[3])).map(lambda t: (1, 0) if t >= 0 else (0, 1)).reduce(lambda a, b: (a[0] + b[0], a[1] + b[1]))

print(f"Número de cuentas con saldo positivo: {saldo_reduc[0]}")
print(f"Número de cuentas con saldo negativo: {saldo_reduc[1]}")