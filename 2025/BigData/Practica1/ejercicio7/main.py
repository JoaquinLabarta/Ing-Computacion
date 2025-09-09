'''El dataset  Inversionistas  posee  los  nombres, dni, fecha de nacimiento (día, mes y año  como  campos  separados)  e  
importe  invertido  por  diferentes  personas  en  la  apertura  de un nuevo negocio en la ciudad.  Se desea saber: 
a. El nombre del inversionista más joven 
b. El total del importe invertido por todos los inversionistas 
c. El promedio de edad 
Implemente una solución en MapReduce. ¿Se puede resolver los tres problemas en un 
único job?'''

from MRE import Job
from datetime import date

root_path = "Practica1\ejercicio7"

inputDir = root_path + "\input"
outputDir = root_path + "\output"

def fmap(key, value, context):
    campos = value.split()
    context.write(1, campos)

def fred(key, values, context):
    nombreMasJoven = ""
    fechaMasJoven = [0,0,0]   # día, mes, año
    sumaImportes = 0
    sumaEdad = 0
    count = 0

    hoy = date.today()
    current_year = hoy.year
    current_month = hoy.month
    current_day = hoy.day

    for v in values:
        nombre = v[0]
        dni = v[1]
        fecha_nacimiento = (int(v[2]), int(v[3]), int(v[4]))
        importe = float(v[5])

        # más joven
        if fechaMasJoven == (0,0,0) or \
        fecha_nacimiento[2] > fechaMasJoven[2] or \
        (fecha_nacimiento[2] == fechaMasJoven[2] and fecha_nacimiento[1] > fechaMasJoven[1]) or \
        (fecha_nacimiento[2] == fechaMasJoven[2] and fecha_nacimiento[1] == fechaMasJoven[1] and fecha_nacimiento[0] > fechaMasJoven[0]):
            for i in range(len(fechaMasJoven)):
                fechaMasJoven[i] = fecha_nacimiento[i]
            nombreMasJoven = nombre

        # sumo importes totales   
        sumaImportes += importe

        # calculo edad
        edad = current_year - fecha_nacimiento[2] - ((current_month, current_day) < (fecha_nacimiento[1], fecha_nacimiento[0]))
        sumaEdad += edad
        count += 1

    # promedio de edad
    if count > 0:
        promedioEdad = sumaEdad / count
        context.write("Promedio edad", promedioEdad)
    else:
        context.write("Promedio edad", 0)

    context.write("Mas joven", nombreMasJoven)
    context.write("Total invertido", sumaImportes)

job = Job(inputDir, outputDir, fmap, fred)
success = job.waitForCompletion()

print("¿Job finalizado?:", success)

with open(outputDir + "\\output.txt", "r", encoding="latin-1") as f:
    print(f.read())