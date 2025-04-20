package entregable.vista;

import entregable.controladores.RegistroController;
import java.awt.*;
import java.awt.event.ActionListener;
import java.sql.Connection;
import javax.swing.*;

public class PantallaRegistro extends JFrame {
    private JTextField txtUsuario;
    private JPasswordField txtPassword;
    private JTextField txtEmail;
    private JCheckBox chkTerminos;
    private JButton btnRegistrar;
    private JButton btnVolver;

    private final Connection connection; // Añade esto para mantener la conexión

    public PantallaRegistro(Connection connection) { // Constructor que recibe la conexión
        this.connection = connection; // Inicializa la conexión

        // Configuración de la ventana
        setTitle("Registro");
        setSize(500, 600);
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
        JLabel lblTitulo = new JLabel("Registro de Usuario");
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 20));
        lblTitulo.setAlignmentX(Component.CENTER_ALIGNMENT);
        lblTitulo.setForeground(new Color(60, 60, 60));

        // Configuración de los componentes
        txtEmail = crearCampoTexto();
        txtUsuario = crearCampoTexto();
        txtPassword = new JPasswordField(20);
        txtPassword.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        chkTerminos = new JCheckBox("Acepto los términos y condiciones");
        chkTerminos.setBackground(new Color(245, 245, 245));
        chkTerminos.setFont(new Font("Arial", Font.PLAIN, 12));

        btnRegistrar = crearBoton("Registrar", new Color(0, 123, 255));
        btnVolver = crearBoton("Volver", new Color(220, 53, 69));
        
        // Agregar componentes al panel
        panelPrincipal.add(lblTitulo);
        panelPrincipal.add(Box.createVerticalStrut(20));
        panelPrincipal.add(crearFila("Email:", txtEmail));
        panelPrincipal.add(crearFila("Usuario:", txtUsuario));
        panelPrincipal.add(crearFila("Contraseña:", txtPassword));
        panelPrincipal.add(Box.createVerticalStrut(10));
        panelPrincipal.add(chkTerminos);
        panelPrincipal.add(Box.createVerticalStrut(20));

        // Panel de botones
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 0));
        panelBotones.setBackground(new Color(245, 245, 245));
        panelBotones.add(btnVolver);
        panelBotones.add(btnRegistrar);
        panelPrincipal.add(panelBotones);

        // Agregar el panel principal a la ventana
        add(panelPrincipal);
        RegistroController controller = new RegistroController(this, connection); // Crea el controlador
    }

    // agregar listeners a los botones
    public void agregarAccionRegistrar(ActionListener listener) {
        btnRegistrar.addActionListener(listener);
    }

    public void agregarAccionVolver(ActionListener listener) {
        btnVolver.addActionListener(listener);
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
    public String getEmail() {
        return txtEmail.getText();
    }

    public String getUsuario() {
        return txtUsuario.getText();
    }

    public String getPassword() {
        return new String(txtPassword.getPassword());
    }

    public boolean isTerminosAceptados() {
        return chkTerminos.isSelected();
    }
}