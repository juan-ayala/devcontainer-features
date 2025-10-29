
import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.regex.Pattern;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class SimpleHttpServer {

    public static void main(String[] args) {

        final var options = String.join(" ", args);
        final var m = Pattern.compile("-p (\\d+)").matcher(options);
        var matches = m.find();
        if (matches) {

            final var port = Integer.parseInt(m.group(1));

            try {

                final var server = HttpServer.create(new InetSocketAddress(port), 0);

                server.createContext("/", new MyHandler());
                server.setExecutor(null);
                server.start();

            } catch (IOException e) {
                System.err.printf("Error starting the server: %s%n", e.getMessage());
                System.exit(1);
            }

            System.out.printf("Server started on port %d%n", port);

        } else {
            System.err.println("Usage: java SimpleHttpServer -p <port>");
            System.exit(2);
        }
    }

    static class MyHandler implements HttpHandler {

        @Override
        public void handle(HttpExchange exchange) throws IOException {

            final var response = "hello,world";
            exchange.sendResponseHeaders(200, response.length());
            final var os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }

    }
}
