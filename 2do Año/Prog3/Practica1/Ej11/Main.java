package Ej11;

public class Main {

    public static void main(String[] args) {
        // Crear un colectivo
        Colectivo colectivo1 = new Colectivo("Linea 1", 101);

        // Agregar algunas paradas al colectivo
        colectivo1.getListParadas().add(1);
        colectivo1.getListParadas().add(2);
        colectivo1.getListParadas().add(3);

        // Mostrar información del colectivo
        System.out.println("Nombre del colectivo: " + colectivo1.getNombre());
        System.out.println("Número del colectivo: " + colectivo1.getNum());
        System.out.println("Paradas del colectivo:");
        for (Integer parada : colectivo1.getListParadas()) {
            System.out.println("- Parada " + parada);
        }

        // Modificar el nombre del colectivo
        colectivo1.setNombre("Linea 2");

        // Mostrar información actualizada del colectivo
        System.out.println("\nNombre del colectivo modificado: " + colectivo1.getNombre());
    }
}
