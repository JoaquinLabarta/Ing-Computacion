package entregable.clases;

import java.sql.Connection;
import entregable.vista.PantallaPrincipal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JOptionPane;

public class Transaccion {
    private PantallaPrincipal pantallaPrincipal;

    public Transaccion(PantallaPrincipal pantallaPrincipal) {
        this.pantallaPrincipal = pantallaPrincipal;
    }

    public Transaccion() {
    }

    // Método para comprar un activo (criptomoneda o fiat)
    public void comprarActivo(Connection con, String siglaCompra, String siglaFiat, double cantidad, double cantidadUSD, int idUsuario) {
        // Paso 1: Verificar si el activo existe
        if (!existeActivo(con, siglaCompra)) {
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "El activo " + siglaCompra + " no existe.", "Error", JOptionPane.INFORMATION_MESSAGE);
            System.out.println("El activo " + siglaCompra + " no existe.");
            return;
        }

        // Paso 2: Obtener el precio actual del activo
        double precioActivo = obtenerPrecioActivo(con, siglaCompra);
        if (precioActivo <= 0) {
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "Error al obtener el precio del activo.", "Error", JOptionPane.INFORMATION_MESSAGE);
            System.out.println("Error al obtener el precio del activo.");
            return;
        }

        // Paso 3: Verificar si el usuario tiene suficientes fondos para realizar la compra
        if (!verificarFondosUsuario(con, idUsuario, cantidad, siglaFiat)) {
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "El usuario no tiene suficientes fondos", "Error", JOptionPane.INFORMATION_MESSAGE);
            System.out.println("El usuario no tiene suficientes fondos.");
            return;
        }

        // Paso 4: Calcular el costo total de la compra
        double totalCompra = cantidadUSD / precioActivo;

        // Paso 5: Realizar la transacción (descontar fondos al usuario y registrar la compra del activo)
        try {
            con.setAutoCommit(false);
            descontarFondos(con, idUsuario, cantidad, siglaFiat, totalCompra, siglaCompra);
            insertarTransaccion(con, idUsuario, siglaCompra, siglaFiat, totalCompra, cantidad);
            restarStock(con, totalCompra, siglaCompra);
            // Confirmar la transacción
            con.commit();
            JOptionPane.showMessageDialog(this.pantallaPrincipal, "Compra realizada con éxito.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
            System.out.println("Compra de " + totalCompra + " " + siglaCompra + " realizada con éxito.");

        } catch (SQLException e) {
            try {
                // Si algo falla, revertir cambios
                con.rollback();
            } catch (SQLException ex) {
                System.out.println("Error al revertir la transacción: " + ex.getMessage());
            }
            System.out.println("Error en la transacción: " + e.getMessage());
        } finally {
            try {
                // Restaurar el estado de autocommit
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error al restaurar el autocommit: " + e.getMessage());
            }
        }
    }

    private void restarStock(Connection con, double cantidad, String sigla) {
        String query = "UPDATE Moneda SET stock = stock - ? WHERE sigla = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setDouble(1, cantidad);
            stmt.setString(2, sigla);
            int filasActualizadas = stmt.executeUpdate();
            if (filasActualizadas > 0) {
                System.out.println("Stock actualizado correctamente.");
            } else {
                System.out.println("No se pudo actualizar el stock.");
            }
        } catch (SQLException e) {
            System.out.println("Error al restar el stock: " + e.getMessage());
        }
    }

    // Verifica si el activo existe en la base de datos
    private boolean existeActivo(Connection con, String sigla) {
        String query = "SELECT COUNT(*) FROM Moneda WHERE sigla = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, sigla);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            System.out.println("Error al verificar si el activo existe: " + e.getMessage());
            return false;
        }
    }

    // Obtiene el precio del activo (en dólares)
    private double obtenerPrecioActivo(Connection con, String sigla) {
        String query = "SELECT valor FROM Moneda WHERE sigla = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, sigla);
            var rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("valor");
            }
            return 0;
        } catch (SQLException e) {
            System.out.println("Error al obtener el precio del activo: " + e.getMessage());
            return 0;
        }
    }

    // Verifica si el usuario tiene suficientes fondos para realizar la compra
    private boolean verificarFondosUsuario(Connection con, int idUsuario, double monto, String sigla) {
        String query = "SELECT cantidad FROM Activos WHERE usuario_id = ? AND sigla = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, idUsuario);
            stmt.setString(2, sigla);
            var rs = stmt.executeQuery();
            if (rs.next()) {
                double saldoUsuario = rs.getDouble("cantidad");
                return saldoUsuario >= monto;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error al verificar los fondos del usuario: " + e.getMessage());
            return false;
        }
    }

    
    // Descuenta los fondos del usuario (en caso de compra con fiat)
    private void descontarFondos(Connection con, int usuarioId, double monto, String sigla, double total, String siglaCompra) throws SQLException {
        String verificarQuery = "SELECT cantidad FROM Activos WHERE usuario_id = ? AND sigla = ?";
        String actualizarQuery = "UPDATE Activos SET cantidad = cantidad - ? WHERE usuario_id = ? AND sigla = ?";
        String actualizarQuery2 = "UPDATE Activos SET cantidad = cantidad + ? WHERE usuario_id = ? AND sigla = ?";

        try (PreparedStatement verificarStmt = con.prepareStatement(verificarQuery)) {
            verificarStmt.setInt(1, usuarioId);
            verificarStmt.setString(2, sigla);
            ResultSet rs = verificarStmt.executeQuery();

            if (rs.next()) {
                double cantidadActual = rs.getDouble("cantidad");

                if (cantidadActual >= monto) {
                    try (PreparedStatement actualizarStmt = con.prepareStatement(actualizarQuery); PreparedStatement actualizarStmt2 = con.prepareStatement(actualizarQuery2)) {
                        actualizarStmt.setDouble(1, monto);
                        actualizarStmt.setInt(2, usuarioId);
                        actualizarStmt.setString(3, sigla);
                        int filasActualizadas = actualizarStmt.executeUpdate();
                        actualizarStmt2.setDouble(1, total);
                        actualizarStmt2.setInt(2, usuarioId);
                        actualizarStmt2.setString(3, siglaCompra);
                        int filasActualizadas2 = actualizarStmt2.executeUpdate();

                        if (filasActualizadas > 0 && filasActualizadas2 > 0) {
                            System.out.println("Fondos descontados correctamente.");
                        } else {
                            System.out.println("No se pudo actualizar el registro.");
                        }
                    }
                } else {
                    throw new SQLException("Fondos insuficientes para realizar la transacción.");
                }
            } else {
                throw new SQLException("No se encontró el registro correspondiente en la tabla Activos.");
            }
        }
    }

    // Registra la transacción de compra en la base de datos
    public static boolean insertarTransaccion(Connection con, int usuarioId, String monedaComprada, String monedaPagada, double cantidadComprada, double cantidadPagada) {
        // Generar un resumen de la transacción
        String resumen = String.format(
            "Compra de %.5f %s pagando %.3f %s",
            cantidadComprada, monedaComprada, cantidadPagada, monedaPagada
        );

        // Query para insertar la transacción
        String query = "INSERT INTO Transaccion (resumen, fecha_hora, usuario_id) VALUES (?, datetime('now'), ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, resumen); // Resumen generado
            System.out.println("ID: " + usuarioId);
            pstmt.setInt(2, usuarioId);  // ID del usuario

            int filasInsertadas = pstmt.executeUpdate();
            return filasInsertadas > 0; // Retorna true si la inserción fue exitosa
        } catch (SQLException e) {
            System.out.println("Error al insertar transacción: " + e.getMessage());
            return false;
        }
    }
}
