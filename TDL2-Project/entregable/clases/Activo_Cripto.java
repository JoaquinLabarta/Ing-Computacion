package entregable.clases;

import entregable.comparadores.ComparadorCantidadActivosCripto;
import entregable.comparadores.ComparadorSiglaActivosCripto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Activo_Cripto {

    private double cantidad;
    private String sigla;
    private int usuarioId;

    public Activo_Cripto(String sigla, double cantidad, int usuarioId) {
        this.sigla = sigla;
        this.cantidad = cantidad;
        this.usuarioId = usuarioId;
    }

    public Activo_Cripto() {
    }

    public static boolean existeActivo(Connection con, String sigla, int idUsuario) {
        String query = "SELECT COUNT(*) FROM Activos WHERE sigla = ? AND usuario_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, sigla);
            pstmt.setInt(2, idUsuario); // Filtro por ID de usuario
            ResultSet rs = pstmt.executeQuery();
            return rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.out.println("Error al verificar si el activo existe: " + e.getMessage());
        }
        return false;
    }
    
    public static void agregarCriptomoneda(String sigla, double cantidad, int usuarioId, Connection con) {
        String verificarQuery = "SELECT cantidad FROM Activos WHERE sigla = ? and tipo = 'Criptomoneda' and usuario_id = ?";
        String actualizarQuery = "UPDATE Activos SET cantidad = cantidad + ? WHERE sigla = ? and tipo = 'Criptomoneda' and usuario_id = ?";
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
                        insertarStmt.setString(3, "Criptomoneda");
                        insertarStmt.setInt(4, usuarioId);
                        insertarStmt.executeUpdate();
                        System.out.println("Criptomoneda agregada: " + cantidad + " " + sigla);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al agregar la criptomoneda: " + e.getMessage());
        }
    }

    public static List<Activo_Cripto> listarActivosCripto(int usuarioId, Connection con, String ordenarPor) {
        List<Activo_Cripto> activosCripto = new ArrayList<>();
        String query = "SELECT sigla, cantidad FROM Activos WHERE tipo = 'Criptomoneda' and usuario_id = ?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, usuarioId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                String sigla = rs.getString("sigla");
                double cantidad = rs.getDouble("cantidad");

                Activo_Cripto activo = new Activo_Cripto(sigla, cantidad, usuarioId);
                activosCripto.add(activo);
            }

            if (ordenarPor.equalsIgnoreCase("sigla")) {
                activosCripto.sort(new ComparadorSiglaActivosCripto());
            } else if (ordenarPor.equalsIgnoreCase("cantidad")) {
                activosCripto.sort(new ComparadorCantidadActivosCripto().reversed());
            } else {
                System.out.println("Criterio de ordenamiento no válido. Se ordenará por sigla por defecto.");
                activosCripto.sort(new ComparadorSiglaActivosCripto().reversed());
            }

            return activosCripto;

        } catch (SQLException e) {
            System.out.println("Error al listar los activos de criptomonedas: " + e.getMessage());
            return null;
        }
    }

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

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }
}