package entregable.clases;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class creacionDeTablas {

    public static void crearTablaMoneda(Connection connection) {
        String query = """
            CREATE TABLE IF NOT EXISTS Moneda (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nombre VARCHAR(15) NOT NULL,
                sigla VARCHAR(3) NOT NULL UNIQUE,
                valor REAL NOT NULL,
                tipo VARCHAR(12) NOT NULL,
                volatilidad REAL,
                stock REAL
            )
            """;
        try (Statement statement = connection.createStatement()) {
            statement.execute(query);
            System.out.println("Tabla 'Moneda' creada exitosamente.");
        } catch (SQLException ex) {
            System.out.println("Error al crear la tabla 'Moneda': " + ex.getMessage());
        }
    }

    public static void crearTablaActivos(Connection connection) {
        String query = """
            CREATE TABLE IF NOT EXISTS Activos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                sigla VARCHAR(3) NOT NULL,
                cantidad REAL NOT NULL,
                tipo VARCHAR(12) NOT NULL,
                usuario_id INTEGER NOT NULL,
                FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON DELETE CASCADE
            )
            """;
        try (Statement statement = connection.createStatement()) {
            statement.execute(query);
            System.out.println("Tabla 'Activos' creada exitosamente.");
        } catch (SQLException ex) {
            System.out.println("Error al crear la tabla 'Activos': " + ex.getMessage());
        }
    }

    public static void crearTablaUsuario(Connection connection) {
        String query = """
            CREATE TABLE IF NOT EXISTS Usuario (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user VARCHAR(50) NOT NULL UNIQUE,
                email VARCHAR(50) NOT NULL UNIQUE,
                password VARCHAR(50) NOT NULL,
                acepta_terminos BOOLEAN NOT NULL
            )
            """;
        try (Statement statement = connection.createStatement()) {
            statement.execute(query);
            System.out.println("Tabla 'Usuario' creada correctamente.");
        } catch (SQLException ex) {
            System.out.println("Error al crear la tabla 'Usuario': " + ex.getMessage());
        }
    }
    
    public static void crearTablaTransaccion(Connection connection) {
        String query = """
            CREATE TABLE IF NOT EXISTS Transaccion (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                resumen VARCHAR(100) NOT NULL,
                fecha_hora VARCHAR(79) NOT NULL,
                usuario_id INTEGER NOT NULL,
                FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON DELETE CASCADE
            )
            """;
        try (Statement statement = connection.createStatement()) {
            statement.execute(query);
            System.out.println("Tabla 'Transaccion' creada exitosamente.");
        } catch (SQLException ex) {
            System.out.println("Error al crear la tabla 'Transaccion': " + ex.getMessage());
        }
    }

    public static void insertarMonedas(Connection connection) {
        String query = """
            INSERT OR IGNORE INTO Moneda (nombre, sigla, valor, tipo, volatilidad, stock) VALUES
            ('Bitcoin', 'BTC', 45000.00, 'Criptomoneda', 0.05, 21000000),
            ('Ethereum', 'ETH', 3000.00, 'Criptomoneda', 0.04, 115000000),
            ('Dólar', 'USD', 1.00, 'Fiat', 0.01, NULL),
            ('Peso Argentino', 'ARS', 1000, 'Fiat', 0.98, NULL)
            """;
        try (Statement stmt = connection.createStatement()) {
            int filasAfectadas = stmt.executeUpdate(query);
            System.out.println("Monedas de ejemplo insertadas correctamente. Filas afectadas: " + filasAfectadas);
        } catch (SQLException e) {
            System.out.println("Error al insertar monedas: " + e.getMessage());
        }
    }
}