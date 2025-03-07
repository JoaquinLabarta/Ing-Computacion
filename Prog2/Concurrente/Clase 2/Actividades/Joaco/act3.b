programa clase2Act4
procesos
  proceso RecorrerCallePar
  variables
    cantPapel:numero
  comenzar
    repetir 99
      cantPapel:=0
      mientras HayFlorEnLaEsquina
        tomarFlor
      mientras HayPapelEnLaEsquina
        tomarPapel
        cantPapel:=cantPapel+1
      repetir cantPapel
        depositarPapel
      mover
    cantPapel:=0
    mientras HayFlorEnLaEsquina
      tomarFlor
    mientras HayPapelEnLaEsquina
      tomarPapel
      cantPapel:=cantPapel+1
    repetir cantPapel
      depositarPapel
  fin
  
  proceso RecorrerCalleImpar
  variables
    cantFlor: numero
  comenzar
    repetir 99
      cantFlor:=0
      mientras HayFlorEnLaEsquina
        tomarFlor
        cantFlor:=cantFlor+1
      mientras HayPapelEnLaEsquina
        tomarPapel
      repetir cantFlor
        depositarFlor
      mover
    cantFlor:=0
    mientras HayPapelEnLaEsquina
      tomarPapel
    mientras HayFlorEnLaEsquina
      tomarFlor
      cantFlor:=cantFlor+1
    repetir cantFlor
      depositarFlor
  fin
{-----------------------------------------------------------------------------}
areas 
  Area1: AreaP(1,1,100,1)
  Area2: AreaP(1,2,100,2)
  Area3: AreaP(1,3,100,3)
  Area4: AreaP(1,4,100,4)
{-----------------------------------------------------------------------------}
robots
  robot robot1
  comenzar
    derecha
    RecorrerCalleImpar
    Pos(1,PosCa)
  fin
  
  robot robot2
  comenzar
    derecha
    RecorrerCallePar
    Pos(1,PosCa)
  fin
  
{-----------------------------------------------------------------------------}
variables
  Robot1: robot1
  Robot2: robot2
  Robot3: robot1
  Robot4: robot2
{-----------------------------------------------------------------------------}
comenzar
  AsignarArea(Robot1,Area1)
  AsignarArea(Robot2,Area2)
  AsignarArea(Robot3,Area3)
  AsignarArea(Robot4,Area4)
  Iniciar(Robot1,1,1)
  Iniciar(Robot2,1,2)
  Iniciar(Robot3,1,3)
  Iniciar(Robot4,1,4)
fin

