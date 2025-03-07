package entregable.clases;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Usuario {

    private int id; // este campo sera gestionado por la base de datos
    private String user;
    private String email;
    private String password;
    private boolean aceptaTerminos;

    // Constructor
    // Constructor con ID
    public Usuario(int id, String user, String email, String password, boolean aceptaTerminos) {
        this.id = id;
        this.user = user;
        this.email = email;
        this.password = password;
        this.aceptaTerminos = aceptaTerminos;
    }


    // Getters
    public int getId() {
        return id;
    }

    public String getUser() {
        return user;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public boolean isAceptaTerminos() {
        return aceptaTerminos;
    }

    // Método para validar credenciales de usuario
    public static boolean validarCredenciales(Connection con, String username, String password) {
        String query = "SELECT password FROM Usuario WHERE user = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(password); // Compara la contraseña ingresada
            } else {
                System.out.println("Usuario no encontrado.");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Error al validar credenciales: " + e.getMessage());
            return false;
        }
    }

    // Método para obtener un usuario de la base de datos por su id
    public static Usuario obtenerUsuario(Connection con, String nombre) {
        String query = "SELECT id, user, email, password, acepta_terminos FROM Usuario WHERE user = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, nombre);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String user = rs.getString("user");
                String email = rs.getString("email");
                String password = rs.getString("password");
                boolean aceptaTerminos = rs.getBoolean("acepta_terminos");
                System.out.println("Usuario encontrado con el ID: " + id);
                return new Usuario(id, user, email, password, aceptaTerminos);
            } else {
                System.out.println("Usuario no encontrado");
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario: " + e.getMessage());
            return null;
        }
    }

    // Método para insertar un nuevo usuario en la base de datos
    public static void insertarUsuario(Connection connection, String user, String email, String password, boolean aceptaTerminos) {
        String query = """
            INSERT INTO Usuario (user, email, password, acepta_terminos) VALUES (?, ?, ?, ?)
            """;
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setBoolean(4, aceptaTerminos);
            stmt.executeUpdate();
            System.out.println("Usuario insertado correctamente: " + user + ", con el ID: " + Usuario.obtenerUsuario(connection, user).getId());
        } catch (SQLException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
        }
    }

    // Método para obtener el balance en ARS de un usuario
    public double getBalanceARS(Connection con, int usuarioId) {
        double balanceARS = 0.0;
        String sql = "SELECT cantidad FROM Activos WHERE usuario_id = ? AND sigla = 'ARS' AND tipo = 'Fiat'";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, usuarioId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    balanceARS = rs.getDouble("cantidad");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al traer balance en ARS"); // Manejar el error de forma adecuada
        }
        return balanceARS;
    }
}
