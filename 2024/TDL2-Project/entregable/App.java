package entregable;

import entregable.clases.creacionDeTablas;
import entregable.controladores.LoginController;
import entregable.vista.PantallaLogin;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class App {
    public static void main(String[] args) {
        String url = "jdbc:sqlite:projectDatabase.db";

         try {
             // Conexión a la base de datos
                Connection con = DriverManager.getConnection(url);
                System.out.println("Conexión exitosa a la base de datos.");
        
             // Crear tablas (si no existen)
                creacionDeTablas.crearTablaMoneda(con);
                creacionDeTablas.crearTablaActivos(con);
                creacionDeTablas.crearTablaTransaccion(con);
                creacionDeTablas.crearTablaUsuario(con);
                creacionDeTablas.insertarMonedas(con);

             // Inicializar la interfaz gráfica
                PantallaLogin pantallaLogin = new PantallaLogin();
                LoginController loginController = new LoginController(pantallaLogin, con);
        
                pantallaLogin.setVisible(true); // Mostrar la interfaz gráfica

        } catch (SQLException e) {
             System.out.println("Error al conectar con la base de datos: " + e.getMessage());
        } 
    } 
}