public class Autor {
    private int dni;
    private String nombreCompleto,nacionalidad;

    public Autor(){
        //Constructor vacio
    }

    public Autor(int dni, String nombreCompleto, String nacionalidad){
        setDni(dni);
        setNombreCompleto(nombreCompleto);
        setNacionalidad(nacionalidad);
    }

    public int getDni() {
        return this.dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getNombreCompleto() {
        return this.nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getNacionalidad() {
        return this.nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }
}
