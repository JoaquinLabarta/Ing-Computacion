package entregable.vista;

import entregable.clases.*;
import entregable.controladores.ControladorPantallaPrincipal;
import java.awt.*;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.util.List;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class PantallaPrincipal extends JFrame {

    private JLabel userLabel;
    private JLabel balanceLabel;
    private JTable tablaActivos;
    private JTable tablaTransacciones;
    private JButton generarActivos;
    private JButton comprarButton;
    private JButton transaccionesButton;
    private JButton cotizacionesButton;
    private JButton exportarButton;
    private JButton logoutButton;
    private Connection con;
    private Usuario usuario;
    
    public PantallaPrincipal(Connection con, String nombre) {
        // Configuración de la ventana
        super("Billetera Virtual - Mis Activos");
        setSize(800, 600); // Tamaño de la ventana
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Panel superior (usuario y logout)
        add(crearPanelSuperior(), BorderLayout.NORTH);

        // Panel central (balance, activos y botones)
        add(crearPanelCentral(con, nombre), BorderLayout.CENTER);
        this.con = con;
        usuario = Usuario.obtenerUsuario(con, nombre);
        ControladorPantallaPrincipal controlador = new ControladorPantallaPrincipal(this, con, usuario.getId());
    }

    // Método para mostrar la ventana y asignar el usuario
    public void mostrar() {
        setVisible(true);
    }

    private JPanel crearPanelSuperior() {
        JPanel topPanel = new JPanel(new BorderLayout());
        userLabel = new JLabel("Usuario:");
        logoutButton = new JButton("Cerrar sesión");

        topPanel.add(userLabel, BorderLayout.WEST);
        topPanel.add(logoutButton, BorderLayout.EAST);

        return topPanel;
    }

    private JPanel crearPanelCentral(Connection con, String nombre) {
            JPanel mainPanel = new JPanel();
            mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
    
            // Obtener balance en ARS y nombre del usuario desde la base de datos
            usuario = Usuario.obtenerUsuario(con, nombre);
            double balanceARS = usuario.getBalanceARS(con, usuario.getId()); 
            userLabel.setText("Usuario logueado: " + usuario.getUser() + "ID: " + usuario.getId());
    
            // Etiqueta de balance
            balanceLabel = new JLabel("Balance (ARS): " + balanceARS, JLabel.CENTER);
            balanceLabel.setFont(new Font("Arial", Font.BOLD, 28));
            balanceLabel.setForeground(new Color(0, 102, 204));
            balanceLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
            mainPanel.add(balanceLabel);
    
            // Espaciado entre balance y tabla
            mainPanel.add(Box.createRigidArea(new Dimension(0, 20)));
    
            // Obtener los activos cripto y fiat
            List<Activo_Cripto> activosCripto = Activo_Cripto.listarActivosCripto(usuario.getId(), con, "sigla");
            List<Activo_Fiat> activosFiat = Activo_Fiat.listarActivosFiat(con, "sigla", usuario.getId());

        // Crear modelo de la tabla
        DefaultTableModel model = new DefaultTableModel();
        model.addColumn("Moneda");
        model.addColumn("Cantidad");

        // Agregar activos cripto a la tabla
        for (Activo_Cripto cripto : activosCripto) {
            model.addRow(new Object[]{cripto.getSigla(), cripto.getCantidad()});
        }

        // Agregar activos fiat a la tabla
        for (Activo_Fiat fiat : activosFiat) {
            model.addRow(new Object[]{fiat.getSigla(), fiat.getCantidad()});
        }

        // Crear la tabla de activos
        tablaActivos = new JTable(model);
        tablaActivos.setFillsViewportHeight(true);
        JScrollPane scrollPane = new JScrollPane(tablaActivos);
        mainPanel.add(scrollPane);

        // Espaciado entre tabla y botones
        mainPanel.add(Box.createRigidArea(new Dimension(0, 20)));

        // Botones
        generarActivos = new JButton("Generar Activos");
        comprarButton = new JButton("Comprar Activos");
        cotizacionesButton = new JButton("Ver Cotizaciones");
        transaccionesButton = new JButton("Actualizar Transacciones");
        exportarButton = new JButton("Exportar como CSV");

        estilizarBoton(generarActivos, new Color(0, 153, 76), Color.WHITE);
        estilizarBoton(comprarButton, new Color(0, 153, 76), Color.WHITE);
        estilizarBoton(cotizacionesButton, new Color(0, 153, 76), Color.WHITE);
        estilizarBoton(transaccionesButton, new Color(0, 153, 76), Color.WHITE);
        estilizarBoton(exportarButton, new Color(255, 153, 51), Color.WHITE);

        // Agregar botones al panel
        mainPanel.add(generarActivos);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 10))); // Espaciado entre botones
        mainPanel.add(comprarButton);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 10))); // Espaciado entre botones
        mainPanel.add(cotizacionesButton);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 10)));
        mainPanel.add(transaccionesButton);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 10)));
        mainPanel.add(exportarButton);

        

        // crear tabla transacciones
        mainPanel.add(Box.createRigidArea(new Dimension(0, 20)));
        tablaTransacciones = new JTable(new DefaultTableModel(new Object[]{"ID usuario", "Resumen", "Fecha/Hora"}, 0));
        JScrollPane transaccionesScrollPane = new JScrollPane(tablaTransacciones);
        mainPanel.add(transaccionesScrollPane);

        return mainPanel;
    }
    

    public JTable getTablaTransacciones() {
        return tablaTransacciones;
    }

    public void setBalance(double balance) {
        balanceLabel.setText("Balance (ARS): " + balance);
    }

    public void addComprarListener(ActionListener listener) {
        comprarButton.addActionListener(listener);
    }

    public void addInsertarActivosListener(ActionListener listener) {
        generarActivos.addActionListener(listener);
    }

    public void addTransaccionesListener(ActionListener listener) {
        transaccionesButton.addActionListener(listener);
    }

    public void addCotizacionesListener(ActionListener listener) {
        cotizacionesButton.addActionListener(listener);
    }

    public void addExportarListener(ActionListener listener) {
        exportarButton.addActionListener(listener);
    }

    public void addLogoutListener(ActionListener listener) {
        logoutButton.addActionListener(listener);
    }
    
    private void estilizarBoton(JButton button, Color background, Color foreground) {
        button.setBackground(background);
        button.setForeground(foreground);
        button.setFocusPainted(false);
        button.setFont(new Font("Arial", Font.BOLD, 14));
        button.setAlignmentX(Component.CENTER_ALIGNMENT); // Centrar botones en el panel
        button.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));
    }

    public void actualizarDatosTabla() {
        try {
            double balanceARS = usuario.getBalanceARS(con, usuario.getId());
            setBalance(balanceARS); // Actualiza el balance mostrado

            // Limpiar el modelo de la tabla
            DefaultTableModel model = (DefaultTableModel) tablaActivos.getModel();
            model.setRowCount(0); // Limpiar filas actuales

            // Obtener activos cripto
            List<Activo_Cripto> activosCripto = Activo_Cripto.listarActivosCripto(usuario.getId(), con, "sigla");
            if (activosCripto == null || activosCripto.isEmpty()) {
                System.out.println("No se encontraron activos cripto.");
            }

            // Agregar activos cripto a la tabla
            for (Activo_Cripto cripto : activosCripto) {
                model.addRow(new Object[]{cripto.getSigla(), cripto.getCantidad()});
            }

            // Obtener activos fiat
            List<Activo_Fiat> activosFiat = Activo_Fiat.listarActivosFiat(con, "sigla", usuario.getId());
            if (activosFiat == null || activosFiat.isEmpty()) {
                System.out.println("No se encontraron activos fiat.");
            }

            // Agregar activos fiat a la tabla
            for (Activo_Fiat fiat : activosFiat) {
                model.addRow(new Object[]{fiat.getSigla(), fiat.getCantidad()});
            }

        } catch (Exception e) {
            // Mostrar mensaje de error
            JOptionPane.showMessageDialog(this, "Error al actualizar la tabla: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();  // Imprimir stack trace para mayor detalle del error
        }
    }
}