
public class PuntoB{
    public static int partidosriver(Partido vec[], int dimf){
        int count = 0;
        String river = "river";
        for (int i = 0; i < dimf; i++){
            if(vec[i].getGanador().equals(river)){
                count++;
            }
        }
        return count;
    }
}