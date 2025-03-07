import java.util.Arrays;

public class Editorial {
    private String nomEdi;
    private int cantPremios;
    private Libro[] libros; // Aquí se inicializará el array libros
    private int DIMF = 5;
    private int DIML = 0;

    public Editorial(){
        libros = new Libro[DIMF]; // Inicializamos el array libros en el constructor vacío
    }

    public Editorial(String nomEdi, int cantPremios){
        setnomEdi(nomEdi);
        setCantPremios(cantPremios);
        DIML = 0;
        libros = new Libro[DIMF];
    }

    public void cargarVector(Libro libro){
        libros[DIML] = libro;
        DIML++;
        System.out.println("Libro cargado con exito");
    }

    public String getnomEdi() {
        return this.nomEdi;
    }

    public void setnomEdi(String nomEdi) {
        this.nomEdi = nomEdi;
    }

    public int getCantPremios() {
        return this.cantPremios;
    }

    public void setCantPremios(int cantPremios) {
        this.cantPremios = cantPremios;
    }

    @Override
    public String toString() {
        return "Editorial [nomEdi=" + nomEdi + ", cantPremios=" + cantPremios + ", libros=" + Arrays.toString(libros);
    }   
}