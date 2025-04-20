package entregable.controladores;

import entregable.clases.*;
import entregable.vista.*;
import java.io.*;
import java.sql.*;
import java.util.List;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class ControladorPantallaPrincipal {

    private PantallaPrincipal pantallaPrincipal;
    private Connection conexion;
    private int usuarioId;

    public ControladorPantallaPrincipal(PantallaPrincipal pantallaPrincipal, Connection conexion, int usuarioId) {
        this.pantallaPrincipal = pantallaPrincipal;
        this.conexion = conexion;
        this.usuarioId = usuarioId;

        // Asociar eventos de botones con métodos del controlador
        this.pantallaPrincipal.addCotizacionesListener(e -> mostrarCotizaciones());
        this.pantallaPrincipal.addTransaccionesListener(e -> mostrarTransacciones());
        this.pantallaPrincipal.addComprarListener(e -> comprarActivo());
        this.pantallaPrincipal.addExportarListener(e -> exportarActivos());
        this.pantallaPrincipal.addInsertarActivosListener(e -> insertarActivosPorUsuario());
        this.pantallaPrincipal.addLogoutListener(e -> cerrarSesion());
    }
    private void mostrarCotizaciones() {
        PantallaCotizaciones pantallaCotizaciones = new PantallaCotizaciones();
        ControladorCotizaciones controladorCotizaciones = new ControladorCotizaciones(pantallaCotizaciones, usuarioId);
        pantallaCotizaciones.setVisible(true);
    }

    // Mostrar Transacciones
    public void mostrarTransacciones() {
        // Obtener el modelo de la tabla
        DefaultTableModel model = (DefaultTableModel) this.pantallaPrincipal.getTablaTransacciones().getModel();
        model.setRowCount(0); // Limpiar la tabla

        // Consulta SQL para obtener las transacciones del usuario
        String query = "SELECT resumen, fecha_hora FROM Transaccion WHERE usuario_id = ? ORDER BY fecha_hora DESC";

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setInt(1, usuarioId);
            ResultSet rs = stmt.executeQuery();

            // Iterar sobre el resultado y agregar las filas a la tabla
            while (rs.next()) {
                String resumen = rs.getString("resumen");
                String fechaHora = rs.getString("fecha_hora");

                model.addRow(new Object[]{usuarioId, resumen, fechaHora});
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(pantallaPrincipal, "Error al cargar las transacciones: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Método para permitir la compra de activos (puedes añadir la lógica aquí)
    private void comprarActivo() {
        System.out.println("Comprar activo");
        try {
            Criptomoneda criptomoneda = new Criptomoneda();
            List<Moneda> lista = criptomoneda.listarMonedas(conexion, "sigla");

            if (lista.isEmpty()) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "No hay criptomonedas disponibles en este momento.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Mostrar las criptomonedas disponibles
            StringBuilder cryptosDisponibles = new StringBuilder("Criptomonedas disponibles:\n");
            for (Moneda moneda : lista) {
                cryptosDisponibles.append("Sigla: ").append(moneda.getSigla()).append("\n");
            }
            String siglaCompra = JOptionPane.showInputDialog(pantallaPrincipal, cryptosDisponibles + "\nIngrese la sigla de la criptomoneda que deseas comprar:");
            if (siglaCompra == null || siglaCompra.trim().isEmpty()) {
                return;
            }
            siglaCompra = siglaCompra.trim().toUpperCase();

            if (!criptomoneda.existeMoneda(conexion, siglaCompra)) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "La criptomoneda ingresada no existe.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Chequear stock de la criptomoneda
            double stock = criptomoneda.obtenerStock(conexion, siglaCompra);
            if (stock <= 0) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "No tienes stock de la criptomoneda seleccionada.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Listar las monedas fiat disponibles en la billetera del usuario
            List<Activo_Fiat> listaFiat = Activo_Fiat.listarActivosFiat(conexion, "sigla", usuarioId);
            if (listaFiat.isEmpty()) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "No tienes monedas fiat disponibles.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Mostrar monedas fiat disponibles
            StringBuilder fiatDisponibles = new StringBuilder("Monedas fiat disponibles:\n");
            for (Activo_Fiat activo : listaFiat) {
                fiatDisponibles.append("Sigla: ").append(activo.getSigla()).append(", Cantidad: ").append(activo.getCantidad()).append("\n");
            }
            String siglaFiat = JOptionPane.showInputDialog(pantallaPrincipal, fiatDisponibles + "\nIngrese la moneda fiat que deseas usar:");
            if (siglaFiat == null || siglaFiat.trim().isEmpty()) {
                return;
            }
            siglaFiat = siglaFiat.trim().toUpperCase();

            if (!Activo_Fiat.existeActivo(conexion, siglaFiat, usuarioId)) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "El activo ingresado no existe en tu billetera.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Solicitar la cantidad de fiat que desea utilizar
            String cantidadStr = JOptionPane.showInputDialog(pantallaPrincipal, "Ingresa la cantidad de " + siglaFiat + " que deseas usar:");
            if (cantidadStr == null || cantidadStr.isEmpty()) {
                return;
            }

            double cantidad = Double.parseDouble(cantidadStr);
            if (cantidad <= 0) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "La cantidad debe ser mayor a 0.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Calcular el precio actual de la moneda fiat
            double precioUSD = Fiat.getPrecioActual(conexion, siglaFiat);
            if (precioUSD <= 0) {
                JOptionPane.showMessageDialog(pantallaPrincipal, "Error al obtener el precio de la moneda fiat.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Convertir la cantidad de fiat a USD
            double cantidadUSD = cantidad/precioUSD;

            // Realizar la transacción
            Transaccion transaccion = new Transaccion(this.pantallaPrincipal);
            transaccion.comprarActivo(conexion, siglaCompra, siglaFiat, cantidad, cantidadUSD, usuarioId);
            pantallaPrincipal.actualizarDatosTabla();

        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(pantallaPrincipal, "Cantidad inválida: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(pantallaPrincipal, "Error al realizar la compra: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void exportarActivos() {
        List<Activo_Cripto> activosCripto = Activo_Cripto.listarActivosCripto(usuarioId, conexion, "sigla");
        List<Activo_Fiat> activosFiat = Activo_Fiat.listarActivosFiat(conexion, "sigla", usuarioId);

        // Nombre del archivo CSV
        String archivo = "activos_usuario_" + usuarioId + ".csv";
        
        try (FileWriter writer = new FileWriter(archivo)) {
            // Escribir el encabezado del archivo CSV
            writer.append("Moneda,Cantidad\n");

            // Escribir activos cripto
            for (Activo_Cripto cripto : activosCripto) {
                writer.append(cripto.getSigla())
                      .append(",")
                      .append(String.valueOf(cripto.getCantidad()))
                      .append("\n");
            }

            // Escribir activos fiat
            for (Activo_Fiat fiat : activosFiat) {
                writer.append(fiat.getSigla())
                      .append(",")
                      .append(String.valueOf(fiat.getCantidad()))
                      .append("\n");
            }

            // Informar al usuario que el archivo se ha creado
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "Archivo CSV exportado con éxito.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException e) {
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "Error al exportar el archivo CSV: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void insertarActivosPorUsuario() {
        String query = """
            INSERT INTO Activos (sigla, cantidad, tipo, usuario_id) VALUES
            ('BTC', 0.2, 'Criptomoneda', ?),
            ('ETH', 1.10, 'Criptomoneda', ?),
            ('USD', 500.650, 'Fiat', ?),
            ('ARS', 100000.250, 'Fiat', ?)
            """;
        try (var stmt = conexion.prepareStatement(query)) {
            // Establece el usuario_id en todas las posiciones correspondientes
            for (int i = 1; i <= 4; i++) {
                stmt.setInt(i, usuarioId);
            }

            int filasAfectadas = stmt.executeUpdate();
            System.out.println("Filas afectadas: " + filasAfectadas);

            // Llama a actualizarDatosTabla después de insertar los datos
            this.pantallaPrincipal.actualizarDatosTabla();
        } catch (SQLException e) {
            System.out.println("Error al insertar activos: " + e.getMessage());
        }
    }

    private void cerrarSesion() {
        // Cerrar la conexión a la base de datos
        try {
            conexion.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión: " + e.getMessage());
        }

        pantallaPrincipal.dispose(); // Cierra la ventana de registro

        // Reestablecer conexion
        String url = "jdbc:sqlite:projectDatabase.db";

         try {
             // Conexión a la base de datos
                Connection con = DriverManager.getConnection(url);
                System.out.println("Conexión exitosa a la base de datos.");

             // Inicializar la interfaz gráfica
                PantallaLogin pantallaLogin = new PantallaLogin();
                LoginController loginController = new LoginController(pantallaLogin, con);
        
                pantallaLogin.setVisible(true); // Mostrar la interfaz gráfica

        } catch (SQLException e) {
             System.out.println("Error al conectar con la base de datos: " + e.getMessage());
        } 
    }
}