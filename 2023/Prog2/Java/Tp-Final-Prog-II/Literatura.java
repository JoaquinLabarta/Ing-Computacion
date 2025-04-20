public class Literatura extends Libro{
    String genero;
    boolean bolsillo;
    
    public Literatura(){
        //Constructor vacio
    }

    public Literatura(String genero, boolean bolsillo, String isbn, String nomLib, int cantPaginas, float precio, String fecha, Autor autor, String tipoLib){
        super(isbn,nomLib,cantPaginas,precio,fecha,autor,tipoLib);
        setGenero(genero);
        setBolsillo(bolsillo);
    }

    public float calcularMonto(){
        float precTotal = super.getPrecio();
        if (isBolsillo()) {
            precTotal -= precTotal*0.15;
        }
        if ((getGenero().equals("cuento") || (getGenero().equals("novela")))) {
            precTotal -= precTotal*0.05;
        }
        return precTotal;
    }
    
    public String getGenero() {
        return this.genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public boolean isBolsillo() {
        return this.bolsillo;
    }

    public void setBolsillo(boolean bolsillo) {
        this.bolsillo = bolsillo;
    }

    @Override
    public String toString() {
        return super.toString() + ", genero=" + this.genero + ", bolsillo=" + this.bolsillo;
    }
}
