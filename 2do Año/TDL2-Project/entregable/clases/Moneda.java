package entregable.clases;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public abstract class Moneda implements IMonedaDAO {

    // Método para insertar una moneda en la base de datos
    @Override
    public abstract void insertarMoneda(Connection connection, Moneda moneda);

    // Método para verificar si una moneda ya existe por su sigla
    @Override
    public boolean existeMoneda(Connection connection, String sigla) {
        String query = "SELECT COUNT(*) FROM Moneda WHERE sigla = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, sigla);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                resultSet.next();
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar si la moneda existe.");
            return false;
        }
    }

    // Método abstracto para listar monedas, implementado por subclases
    @Override
    public abstract List<Moneda> listarMonedas(Connection connection, String ordenarPor);

    // Método abstracto para obtener el stock de una moneda
    @Override
    public abstract double obtenerStock(Connection connection, String sigla);

    // Atributos principales de la clase
    private String nombre;      
    private String sigla;       
    private double precioActual; 
    private double cantidad;    
    private double volatilidad; 

    // Getters y setters para los atributos
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public double getPrecioActual() {
        return precioActual;
    }

    public void setPrecioActual(double precioActual) {
        this.precioActual = precioActual;
    }

    public double getCantidad() {
        return cantidad;
    }

    public void setCantidad(double cantidad) {
        this.cantidad = cantidad;
    }

    public double getVolatilidad() {
        return volatilidad;
    }

    public void setVolatilidad(double volatilidad) {
        this.volatilidad = volatilidad;
    }
}