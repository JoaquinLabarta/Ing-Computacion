
public class PuntoB
{   
    public static int contador(Persona vec[],int dimf){ 
        int count = 0;
        for (int i = 0; i < dimf; i++){
            if (vec[i].getEdad() > 65){count ++;}
        }
        return count;
    }
}