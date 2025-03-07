
public class flota
{
    private Micros micro;
    private int dimfflota = 15;
    private Micros[] f;
    private int dimlflota = 0;
    
    //Constructor con flota vacia 
    public flota(){
        f = new Micros[dimfflota];
    }
    
    //Constructor con parametros
    public flota(Micros micro){
        this.micro = micro;
        f = new Micros[dimfflota]; 
        this.dimlflota = 0;
    }
    
    //Devuelve true si la flota está llena
    public boolean flotaCompleta(){
        boolean lleno = false;
        if (dimlflota == dimfflota){
            lleno = true;
        }
        return lleno;
    }
    
    //Agrega un micro a la flota
    public void agregarMicro(Micros m){
        if (flotaCompleta() == false){
            f[dimlflota] = m;
            dimlflota++;
        }
    }
    
    //Elimina un micro por patente recibida
    public boolean eliminarMicro(String pat){
        boolean exito = false;
        int i = 0;
        if (dimlflota != 0){
            while ((!exito) && (i < dimlflota)){
                if(f[i].getPatente().equals(pat)){
                    f[i] = null;
                    exito = true;
                    dimlflota --;
                }
                i++;
            }   
        }
        return exito;
    }
    
    //Busca un micro por patente
    public Micros buscarMicroPatente(String pat){
        Micros m = null;
        boolean exito = false;
        int i = 0;
        if (dimlflota != 0){
            while ((!exito) && (i <= dimlflota)){
                if(f[i].getPatente().equals(pat)){
                    exito = true;
                    m = f[i];
                }
                i++;
            }   
        }
        return m;
    }
    
    //Busca un micro por destino
    public Micros buscarMicroDestino(String des){
        Micros m1 = null;
        boolean exito = false;
        int i = 0;
        if (dimlflota != 0){
            while ((!exito) && (i < dimlflota)){
                if(f[i].getDestino().equals(des)){
                    exito = true;
                    m1 = f[i];
                }
                i++;
            }   
        }
        return m1;
    }
    
    //getter 
    public Micros getMicro(int pos){
        return f[pos];
    }
    
    
}
