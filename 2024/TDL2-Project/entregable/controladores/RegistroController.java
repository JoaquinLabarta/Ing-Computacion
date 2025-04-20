package entregable.controladores;

import entregable.clases.Usuario;
import entregable.vista.*; // Importamos la nueva excepción
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.*;

public class RegistroController {
    private final PantallaRegistro pantallaRegistro;
    private final Connection con; // Conexión a la base de datos

    // Modificamos el constructor para aceptar la conexión
    public RegistroController(PantallaRegistro pantallaRegistro, Connection con) {
        this.pantallaRegistro = pantallaRegistro;
        this.con = con;
        
        // Asocia los oyentes (listeners) de los botones con métodos del controlador
        this.pantallaRegistro.agregarAccionRegistrar(e -> registrarUsuario());
        this.pantallaRegistro.agregarAccionVolver(e -> volverALogin());
    }

    private void registrarUsuario() {
        // Obtiene los datos de los campos
        String email = pantallaRegistro.getEmail();
        String username = pantallaRegistro.getUsuario();
        String password = pantallaRegistro.getPassword();
        boolean terminosAceptados = pantallaRegistro.isTerminosAceptados();
    
        try {
            if (!validarDatos(email, username, password, terminosAceptados)) {
                return;
            }
    
            if (usuarioExiste(username, email)) {
                JOptionPane.showMessageDialog(pantallaRegistro, "El usuario o correo ya existe. Intente con otros datos.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
    
            // Crea un nuevo usuario e inserta en la base de datos
            Usuario.insertarUsuario(con, username, email, password, terminosAceptados);
            JOptionPane.showMessageDialog(pantallaRegistro, "Usuario registrado con éxito. Por favor, inicie sesión.", "Registro Exitoso", JOptionPane.INFORMATION_MESSAGE);
            
            // Redirige al login
            volverALogin();
        } catch (RegistroException e) {
            JOptionPane.showMessageDialog(pantallaRegistro, e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void volverALogin() {
        pantallaRegistro.dispose(); // Cierra la ventana de registro

        // Crea una nueva instancia de PantallaLogin con la conexión actual
        PantallaLogin pantallaLogin = new PantallaLogin();
        LoginController loginController = new LoginController(pantallaLogin, con);

        pantallaLogin.setVisible(true); // Muestra la ventana de inicio de sesión
    }


    private boolean validarDatos(String email, String username, String password, boolean terminosAceptados) throws RegistroException {
        if (email.isEmpty() || username.isEmpty() || password.isEmpty()) {
            throw new RegistroException("Complete todos los campos para registrarse.");
        }

        // Validar correo electrónico
        if (!email.matches("^[\\w._%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            throw new RegistroException("El correo electrónico no es válido.");
        }

        if (!terminosAceptados) {
            throw new RegistroException("Debe aceptar los términos y condiciones para continuar.");
        }

        return true;
    }

    private boolean usuarioExiste(String username, String email) throws RegistroException {
        // Lógica para comprobar si el usuario o el correo ya existen en la base de datos
        Usuario usuarioExistente = Usuario.obtenerUsuario(con, username);
        if (usuarioExistente != null) {
            return true; // Si el usuario ya existe
        }
        // Si no existe el usuario, también comprobar el correo
        String queryEmail = "SELECT * FROM Usuario WHERE email = ?";
        try (PreparedStatement stmt = con.prepareStatement(queryEmail)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return true; // Si el correo ya está registrado
            }
        } catch (SQLException e) {
            throw new RegistroException("Error al comprobar correo: " + e.getMessage());
        }
        return false;
    }
}