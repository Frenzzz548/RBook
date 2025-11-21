package com.rbook.dao;

import com.rbook.DBUtil;
import com.rbook.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    public static boolean createUser(String name, String email, String password) throws Exception {
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        try (Connection c = DBUtil.getConnection()) {
            PreparedStatement ps = c.prepareStatement("INSERT INTO users (name,email,password) VALUES (?,?,?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hash);
            return ps.executeUpdate() == 1;
        }
    }

    public static User findByEmail(String email) throws Exception {
        try (Connection c = DBUtil.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT id,name,email,password,role FROM users WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPasswordHash(rs.getString("password"));
                u.setRole(rs.getString("role"));
                return u;
            }
            return null;
        }
    }

    public static User validate(String email, String password) throws Exception {
        User u = findByEmail(email);
        if (u == null) return null;
        if (BCrypt.checkpw(password, u.getPasswordHash())) return u;
        return null;
    }
}
