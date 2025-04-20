
public class PuntoC{
    public static int golesboca(Partido vec[], int dimf){
        int count = 0;
        String boca = "boca"; //se puede hacer un objeto?
        for (int i = 0; i < dimf; i++){
            if(vec[i].getLocal().equals(boca)){
                count += vec[i].getGolesLocal();
            }
        }
        return count;
    }
}