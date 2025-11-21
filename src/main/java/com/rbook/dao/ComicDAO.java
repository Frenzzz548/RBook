package com.rbook.dao;

import com.rbook.DBUtil;
import com.rbook.model.Comic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComicDAO {
    public static boolean create(Comic c) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO comics (title,author,description,cover) VALUES (?,?,?,?)");
            ps.setString(1, c.getTitle());
            ps.setString(2, c.getAuthor());
            ps.setString(3, c.getDescription());
            ps.setString(4, c.getCover());
            return ps.executeUpdate() == 1;
        }
    }

    public static List<Comic> listAll() throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id,title,author,description,cover FROM comics ORDER BY created_at DESC");
            ResultSet rs = ps.executeQuery();
            List<Comic> list = new ArrayList<>();
            while (rs.next()) {
                Comic c = new Comic();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setAuthor(rs.getString("author"));
                c.setDescription(rs.getString("description"));
                c.setCover(rs.getString("cover"));
                list.add(c);
            }
            return list;
        }
    }

    public static Comic find(int id) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id,title,author,description,cover FROM comics WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Comic c = new Comic();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setAuthor(rs.getString("author"));
                c.setDescription(rs.getString("description"));
                c.setCover(rs.getString("cover"));
                return c;
            }
            return null;
        }
    }

    public static boolean update(Comic c) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("UPDATE comics SET title=?,author=?,description=?,cover=? WHERE id=?");
            ps.setString(1, c.getTitle());
            ps.setString(2, c.getAuthor());
            ps.setString(3, c.getDescription());
            ps.setString(4, c.getCover());
            ps.setInt(5, c.getId());
            return ps.executeUpdate() == 1;
        }
    }

    public static boolean delete(int id) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM comics WHERE id = ?");
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }
}
