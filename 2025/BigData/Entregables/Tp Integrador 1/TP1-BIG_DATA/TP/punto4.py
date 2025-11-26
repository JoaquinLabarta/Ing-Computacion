from MRE import Job
root_path = "../TP1-BIG_DATA/"
inputDir = root_path + "INPUT/dataset/"
outputDir = root_path + "OUTPUT_P4_5/"
outputDir1 = root_path + "OUTPUT_P4_1/"
outputDir2 = root_path + "OUTPUT_P4_2/"
outputDir3 = root_path + "OUTPUT_P4_3/"
outputDir4 = root_path + "OUTPUT_P4_4/"

#se utilizan 5 salidas solo para poder ir viendo los cambios
def fmap1(key, value, context):
    datos = value.split("\t")
    context.write(key, (datos[1], 1))

def fcomb1(key, values, context):
    s = 0
    c = 0
    for v in values:
        s = s + int(v[0])
        c += int(v[1])
    context.write(key, (s, c))

def fred1(key, values, context):
    total = 0
    combates = 0
    for v in values:
        total = total + int(v[0]) + 1
        combates += int(v[1]) + 1

    prom=total/combates
    context.write(key, prom)

job1 = Job(inputDir, outputDir, fmap1, fred1)
job1.setCombiner(fcomb1)
success1 = job1.waitForCompletion()

#---------------------------------------------------------------------------------------------
def cargar_pp_dict():
    d = {}

    with open(outputDir + "output.txt", "r") as f:
        for line in f:
            i, pp = line.split("\t")
            d[i] = float(pp)
    return d

PP_vec  = cargar_pp_dict()  

def fmap_aristas(key, value, ctx):
    datos = value.split("\t")
    j=datos[0]
    ctx.write((key, j), 1)          

def fred_aristas(key, values, ctx):
    i, j = key
    ctx.write(i, j)              

job2 = Job(inputDir, outputDir1, fmap_aristas, fred_aristas)
job2.waitForCompletion()

#-----------------------------------------------------------------------------------------
ALPHA = 0.1

def fmap_coef(i, j, ctx):  
    coefs = ctx    
    pp_i = coefs["PP"].get(i, 1.0)
    pp_j = coefs["PP"].get(j, 1.0)
    c_ij = coefs["alpha"] * (pp_i / pp_j)
    ctx.write(i, (j, c_ij))

def fred_coef(i, values, ctx):
    for v in values:
        ctx.write(i, v)

jobCoef = Job(outputDir1, outputDir2, fmap_coef, fred_coef)
jobCoef.setParams({"PP": PP_vec, "alpha": ALPHA}) 
jobCoef.waitForCompletion()

#---------------------------------------------------------------------------------------------
#se crea a partir de PP_vec clocando un 1 solo en las posiones presentes en PP_vec
PH_vec = {jug: 1.0 for jug in PP_vec.keys()}

def fmapJacob(key, value, context):
    
    data = value.split("\t")
    j=data[0]
    coef=float(data[1])
    PHj=context["PH"].get(j, 1.0)
    context.write(key, PHj*coef)

def fredJacob(key, values, context):
    res=0
    for v in values:   
        res += float(v)
    res+=1-context["alpha"]
    context.write(key, res)

def evaluarFin():
    suma = 0
    
    with open(outputDir3 + "output.txt", "r") as f:
        i = 1
        suma=0
        for line in f:  
            partes = line.split("\t")   
            variable = partes[0]
            valoract = float(partes[1])  
            valorant = PH_vec[variable]
            suma += (valorant - valoract)**2
            PH_vec[variable] = valoract

        return False if suma < 0.01 else True

continuar = True
i=0
while (continuar):

    jobJacob = Job(outputDir2, outputDir3, fmapJacob, fredJacob)
    jobJacob.setParams({"PH": PH_vec, "alpha": ALPHA})
    jobJacob.waitForCompletion()
    i+=1
    continuar = evaluarFin()
    
def fmapTOP10(key, value, context):
    HP = value
    context.write(HP, (key, HP))

def fredTOP10(key, values, context):
    i=0
    for v in values:
        if i==10:
            break
        context.write("Top " + str(i+1) + ": " +"Jugador numero: " + v[0], "con puntaje heroico: " + v[1])
        i+=1

def fShuffleCmp(k1, k2):
        return 0

def fSortCmp(k1, k2):
    if(float(k1) == float(k2)):
        return 0
    elif(float(k1) > float(k2)):
        return -1
    else:
        return 1

jobTOP = Job(outputDir3, outputDir4, fmapTOP10, fredTOP10)
jobTOP.setShuffleCmp(fShuffleCmp)
jobTOP.setSortCmp(fSortCmp)
success = jobTOP.waitForCompletion()