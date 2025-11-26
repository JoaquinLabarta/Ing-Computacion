from MRE import Job
root_path = "../TP1-BIG_DATA/"
inputDir = root_path + "INPUT/dataset/"
outputDir = root_path + "OUTPUT_P2/"

#Job1
#fase map: se extraen todos los puntajes para cada retador y cuenta las ocurrencias 
def fmap1(key, value, context):
    datos = value.split()
    context.write(key, (datos[1], 1))

#fase combiner: suma los puntajes parciales para cada retador y las ocurrencias 
def fcomb1(key, values, context):
    s = 0
    c = 0
    for v in values:
        s = s + int(v[0])
        c += v[1]
    context.write(key, (s, c))

#fase reduce: calcula el promedio de cada retador
def fred1(key, values, context):
    total = 1
    combates = 1
    for v in values:
        total = total + int(v[0])
        combates += int(v[1])
    prom=total/combates
    context.write(key, prom)

job1 = Job(inputDir, outputDir, fmap1, fred1)
job1.setCombiner(fcomb1)
success1 = job1.waitForCompletion()

#-------------------------------------------------------------------------------------
#Job2
def fmap2(key, value, context):
    datos = value.split()
    context.write(1,(key,datos[0]))
 

def fcomb2(key, values, context): 
    max = -1
    
    for v in values:
        if float(v[1])>max:
            max=float(v[1])
            id=v[0]

    context.write(1, (id, max))

def fred2(key, values, context):
    max = -1
    for v in values:
        if float(v[1])>max:
            max=float(v[1])
            id=v[0]
            
    context.write("El jugador con mas puntos en promedio:", (id, ("con un promedio de: ") + str(max)))

job2 = Job(outputDir, outputDir, fmap2, fred2)
job2.setCombiner(fcomb2)
success2 = job2.waitForCompletion()