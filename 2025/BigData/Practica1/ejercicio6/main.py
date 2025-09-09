'''Una  empresa  proveedora  de  internet  realizó  una  encuesta  para  conocer  el  grado  de 
satisfacción  de  sus  clientes,  en  un  formulario  web  los  clientes  debían  completar  un 
campo con los textos "Muy satisfecho", "Algo satisfecho", "Poco satisfecho", 
“Disconforme”  o  "Muy  disconforme".  Utilice  el  dataset  Encuesta  para  saber  cuántos 
clientes están en cada una de las cinco categorías.'''

from MRE import Job

root_path = "Practica1\ejercicio6"

inputDir = root_path + "\input"
outputDir = root_path + "\output"

def fmap(key, value, context):
    context.write(value,1)
        
def fred(key, values, context):
    c=0
    for v in values:
        c=c+v
    if(key == "muy satisfecho" or key == "algo satisfecho" or key == "poco satisfecho" or key == "disconforme" or  key == "muy disconforme"):
        context.write(key, c)

job = Job(inputDir, outputDir, fmap, fred)
success = job.waitForCompletion()

print("¿Job finalizado?:", success)

#Leemos el resultado
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print(f.read())