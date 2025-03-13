package Ej3;

import java.util.Random;

public class Test {
    public static void main (String[] args){
        Estudiante[] vEstudiantes = new Estudiante[2];
        Profesor[] vProfesors = new Profesor[3];
        System.out.println("------------------- Seccion Estudiantes -------------------");
        for (int i=0; i<vEstudiantes.length; i++) {
            vEstudiantes[i] = new Estudiante();
            vEstudiantes[i].setNombre(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vEstudiantes[i].setApellido(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vEstudiantes[i].setComision(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vEstudiantes[i].setEmail(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vEstudiantes[i].setDireccion(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
        }

        for (Estudiante e : vEstudiantes) {
            System.out.println(e.tusDatos());
        }

        System.out.println("------------------- Seccion Profesor -------------------");
        for (int i=0; i<vProfesors.length; i++) {
            vProfesors[i] = new Profesor();
            vProfesors[i].setNombre(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vProfesors[i].setApellido(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vProfesors[i].setEmail(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vProfesors[i].setCatedra(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
            vProfesors[i].setFacultad(givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect());
        }

        for (Profesor p : vProfesors) {
            System.out.println(p.tusDatos());
        }
    }

    public static String givenUsingJava8_whenGeneratingRandomAlphabeticString_thenCorrect() {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 5;
        Random random = new Random();

        String generatedString = random.ints(leftLimit, rightLimit + 1)
        .limit(targetStringLength)
        .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
        .toString();

        return generatedString;
    }
}
