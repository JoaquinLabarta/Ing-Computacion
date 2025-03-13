
public class PuntoC 
{
    public static String dnimin(Persona vec[],int dimf){
        Persona menorDni = new Persona();
        menorDni.setDNI(99999999);
        for (int i = 0; i < dimf; i++){
            if (vec[i].getDNI() <= menorDni.getDNI()){menorDni = vec[i];}
        }
        return menorDni.toString();
    }
}