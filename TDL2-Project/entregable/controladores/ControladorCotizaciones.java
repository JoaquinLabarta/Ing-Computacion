package entregable.controladores;

import entregable.modelo.ConsultarPrecioCripto;
import entregable.vista.PantallaCotizaciones;

import javax.swing.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

public class ControladorCotizaciones {
    private PantallaCotizaciones vista;
    private int usuarioId;
    

    public ControladorCotizaciones(PantallaCotizaciones vista, int usuarioId) {
        this.vista = vista;
        this.usuarioId = usuarioId;
        inicializar();
    }

    private void inicializar() {
        vista.setUsuario(usuarioId);
        vista.addVolverListener(e -> vista.dispose());
        cargarCotizacionesIniciales();
        //iniciarActualizacionCotizaciones();
    }

    private void cargarCotizacionesIniciales() {
        try {
            Map<String, Double> datos = ConsultarPrecioCripto.obtenerPrecios();
            actualizarBaseDeDatos(datos);
            vista.cargarCriptos(datos);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(vista, "Error al cargar cotizaciones iniciales: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void actualizarBaseDeDatos(Map<String, Double> precios) {
        String query = "UPDATE Moneda SET valor = ? WHERE nombre = ?";
        String url = "jdbc:sqlite:projectDatabase.db"; 
        try (Connection conexion = DriverManager.getConnection(url);
            PreparedStatement stmt = conexion.prepareStatement(query)) {
            for (Map.Entry<String, Double> entry : precios.entrySet()) {
                stmt.setDouble(1, entry.getValue()); // Establece el precio
                stmt.setString(2, entry.getKey());   // Establece el nombre de la moneda
                stmt.executeUpdate();               // Ejecuta la actualización
            }
            System.out.println("Precios actualizados en la base de datos.");
        } catch (SQLException e) {
            System.err.println("Error al actualizar los precios en la base de datos: " + e.getMessage());
        }
    }


/*
    private void iniciarActualizacionCotizaciones() {
        new Timer(5000, e -> actualizarCotizaciones()).start();
    }

    private void actualizarCotizaciones() {
        new Thread(() -> {
            try {
                Map<String, Double> precios = ConsultarPrecioCripto.obtenerPrecios();
                SwingUtilities.invokeLater(() -> precios.forEach(vista::actualizarPrecio));
            } catch (Exception e) {
                SwingUtilities.invokeLater(() -> JOptionPane.showMessageDialog(vista,
                        "Error al actualizar cotizaciones: " + e.getMessage(),
                        "Error", JOptionPane.ERROR_MESSAGE));
            }
        }).start();
    }*/
}