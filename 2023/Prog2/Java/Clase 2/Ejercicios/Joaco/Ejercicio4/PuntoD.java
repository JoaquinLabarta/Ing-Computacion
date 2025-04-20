
public class PuntoD{
    public static int empates(Partido vec[], int dimf){
        int count = 0;
        for (int i = 0; i < dimf; i++){
            if(vec[i].hayEmpate() == true){
                count ++;
            }
        }
        return (count*100/dimf);
    }
}