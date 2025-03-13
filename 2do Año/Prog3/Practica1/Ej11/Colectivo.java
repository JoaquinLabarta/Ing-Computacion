package Ej11;

import java.util.LinkedList;

public class Colectivo {
    private String nombre;
    private int num;
    private LinkedList<Integer> listParadas;

    public Colectivo(){

    }

    public Colectivo(String nombre, int num){
        this.nombre = nombre;
        this.num = num;
        this.listParadas = new LinkedList<>();
    }

    public Colectivo(String nombre, int num, LinkedList<Integer> listParadas){
        this.nombre = nombre;
        this.num = num;
        this.listParadas = new LinkedList<>();
        setListParadas(listParadas);
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }

    public LinkedList<Integer> getListParadas() {
        return listParadas;
    }

    public void setListParadas(LinkedList<Integer> listParadas) {
        this.listParadas = listParadas;
    }
}

