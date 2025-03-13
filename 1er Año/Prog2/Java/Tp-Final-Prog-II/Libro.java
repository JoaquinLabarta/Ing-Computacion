public abstract class Libro {
    private String isbn, nomLib, fecha;
    private int cantPaginas;
    private float precio;
    private Autor autor;
    private String tipoLib;

    public Libro(){
        //Constructor vacio
    }

    public Libro(String isbn, String nomLib, int cantPaginas, float precio, String fecha, Autor autor, String tipoLib){
        setIsbn(isbn);
        setnomLib(nomLib);
        setCantPaginas(cantPaginas);
        setPrecio(precio);
        setFecha(fecha);
        setAutor(autor);
        settipoLib(tipoLib);
    }

    public String getIsbn() {
        return this.isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getnomLib() {
        return this.nomLib;
    }

    public void setnomLib(String nomLib) {
        this.nomLib = nomLib;
    }

    public String getFecha() {
        return this.fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getCantPaginas() {
        return this.cantPaginas;
    }

    public void setCantPaginas(int cantPaginas) {
        this.cantPaginas = cantPaginas;
    }

    public float getPrecio() {
        return this.precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public Autor getAutor() {
        return this.autor;
    }

    public void setAutor(Autor autor) {
        this.autor = autor;
    }

    public String gettipoLib() {
        return this.tipoLib;
    }

    public void settipoLib(String tipoLib) {
        this.tipoLib = tipoLib;
    }

    abstract float calcularMonto();

    @Override
    public String toString() {
        return "Libro [isbn=" + isbn + ", nomLib=" + nomLib + ", fecha=" + fecha + ", cantPaginas=" + cantPaginas
                + ", precio inicial=" + precio + ", precio con descuento=" + calcularMonto() + ", autor=" + autor.getNombreCompleto() + ", tipoLib=" + tipoLib + "]";
    }
}