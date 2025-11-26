'''
El dataset website tiene información sobre el tiempo de permanencia de sus usuarios 
en cada una de las páginas del sitio. El formato de los datos del dataset es:  
 <id_user, id_page, time>  
Implemente una aplicación MapReduce, utilizando combiners en los casos que 
considere necesario, que calcule 
a. La página más visitada (la página en la que más tiempo permaneció) para cada 
usuario 
b. El usuario que más páginas distintas visitó 
c. La página más visitada (en cuanto a cantidad de visitas, sin importar el tiempo 
de permanencia) por todos los usuarios. 
Indique como queda el DAG del proceso completo (las tres consultas)'''

from MRE import Job

root_path = "Practica2\ejercicio5"

inputDir = root_path + "\website"
outputDir = root_path + "\output1"
output2Dir = root_path + "\output2"
output3Dir = root_path + "\output3"
outputMax2Dir = root_path + "\outputMax2Dir"
outputMax3Dir = root_path + "\outputMax3Dir"


#mando al reduce los tiempos de cada usuario por cada pagina.
def fmap1 (key, value, context):
    id_user = key
    data = value.split("\t")
    id_page = data[0]
    time = data [1]
    context.write((id_user, id_page), time)

#combiner para sumar todos los tiempos de un (idUser,idPagina) especifico
def fComb1(key, values, context):
    c=0
    for v in values:
        c+=int(v)
    context.write(key, c)

#el combiner ya me sumo parcialmente y me genero tuplas, por lo que solo me queda asegurar y guardar en output
def fred1(key, values, context):
    total = 0
    for v in values:
        total += int(v)
    context.write(key, total)

#---------------------------------------------------------------------------------------------------------------

#para cada usuario, guardo la pagina
def fmap2(key, value, context):
    idU = key
    idP, time = value.split()
    context.write(idU,idP)

#para cada usuario, cuento la cantidad de paginas distintas
def fred2(key, values, context):
    # values: lista de páginas visitadas por el usuario
    paginas_distintas = set(values)   # eliminar duplicados de la lista
    context.write(key, len(paginas_distintas))  # cantidad de páginas distintas

#---------------------------------------------------------------------------------------------------------------

def fmap3(key, value, context):
    idU = key
    idP, time = value.split()
    context.write(idP,1)

def fComb3(key, values, context): 
    c=0
    for v in values:
        c+=v
    context.write(key,c)

def fred3(key, values, context): #key idP, values es lista de ocurrencias
    total=0
    for v in values:
        total+=v
    context.write(key, total) 

#---------------------------------------------------------------------------------------------------------------
def fmap2max(key,value,context): #key usuario, value cantidad de paginas
    context.write(1, (key,int(value)))

def fred2max(key, values, context):
    max = -1
    idUserMax = -1
    for v in values:
        usuario = v[0]
        cantPaginas = v[1]
        
        if(cantPaginas > max):
            idUserMax = usuario
            max = cantPaginas
    context.write(idUserMax, max)
#---------------------------------------------------------------------------------------------------------------

def fmap3max(key,value,context): #key idP, values es total de ocurrencias
    context.write(1, (key,int(value)))

def fred3max(key, values, context):
    max = -1
    idPagMax = -1
    for v in values:
        pagina = v[0]
        cantVisitas = v[1]
        
        if(cantVisitas > max):
            idPagMax = pagina
            max = cantVisitas
    context.write(idPagMax, max)

#---------------------------------------------------------------------------------------------------------------
job1 = Job(inputDir, outputDir, fmap1, fred1)
job1.setCombiner(fComb1)
success1 = job1.waitForCompletion()

job2 = Job(inputDir, output2Dir, fmap2, fred2)
success2 = job2.waitForCompletion()

job3 = Job(inputDir, output3Dir, fmap3, fred3)
job3.setCombiner(fComb3)
success3 = job3.waitForCompletion()

job4 = Job(output2Dir, outputMax2Dir, fmap2max, fred2max)
success4 = job4.waitForCompletion()

job5 = Job(output3Dir, outputMax3Dir, fmap3max, fred3max)
success5 = job5.waitForCompletion()

#---------------------------------------------------------------------------------------------------------------

print("¿Job1 finalizado?:", success1)
print("¿Job2 finalizado?:", success2)
print("¿Job3 finalizado?:", success3)
print("¿Job4 finalizado?:", success4)
print("¿Job5 finalizado?:", success5)

#---------------------------------------------------------------------------------------------------------------
#Leemos el resultado del job1
with open(outputDir + "\output.txt", "r", encoding="latin-1") as f:
    print()

#Leemos el resultado del job4
with open(outputMax2Dir + "\output.txt", "r", encoding="latin-1") as f:
    print("El usuario que más páginas distintas visito: " + f.read())

#Leemos el resultado del job5
with open(outputMax3Dir + "\output.txt", "r", encoding="latin-1") as f:
    print("página más visitada: " + f.read())