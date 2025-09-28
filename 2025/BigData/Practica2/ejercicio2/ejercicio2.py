#2 Implemente una función combiner para el problema del WordCount.

#codigo de wordcount
from MRE import Job

root_path = "Practica1\WordCount"

inputDir = root_path + "\input"
outputDir = root_path + "\output"

def fmap(key, value, context):
    words = value.split()
    for w in words:
        context.write(w, 1)

def fComb(key, values, context):
    c=0
    for v in values:
        c=c+v
    print(f"🔧 COMBINER ejecutado para '{key}': {len(values)} valores -> suma: {c}")
    context.write(key, c)        
        
def fred(key, values, context):
    c=0
    for v in values:
        c=c+1
    context.write(key, c)

job = Job(inputDir, outputDir, fmap, fred)
job.setCombiner(fComb)
success = job.waitForCompletion()

print("¿Job finalizado?:", success)

#Leemos el resultado
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print()