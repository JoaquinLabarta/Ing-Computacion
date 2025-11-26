from MRE import Job
root_path = "../TP1-BIG_DATA/"
inputDir = root_path + "INPUT/dataset/"
outputDir = root_path + "OUTPUT_P1/"

#Job1
#fase map agrupa por ID_Retador e ID_Retado para contabilizar
def fmap1(key, value, context):
    datos = value.split()

    context.write((key, "retador"), 1)
    context.write((datos[0], "retado"), 1)    

#fase combiner y reduce: suman ocurrencias de cada tipo "retador" y "retado" de cada jugador
def fcomb1(key, values, context):
    c = 0
    for v in values:
        c = c + v
    context.write(key, c)

def fred1(key, values, context):
    c = 0
    for v in values:
        c = c + v
    context.write(key, c)

#El resultado es la cantidad de veces que cada jugador fue retador o retado
job1 = Job(inputDir, outputDir, fmap1, fred1)
job1.setCombiner(fcomb1)
success1 = job1.waitForCompletion()

#-------------------------------------------------------------------------------------------

#Job2
#fase map: agrupa por "retador" y "retado" para luego evaluar maximos
def fmap2(key, value, context):
    datos = value.split()
    context.write(datos[0], (key, datos[1]))
 
#fase combiner y reduce: ejecutan la logica para evaluar el maximo en cada tipo
def fcomb2(key, values, context): 
    max = -1
    
    for v in values:

        if int(v[1])>max:
            max=int(v[1])
            id=v[0]

    context.write(key, (id, max))

def fred2(key, values, context):
    max = -1
    
    for v in values:

        if int(v[1])>max:
            max=int(v[1])
            id=v[0]
            
    if key == "retador":
        context.write(("El jugador mas retador:"), (("Jugador ") + id, ("con ") + str(max)))
    else:
        context.write(("El jugador mas retado:"), (("Jugador ") + id, ("con ") + str(max)))

#El resultado son los dos usuarios que mas veces fueron "retadores" y "retados"
job2 = Job(outputDir, outputDir, fmap2, fred2)
job2.setCombiner(fcomb2)
success2 = job2.waitForCompletion()