package Practica3.Ej4;

public class AreaEmpresa {
    private String identificacion;
    private Integer tardanza;

    public AreaEmpresa(String ide, Integer t){
        this.identificacion = ide;
        this.tardanza = t;
    }

    public String getIdentificacion() {
        return identificacion;
    }
    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
    public Integer getTardanza() {
        return tardanza;
    }
    public void setTardanza(Integer tardanza) {
        this.tardanza = tardanza;
    }
}
