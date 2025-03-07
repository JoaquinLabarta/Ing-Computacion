package entregable.clases;

import entregable.comparadores.ComparadorCantidadActivosFiat;
import entregable.comparadores.ComparadorSiglaActivosFiat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Activo_Fiat {

    public Activo_Fiat(String sigla, double cantidad, int idUsuario) {
        this.sigla = sigla;
        this.cantidad = cantidad;
        this.idUsuario = idUsuario;
    }

    public Activo_Fiat() {
    }

    public static boolean existeActivo(Connection con, String sigla, int idUsuario) {
        String query = "SELECT COUNT(*) FROM Activos WHERE sigla = ? AND usuario_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, sigla);
            pstmt.setInt(2, idUsuario);
            ResultSet rs = pstmt.executeQuery();
            return rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.out.println("Error al verificar si el activo existe: " + e.getMessage());
            return false;
        }
    }

    public static void agregarFiat(String sigla, double cantidad, Connection con, int usuarioId) {
        String verificarQuery = "SELECT cantidad FROM Activos WHERE sigla = ? and tipo = 'Fiat' and usuario_id = ?";
        String actualizarQuery = "UPDATE Activos SET cantidad = cantidad + ? WHERE sigla = ? and tipo = 'Fiat' and usuario_id = ?";
        String insertarQuery = "INSERT INTO Activos (sigla, cantidad, tipo, usuario_id) VALUES (?, ?, ?, ?)";

        try {
            try (PreparedStatement verificarStmt = con.prepareStatement(verificarQuery)) {
                verificarStmt.setString(1, sigla);
                verificarStmt.setInt(2, usuarioId);
                ResultSet rs = verificarStmt.executeQuery();

                if (rs.next()) {
                    try (PreparedStatement actualizarStmt = con.prepareStatement(actualizarQuery)) {
                        actualizarStmt.setDouble(1, cantidad);
                        actualizarStmt.setString(2, sigla);
                        actualizarStmt.setInt(3, usuarioId);
                        int filasActualizadas = actualizarStmt.executeUpdate();
                        if (filasActualizadas > 0) {
                            System.out.println("Cantidad actualizada: " + cantidad + " " + sigla);
                        } else {
                            System.out.println("No se pudo actualizar la cantidad.");
                        }
                    }
                } else {
                    try (PreparedStatement insertarStmt = con.prepareStatement(insertarQuery)) {
                        insertarStmt.setString(1, sigla);
                        insertarStmt.setDouble(2, cantidad);
                        insertarStmt.setString(3, "Fiat");
                        insertarStmt.setInt(4, usuarioId);
                        insertarStmt.executeUpdate();
                        System.out.println("Fiat agregada: " + cantidad + " " + sigla);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al agregar la Fiat: " + e.getMessage());
        }
    }

    public static List<Activo_Fiat> listarActivosFiat(Connection con, String ordenarPor, int idUsuario) {
        List<Activo_Fiat> fiats = new ArrayList<>();
        String query = "SELECT sigla, cantidad FROM Activos WHERE tipo = 'Fiat' AND usuario_id = ?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, idUsuario);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String sigla = rs.getString("sigla");
                double cantidadF = rs.getDouble("cantidad");
                Activo_Fiat fiat = new Activo_Fiat(sigla, cantidadF, idUsuario);
                fiats.add(fiat);
            }

            if (ordenarPor.equalsIgnoreCase("sigla")) {
                fiats.sort(new ComparadorSiglaActivosFiat());
            } else if (ordenarPor.equalsIgnoreCase("cantidad")) {
                fiats.sort(new ComparadorCantidadActivosFiat().reversed());
            } else {
                System.out.println("Criterio de ordenamiento no válido. Se ordenará por cantidad por defecto.");
                fiats.sort(new ComparadorCantidadActivosFiat().reversed());
            }

            return fiats;
        } catch (SQLException e) {
            System.out.println("Error al listar los activos fiat: " + e.getMessage());
            return null;
        }
    }

    private double cantidad;
    private String sigla;
    private int idUsuario;

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public double getCantidad() {
        return cantidad;
    }

    public void setCantidad(double cantidad) {
        this.cantidad = cantidad;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
}
