/* Escriba un método que realice las siguientes acciones:
■ cree una lista que contenga 3 estudiantes
■ genere una nueva lista que sea una copia de la lista del inciso i
■ imprima el contenido de la lista original y el contenido de la nueva lista
■ modifique algún dato de los estudiantes
■ vuelva a imprimir el contenido de la lista original y el contenido de la nueva lista.
¿Qué conclusiones obtiene a partir de lo realizado?
■ ¿Cuántas formas de copiar una lista existen? ¿Qué diferencias existen entre
ellas? */

package Ej7.Ej7d;

import java.util.ArrayList;
import java.util.List;

public class Estudiante {
    private List<String> listaOriginal = new ArrayList<>();
    private List<String> listaCopia = new ArrayList<>();

    public Estudiante() {
        listaOriginal.add("Estudiante 1");
        listaOriginal.add("Estudiante 2");
        listaOriginal.add("Estudiante 3");

        listaCopia.addAll(listaOriginal);
    }

    public void agregarEstudiante(String nombre){
        if (!listaOriginal.contains(nombre)) {
            System.out.println("Se agrego a "+nombre);
            listaOriginal.add(nombre);
        } else System.out.println("No se pudo agregar a "+nombre);
    }

    public void modificar(int indice, String nuevoNombre) {
        listaOriginal.set(indice, nuevoNombre);
    }

    public void imprimirListas() {
        System.out.println("Lista Original:");
        for (String estudiante : listaOriginal) {
            System.out.println(estudiante);
        }

        System.out.println("Lista Copia:");
        for (String estudiante : listaCopia) {
            System.out.println(estudiante);
        }
    }
}
