from MRE import Job
root_path = "../TP1-BIG_DATA/"
inputDir = root_path + "INPUT/dataset/"
outputDir = root_path + "OUTPUT_P3/"

#Job1
def fmap1(key, value, context):
    datos = value.split()

    context.write((key, datos[0]), 1)

def fred1(key, values, context):

    context.write(key[0], 1)

job1 = Job(inputDir, outputDir, fmap1, fred1)
success1 = job1.waitForCompletion()

#--------------------------------------------------------------------------------
#Job2
def fmap2(key, value, context):
    context.write(key, 1)
 

def fcomb2(key, values, context): 
    sum=0
    for v in values:
        sum = sum + int(v)

    context.write(key, sum)

def fred2(key, values, context):
    H=context["H"]
    sum=0
    for v in values:
        sum = sum + int(v)
    if sum>H:
        context.write("El jugador: " + key, ("reto a ") + str(sum) + " distintos")

parametro = {"H": 12}
job2 = Job(outputDir, outputDir, fmap2, fred2)
job2.setCombiner(fcomb2)
job2.setParams(parametro)
success2 = job2.waitForCompletion()