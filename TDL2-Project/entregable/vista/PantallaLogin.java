package entregable.vista;

import java.awt.*;
import java.awt.event.ActionListener;
import javax.swing.*;

public class PantallaLogin extends JFrame {
    private JTextField txtUsuario;
    private JPasswordField txtPassword;
    private JButton btnLogin;
    private JButton btnRegistro;

    public PantallaLogin() {
        // Configuración de la ventana
        setTitle("Inicio de Sesión");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Estilo general
        UIManager.put("Label.font", new Font("Arial", Font.PLAIN, 14));
        UIManager.put("Button.font", new Font("Arial", Font.BOLD, 14));

        // Configuración del panel principal
        JPanel panelPrincipal = new JPanel();
        panelPrincipal.setLayout(new BoxLayout(panelPrincipal, BoxLayout.Y_AXIS));
        panelPrincipal.setBorder(BorderFactory.createEmptyBorder(20, 40, 20, 40));
        panelPrincipal.setBackground(new Color(245, 245, 245)); // Fondo suave

        // Título de la página
        JLabel lblTitulo = new JLabel("Inicio de Sesión");
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 20));
        lblTitulo.setAlignmentX(Component.CENTER_ALIGNMENT);
        lblTitulo.setForeground(new Color(60, 60, 60));

        // Configuración de los componentes
        txtUsuario = crearCampoTexto();
        txtPassword = new JPasswordField(20);
        txtPassword.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        btnLogin = crearBoton("Iniciar Sesión", new Color(0, 123, 255));
        btnRegistro = crearBoton("Registrarse", new Color(40, 167, 69));

        // Agregar componentes al panel
        panelPrincipal.add(lblTitulo);
        panelPrincipal.add(Box.createVerticalStrut(20));
        panelPrincipal.add(crearFila("Usuario:", txtUsuario));
        panelPrincipal.add(crearFila("Contraseña:", txtPassword));
        panelPrincipal.add(Box.createVerticalStrut(20));

        // Panel de botones
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 0));
        panelBotones.setBackground(new Color(245, 245, 245));
        panelBotones.add(btnLogin);
        panelBotones.add(btnRegistro);
        panelPrincipal.add(panelBotones);

        // Agregar el panel principal a la ventana
        add(panelPrincipal);
    }

    // Método para crear un campo de texto estilizado
    private JTextField crearCampoTexto() {
        JTextField campo = new JTextField(20);
        campo.setFont(new Font("Arial", Font.PLAIN, 14));
        campo.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(200, 200, 200)),
                BorderFactory.createEmptyBorder(5, 5, 5, 5)));
        return campo;
    }

    // Método para crear un botón estilizado
    private JButton crearBoton(String texto, Color color) {
        JButton boton = new JButton(texto);
        boton.setFocusPainted(false);
        boton.setBackground(color);
        boton.setForeground(Color.WHITE);
        boton.setBorder(BorderFactory.createEmptyBorder(15, 40, 15, 40)); // Botón más grande
        boton.setCursor(new Cursor(Cursor.HAND_CURSOR));
        boton.setBorder(BorderFactory.createLineBorder(color.darker()));
        boton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                boton.setBackground(color.brighter());
            }

            public void mouseExited(java.awt.event.MouseEvent evt) {
                boton.setBackground(color);
            }
        });
        return boton;
    }

    // Método para crear una fila con una etiqueta y un campo
    private JPanel crearFila(String etiqueta, JComponent campo) {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBackground(new Color(245, 245, 245));
        JLabel label = new JLabel(etiqueta);
        label.setPreferredSize(new Dimension(100, label.getPreferredSize().height));
        panel.add(label, BorderLayout.WEST);
        panel.add(campo, BorderLayout.CENTER);
        return panel;
    }

    // Métodos para obtener los valores de los campos de texto
    public String getUsuario() {
        return txtUsuario.getText();
    }

    public String getPassword() {
        return new String(txtPassword.getPassword());
    }

    // Métodos para agregar acciones a los botones
    public void agregarAccionLogin(ActionListener listener) {
        btnLogin.addActionListener(listener);
    }

    public void agregarAccionRegistrar(ActionListener listener) {
        btnRegistro.addActionListener(listener);
    }
}


