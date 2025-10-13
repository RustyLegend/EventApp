package com.eventmanager.dao;

import com.eventmanager.model.User;
import com.eventmanager.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {

    // This method gets a list of all users attending a specific event
    public List<User> getAttendeesForEvent(int eventId) {
        List<User> attendees = new ArrayList<>();
        // This SQL query joins the registrations and users tables
        String sql = "SELECT u.name FROM users u JOIN registrations r ON u.user_id = r.user_id WHERE r.event_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setName(rs.getString("name"));
                attendees.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendees;
    }

    // You could also add methods here to handle event registration
    public void registerUserForEvent(int userId, int eventId) {
        String sql = "INSERT INTO registrations (user_id, event_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            // It's common for this to fail if a user tries to register twice,
            // which is okay because of the UNIQUE constraint in the database.
            e.printStackTrace();
        }
    }

    // In RegistrationDAO.java

    /**
     * Checks if a specific user is already registered for a specific event.
     * @return true if a registration exists, false otherwise.
     */
    public boolean isUserRegistered(int userId, int eventId) {
        String sql = "SELECT registration_id FROM registrations WHERE user_id = ? AND event_id = ?";
        try (Connection conn = DBUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // If a row is found, rs.next() will be true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Removes a user's registration for an event.
     */
    public void unregisterUserFromEvent(int userId, int eventId) {
        String sql = "DELETE FROM registrations WHERE user_id = ? AND event_id = ?";
        try (Connection conn = DBUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}