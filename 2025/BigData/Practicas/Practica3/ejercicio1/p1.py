from multiprocessing import context
from MRE import Job
root_path = "C:/Users/maxim/OneDrive/Desktop/2do cuatri/big data/"
inputDir = root_path + "INPUT/Jacobi/"
outputDir = root_path + "OUTPUT/"

def fmap(key, value, context):
    vars = context["incognitas"]

    coefs = value.strip().split("\t")
    coefs = [float(x) for x in coefs]
    res = 0
    for i in range(4):
        res = res + vars[i] * coefs[i] 
    context.write(key, res)


def comb(key, values, context):
    c = 0
    for v in values:
        c = c + v
    context.write(key, c)

def fred(key, values, context):
    for v in values:
        res=v
    context.write(key, res)

vars = {"incognitas": [1, 1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15]}
def evaluarFin():
    suma = 0
    
    with open(outputDir + "output.txt", "r") as f:
        i = 1
        suma=0
        for line in f:
            partes = line.strip().split("\t")   # separa en columnas
            variable = int(partes[0][3:])
            valor = float(partes[1])  # de la 2da en adelante a float
            suma += (vars["incognitas"][variable] - valor)**2
            vars["incognitas"][variable] = valor
        print(suma)
        return False if suma < 0.01 else True

continuar = True

while (continuar):

    job = Job(inputDir, outputDir, fmap, fred)
    job.setParams(vars)
    success = job.waitForCompletion()

    continuar = evaluarFin()
