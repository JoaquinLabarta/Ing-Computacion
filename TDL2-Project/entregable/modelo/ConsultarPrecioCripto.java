package entregable.modelo;

import org.json.JSONObject;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.Map;

public class ConsultarPrecioCripto {
    private static final String URL_API = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,usd-coin,tether,dogecoin&vs_currencies=usd";

    public static Map<String, Double> obtenerPrecios() throws IOException, InterruptedException {
        HttpClient cliente = HttpClient.newHttpClient();
        HttpRequest solicitud = HttpRequest.newBuilder()
                .uri(URI.create(URL_API))
                .GET()
                .build();

        HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());
        if (respuesta.statusCode() == 200) {
            return parsearPrecios(respuesta.body());
        } else {
            throw new IOException("Error al consultar precios. Código de estado: " + respuesta.statusCode());
        }
    }

    private static Map<String, Double> parsearPrecios(String cuerpoRespuesta) {
        JSONObject json = new JSONObject(cuerpoRespuesta);
        Map<String, Double> precios = new HashMap<>();
        precios.put("Bitcoin", json.getJSONObject("bitcoin").getDouble("usd"));
        precios.put("Ethereum", json.getJSONObject("ethereum").getDouble("usd"));
        return precios;
    }
}