from MRE import Job

root_path = "Practica1\WordCount"

inputDir = root_path + "\input"
outputDir = root_path + "\output"

def fmap(key, value, context):
    words = value.split()
    for w in words:
        context.write(w, 1)
        
def fred(key, values, context):
    c=0
    for v in values:
        c=c+1
    context.write(key, c)

job = Job(inputDir, outputDir, fmap, fred)
success = job.waitForCompletion()

print("¿Job finalizado?:", success)

#Leemos el resultado
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print(f.read())

    #Top 20 palabras mas usadas
    f.seek(0)
    lines = f.readlines()
    word_count = {}
    for line in lines:
        word, count = line.split()
        word_count[word] = int(count)

    # Obtener el top 20 de palabras más usadas
    top_20 = sorted(word_count.items(), key=lambda x: x[1], reverse=True)[:20]
    print("Top 20 palabras más usadas:")
    for word, count in top_20:
        print(f"{word}: {count}")

#contar  cuántas  vocales,  consonantes,  dígitos, espacios y otros caracteres usando jobs de MapReduce

def char_fmap(key, value, context):
    for c in value:
        if c.isalpha():
            if c.lower() in 'aeiou':
                context.write('vocales', 1)
            else:
                context.write('consonantes', 1)
        elif c.isdigit():
            context.write('digitos', 1)
        elif c.isspace():
            context.write('espacios', 1)
        else:
            context.write('otros', 1)

def char_fred(key, values, context):
    c=0
    for v in values:
        c=c+1
    context.write(key, c)

char_job = Job(inputDir, outputDir, char_fmap, char_fred)
char_success = char_job.waitForCompletion()

#mostrar cantidad de vocales, consonantes, dígitos, espacios y otros caracteres
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    lines = f.readlines()
    char_count = {}
    for line in lines:
        char, count = line.split()
        char_count[char] = int(count)

    print("Cantidad de caracteres:")
    for char, count in char_count.items():
        print(f"{char}: {count}")


'''#5) Indique si utilizando el dataset Libros es posible resolver los siguientes problemas: 
a. Obtener los títulos de todos los libros 
b. Obtener  la cantidad de palabras promedio por párrafo 
c. Obtener  la cantidad de párrafos promedio por libro 
d. Obtener  la cantidad de caracteres del párrafo más extenso 
e. Cantidad  total  de  párrafos  con  diálogos  (se  entiende  por  párrafo  con  diálogo 
aquel que empieza con un guión) 
f. El diálogo más largo (se entiende por diálogo a una secuencia de párrafos con 
diálogo que aparecen de manera consecutiva) 
g. El top 20 de las palabras más usadas por cada libro'''

''' a. Sí, es posible obtener los títulos de todos los libros utilizando un job de MapReduce que extraiga el título de cada libro en la fase de mapeo y luego los agrupe en la fase de reducción.
b. Sí, es posible calcular la cantidad de palabras promedio por párrafo utilizando un job de MapReduce que cuente las palabras en cada párrafo durante la fase de mapeo y luego calcule el promedio en la fase de reducción.
c. Sí, es posible calcular la cantidad de párrafos promedio por libro utilizando un job de MapReduce que cuente los párrafos en cada libro durante la fase de mapeo y luego calcule el promedio en la fase de reducción.
d. Sí, es posible obtener la cantidad de caracteres del párrafo más extenso utilizando un job de MapReduce que mida la longitud de cada párrafo durante la fase de mapeo y luego determine el máximo en la fase de reducción.
e. Sí, es posible contar la cantidad total de párrafos con diálogos utilizando un job de MapReduce que identifique los párrafos que comienzan con un guión durante la fase de mapeo y luego los cuente en la fase de reducción.
f. Sí, es posible encontrar el diálogo más largo utilizando un job de MapReduce que identifique secuencias de párrafos con diálogos durante la fase de mapeo y luego determine la secuencia más larga en la fase de reducción.
g. Sí, es posible obtener el top 20 de las palabras más usadas por cada libro utilizando un job de MapReduce que cuente las palabras en cada libro durante la fase de mapeo y luego seleccione las 20 palabras más frecuentes en la fase de reducción.'''