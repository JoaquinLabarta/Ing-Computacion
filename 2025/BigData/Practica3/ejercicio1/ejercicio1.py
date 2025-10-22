'''El dataset Jacobi tiene los coeficientes de un sistema de 15 ecuaciones de 15 
incógnitas.  Las  ecuaciones  en  el  archivo  ya  están  "despejadas"  como  lo  requiere  el 
método de Jacobi. Cada línea del archivo posee:
    <var_N, term_ind, coef_var1, coef_var2, ... , coef_ var15> 
Por simplicidad, para cada variable N su correspondiente coeficiente es cero. 
Implemente  en  MapReduce  el  cálculo  del  método  de  Jacobi  para  la  solución  del 
sistema de ecuaciones dado.'''

from MRE import Job

root_path = "Practica3\ejercicio1"

inputDir = root_path + "\input"
outputDir = root_path + "\output"

def fmap1(key, value, context):
    vars= (1, 1, 2, 3)
    coefs= value.split("\t")
    res = 0
    for v in range(4):
        res = res + vars[v] * coefs[v]
    context.write(key, res)

def fred1(key, values, context):
    res = 0
    for v in values:
        res = v
    context.write(key, res)
#---------------------------------------------------------------------------------------------------------------
job1 = Job(inputDir, outputDir, fmap1, fred1)
success1 = job1.waitForCompletion()

print("¿Job1 finalizado?:", success1)
#---------------------------------------------------------------------------------------------------------------
#Leemos el resultado del job1
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print()