package entregable.clases;

import java.sql.Connection;
import java.util.List;

public interface ITransaccionDAO {
    void realizarSwap(Connection con, int idUsuario, String siglaConvertir, double cantidadConvertir, String siglaEsperada);
    void comprarActivo(Connection con, int idUsuario, String sigla, double cantidadCompraUSD);
    void insertarActivo(Connection con, int idUsuario, String sigla, double cantidad);
    void generarFactura(Connection con, String sigla, double cantidad);
    List<Transaccion> obtenerTransaccionesPorUsuario(Connection con, int idUsuario);
    boolean insertarTransaccion(Connection con, Transaccion transaccion);
    boolean eliminarTransaccion(Connection con, int idTransaccion);
}