package entregable.vista;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.Map;

public class PantallaCotizaciones extends JFrame {
    private JPanel panelCriptos;
    private JButton btnVolver;
    private JLabel lblUsuario;
    private Map<String, JLabel> etiquetasPrecios;

    public PantallaCotizaciones() {
        etiquetasPrecios = new HashMap<>();
        setTitle("Billetera Virtual - Cotizaciones");
        setSize(700, 450);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);
        setLayout(new BorderLayout());

        JPanel panelSuperior = new JPanel(new BorderLayout());
        panelSuperior.setBackground(Color.DARK_GRAY);

        JPanel panelUsuario = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        panelUsuario.setBackground(Color.DARK_GRAY);
        lblUsuario = new JLabel();
        lblUsuario.setFont(new Font("Arial", Font.BOLD, 14));
        lblUsuario.setForeground(Color.WHITE);
        panelUsuario.add(lblUsuario);
        panelSuperior.add(panelUsuario, BorderLayout.EAST);
        add(panelSuperior, BorderLayout.NORTH);

        panelCriptos = new JPanel();
        panelCriptos.setLayout(new BoxLayout(panelCriptos, BoxLayout.Y_AXIS));
        panelCriptos.setBackground(Color.WHITE);
        JScrollPane scrollPane = new JScrollPane(panelCriptos);
        scrollPane.setBorder(BorderFactory.createEmptyBorder());
        add(scrollPane, BorderLayout.CENTER);

        JPanel panelInferior = new JPanel(new FlowLayout(FlowLayout.CENTER));
        btnVolver = new JButton("Volver");
        btnVolver.setFont(new Font("Arial", Font.BOLD, 14));
        btnVolver.setBackground(new Color(51, 153, 255));
        btnVolver.setForeground(Color.WHITE);
        panelInferior.add(btnVolver);
        add(panelInferior, BorderLayout.SOUTH);
    }

    public void cargarCriptos(Map<String, Double> datosCriptos) {
        panelCriptos.removeAll();
        etiquetasPrecios.clear();

        datosCriptos.forEach((nombre, precio) -> {
            JPanel panelCripto = new JPanel(new GridBagLayout());
            panelCripto.setBackground(Color.WHITE);
            panelCripto.setBorder(BorderFactory.createMatteBorder(0, 0, 1, 0, Color.LIGHT_GRAY));

            GridBagConstraints gbc = new GridBagConstraints();
            gbc.insets = new Insets(5, 10, 5, 10);
            gbc.fill = GridBagConstraints.HORIZONTAL;

            gbc.gridx = 0;
            gbc.weightx = 0.5;
            gbc.anchor = GridBagConstraints.WEST;
            JLabel lblCripto = new JLabel(nombre);
            lblCripto.setFont(new Font("Arial", Font.BOLD, 14));
            panelCripto.add(lblCripto, gbc);

            gbc.gridx = 1;
            gbc.weightx = 0.5;
            gbc.anchor = GridBagConstraints.CENTER;
            JLabel lblPrecio = new JLabel(String.format("$%.2f", precio));
            lblPrecio.setFont(new Font("Arial", Font.PLAIN, 14));
            panelCripto.add(lblPrecio, gbc);

            etiquetasPrecios.put(nombre, lblPrecio);
            panelCriptos.add(panelCripto);
        });

        panelCriptos.revalidate();
        panelCriptos.repaint();
    }

    public void actualizarPrecio(String nombreCripto, double precio) {
        if (etiquetasPrecios.containsKey(nombreCripto)) {
            etiquetasPrecios.get(nombreCripto).setText(String.format("$%.2f", precio));
        }
    }

    public void setUsuario(int usuarioId) {
        lblUsuario.setText("Usuario: " + usuarioId);
    }

    public void addVolverListener(ActionListener listener) {
        btnVolver.addActionListener(listener);
    }
}
