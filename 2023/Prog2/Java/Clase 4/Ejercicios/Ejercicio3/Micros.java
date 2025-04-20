
public class Micros
{
    private int dimf = 20;
    private int diml;
    private boolean[] asientos;
    private String patente;
    private String horario;
    private String destino;
    
    //Constructor con diml = 0
    public Micros(String patente, String horario, String destino)
    {
        this.setPatente(patente);
        this.setHorario(horario);
        this.setDestino(destino);
        asientos = new boolean[dimf];
        for (int i = 0; i < dimf; i++){
            asientos[i] = false;
        }
        this.diml = 0;
    }
        
    //Constructor vacio
    public Micros(){
        
    }
    
    public int cantAsientos(){ //devuelve cant de asientos ocupados
        return diml;
    }
    
    public boolean lleno(){ //devuelve true si el micro esta lleno
        boolean exito = false;
        if(diml == dimf){
            exito = true;
        }
        return exito;
    }
    
    public boolean validar(int num){ //devuelve true si existe el asiento
        boolean exito = false;
        if ((num >= 0) && (num < dimf)){
            exito = true;
        }
        return exito;
    }
    
    public boolean asientoOcupado(int num){ //devuelve true si el asiento esta ocupado
        boolean ocupado = false;
        if(validar(num)){
            if (asientos[num]){
                ocupado = true; //asiento ocupado
            }
        }
        return ocupado;
    }
    
    public boolean ocuparAsiento(int num){ //devuelve true si se ocupó
        boolean exito = false;
        if(validar(num)){
            if (asientoOcupado(num) == false){
                asientos[num] = true;
                diml ++;
                exito = true;
            }
        }
        return exito;
    }
    
    public void liberarAsiento(int num){
        if(validar(num)){
            if (asientoOcupado(num)){
                asientos[num] = false;
                diml--;
            }
        }
    }
    
    public int asientoLibre(){ //devuelve -1 si no hay asientos libres
        boolean exito = false;
        int i = 0;
        int num = -1;
        while ((exito != true) && (i < dimf)){
            if (asientoOcupado(i) == false){
                exito = true;
                num = i;
            }
            i++;
        }
        return num;
    }
    
    //getters
    public void setPatente (String patente){
        this.patente = patente;
    }
    
    public void setHorario (String horario){
        this.horario = horario;
    }
    
    public void setDestino (String destino){
        this.destino = destino;
    }
    
    //setters
    public String getPatente(){
        return this.patente;
    }
    
    public String getHorario(){
        return this.horario;
    }
    
    public String getDestino(){
        return this.destino;
    }
}
