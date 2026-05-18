import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Producto {
    private int id_producto;
    private String nombre;
    private int stock_actual;

    // Constructor
    public Producto(int id_producto, String nombre, int stock_actual) {
        this.id_producto = id_producto;
        this.nombre = nombre;
        this.stock_actual = stock_actual;
    }

    // Getters y Setters
    public int getId_producto() { return id_producto; }
    public void setId_producto(int id_producto) { this.id_producto = id_producto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public int getStock_actual() { return stock_actual; }
    public void setStock_actual(int stock_actual) { this.stock_actual = stock_actual; }

    // Método para conectar a MySQL
    public static Connection conectar() {
        Connection conn = null;
        try {
            String url = "jdbc:mysql://localhost:3306/inventario";
            String user = "root";
            String password = "tu_password";
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Conexión exitosa a MySQL");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // Método para consultar productos
    public static void listarProductos() {
        try (Connection conn = conectar()) {
            String sql = "SELECT * FROM Producto";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id_producto") +
                                   " | Nombre: " + rs.getString("nombre") +
                                   " | Stock: " + rs.getInt("stock_actual"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

