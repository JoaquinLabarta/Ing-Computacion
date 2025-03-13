package entregable.controladores;

import entregable.clases.Usuario;
import entregable.vista.PantallaLogin;
import entregable.vista.PantallaPrincipal;
import entregable.vista.PantallaRegistro;
import java.sql.Connection;
import javax.swing.*;

public class LoginController {
    private final PantallaLogin pantallaLogin;
    private final Connection con;

    public LoginController(PantallaLogin pantallaLogin, Connection con) {
        this.pantallaLogin = pantallaLogin;
        this.con = con;

        // Vincula los botones con los métodos del controlador
        this.pantallaLogin.agregarAccionLogin(temp -> iniciarSesion());
        this.pantallaLogin.agregarAccionRegistrar(temp -> abrirPantallaRegistro());
    }

    private void iniciarSesion() {
    String username = pantallaLogin.getUsuario();
    String password = pantallaLogin.getPassword();

    Usuario usuario = Usuario.obtenerUsuario(con, username);

    if (usuario != null) {
        System.out.println("Usuario encontrado: " + usuario.getUser() + " | ID: " + usuario.getId());
    } else {
        System.out.println("Usuario no encontrado.");
    }

    if (usuario != null && usuario.getPassword().equals(password) && usuario.getUser().equals(username)) {
        JOptionPane.showMessageDialog(pantallaLogin, "Inicio de sesión exitoso.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
        pantallaLogin.dispose();
        PantallaPrincipal pantallaPrincipal = new PantallaPrincipal(con, usuario.getUser());
        pantallaPrincipal.mostrar();
    } else {
        JOptionPane.showMessageDialog(pantallaLogin, "Usuario o contraseña incorrectos.", "Error", JOptionPane.ERROR_MESSAGE);
    }
}


    private void abrirPantallaRegistro() {
        pantallaLogin.dispose(); // Cierra la ventana de login

        // Abre la ventana de registro
        PantallaRegistro pantallaRegistro = new PantallaRegistro(con); // Asegúrate de pasar la conexión aquí
        pantallaRegistro.setVisible(true);
    }
}