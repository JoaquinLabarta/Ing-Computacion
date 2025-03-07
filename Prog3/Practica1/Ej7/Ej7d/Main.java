package Ej7.Ej7d;

public class Main {
    public static void main(String[] args) {
        Estudiante e = new Estudiante();
        e.imprimirListas();
        e.modificar(2,"Estudiante 4");
        e.imprimirListas();
        e.agregarEstudiante("Estudiante 5");
        e.imprimirListas();
    }
}
