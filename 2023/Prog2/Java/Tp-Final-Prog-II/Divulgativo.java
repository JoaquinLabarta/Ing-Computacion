public class Divulgativo extends Libro {
    String tipoDiv;

    public Divulgativo(){
        //Costructor vacio
    }

    public Divulgativo(String tipoDiv,String isbn, String nomLib, int cantPaginas, float precio, String fecha, Autor autor, String tipoLib){
        super(isbn,nomLib,cantPaginas,precio,fecha,autor,tipoLib);
        settipoDiv(tipoLib);
    }

    public float calcularMonto(){
        float precTotal = super.getPrecio();
        if((super.getFecha().compareTo("15/12/2022")<0) && (super.getFecha().compareTo("15/03/2020")>0) ){
            precTotal -= precTotal*0.065;
        }
        if ((gettipoDiv().equals("cientifica")) && (getAutor().getNacionalidad().equals("argentina"))) {
            precTotal -= precTotal*0.1;
        }
        return precTotal;
    }
    
    public String gettipoDiv() {
        return this.tipoDiv;
    }

    public void settipoDiv(String tipoLib) {
        this.tipoDiv = tipoLib;
    }

    @Override
    public String toString() {
        return super.toString()+ ", tipo de divulagacion=" + this.tipoDiv;
    }
}
