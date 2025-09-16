#Implemente  un  job  MapReduce  para  calcular  el  máximo,  mínimo,  promedio  y  
# desvío stándard de las ocurrencias de todas las palabras del dataset Libros
from MRE import Job
root_path = "Practica2\ejercicio3"

inputDir = root_path + "\Libros"
outputDir = root_path + "\outputLibros"
tmpDir = "\output"

def fmap(key, value, context):
    words = value.split()
    for w in words:
        context.write(w, 1)     
        
def fred(key, values, context):
    c=0
    for v in values:
        c=c+1
    context.write(key, c)

#Al fmap2 le llegan una lista de palabras con ocurrencias
def fmap2(key, value, context):
    palabra = key
    ocurrencias = int(value)
    # Enviar la ocurrencia como valor para calcular estadísticas
    context.write(1, (palabra,ocurrencias))
        
def fred2(key, values, context):
    nomMaximo = ""
    nomMinimo = ""
    max = 0
    min = 9999
    suma = 0
    # Calcular estadísticas de las ocurrencias
    lista = list(values)
    for i in lista:
        palabra = i[0]
        ocurrencias = i[1]
        if ocurrencias > max:
            max = ocurrencias
            nomMaximo = palabra
        if ocurrencias < min:
            min = ocurrencias
            nomMinimo = palabra
        suma += ocurrencias
    promedio = suma / len(lista)
    context.write("maximo:", (nomMaximo, max))
    context.write("minimo:", (nomMinimo, min))
    context.write("promedio:", promedio)


job = Job(inputDir, tmpDir, fmap, fred)
job2 = Job(tmpDir,outputDir,fmap2,fred2)
success = job.waitForCompletion()
success2 = job2.waitForCompletion()

print("¿Job1 finalizado?:", success)
print("Job2 finalizado?", success2)

#Leemos el resultado
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print(f.read())