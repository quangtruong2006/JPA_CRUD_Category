package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "LAPTOP-5TEUL3EV\\SQLEXPRESS01";
    private final String dbName = "JPA_CRUD_Category";
    private final String userID = "sa";
    private final String password = "123456";

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName 
                + ";databaseName=" + dbName 
                + ";encrypt=true;trustServerCertificate=true;";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("====== KẾT NỐI SQL SERVER THÀNH CÔNG! ======");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("====== KẾT NỐI THẤT BẠI! ======");
            e.printStackTrace();
        }
    }
}