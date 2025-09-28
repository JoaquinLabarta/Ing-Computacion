'''Utilice  el  dataset  Libros  para  implementar  una  aplicación  MapReduce  que  devuelva 
como salida todos los párrafos que tienen una longitud mayor al promedio.'''

'''

'''

from MRE import Job

root_path = "Practica2\ejercicio4"

inputDir = root_path + "\Libros"
outputDir = root_path + "\outputFinal"
tmpDir = "\outputIntermedio"

def fmap(key, value, context):
    words = value.split()
    for w in words:
        #w es cada una de las palabras que contiene el parrafo
        context.write(value, w) #lo envio nada mas en la key que representa a cada parrafo
          
def fred(key, values, context):
    #key es el parrafo
    count_palabras = 0
    for v in values:
        #v es cada palabra
        count_palabras+=1
    context.write(1, (key,count_palabras)) #guardo cantidad de palabras y cada parrafo

def fmap2(key, value, context):
    context.write(1,(key,value))

def fred2(key, values, context):
    min = 0
    parMin
    for v in values:
        parrafo: 

job = Job(inputDir, tmpDir, fmap, fred)
job2 = Job(tmpDir, outputDir, fmap2, fred2)
success = job.waitForCompletion()
success = job2.waitForCompletion()

print("¿Job1 finalizado?:", success)