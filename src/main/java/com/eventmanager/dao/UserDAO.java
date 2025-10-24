package com.eventmanager.dao;
import com.eventmanager.model.User;
import com.eventmanager.util.DBUtil;
import com.eventmanager.util.EmailService;

import java.sql.*;
import java.util.UUID;

public class UserDAO {
    public void createUser(User user) {
        String token = UUID.randomUUID().toString();
        String sql = "INSERT INTO users (name, email, password, role, is_verified, verification_token) VALUES (?, ?, ?, ?, false, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, token);
            stmt.executeUpdate();
            EmailService.sendVerificationEmail(user.getName(), user.getEmail(), token);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setVerified(rs.getBoolean("is_verified"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByToken(String token) {
        User user = null;
        String sql = "SELECT * FROM users WHERE verification_token = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                // ... set other fields if needed
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean verifyUser(String token) {
        String sql = "UPDATE users SET is_verified = true, verification_token = NULL WHERE verification_token = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Returns true if the user was found and updated
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}