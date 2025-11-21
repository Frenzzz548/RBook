package com.rbook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASSWORD");
        if (url == null || user == null) {
            // fallback lokal
            url = "jdbc:mysql://127.0.0.1:3306/rbook?useSSL=false&allowPublicKeyRetrieval=true";
            user = "root";
            pass = "";
        }
        return DriverManager.getConnection(url, user, pass);
    }
}
