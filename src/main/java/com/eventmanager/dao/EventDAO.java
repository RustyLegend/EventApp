package com.eventmanager.dao;

import com.eventmanager.model.Event;
import com.eventmanager.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, u.name AS organizer_name, c.name AS category_name " +
                     "FROM events e " +
                     "JOIN users u ON e.organizer_id = u.user_id " +
                     "JOIN categories c ON e.category_id = c.category_id " +
                     "WHERE e.event_datetime >= NOW() ORDER BY e.event_datetime ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setEventDatetime(rs.getTimestamp("event_datetime").toLocalDateTime());
                event.setVenue(rs.getString("venue"));
                event.setImageUrl(rs.getString("image_url"));
                event.setOrganizerId(rs.getInt("organizer_id"));
                event.setOrganizerName(rs.getString("organizer_name"));
                event.setCategoryName(rs.getString("category_name"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    public Event getEventById(int eventId) {
        Event event = null;
        String sql = "SELECT e.*, u.name AS organizer_name, c.name AS category_name " +
                     "FROM events e " +
                     "JOIN users u ON e.organizer_id = u.user_id " +
                     "JOIN categories c ON e.category_id = c.category_id " +
                     "WHERE e.event_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDatetime(rs.getTimestamp("event_datetime").toLocalDateTime());
                event.setVenue(rs.getString("venue"));
                event.setImageUrl(rs.getString("image_url"));
                event.setOrganizerId(rs.getInt("organizer_id"));
                event.setOrganizerName(rs.getString("organizer_name"));
                event.setCategoryName(rs.getString("category_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return event;
    }
    public void createEvent(Event event) {
        String sql = "INSERT INTO events (title, description, event_datetime, venue, image_url, organizer_id, category_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setTimestamp(3, Timestamp.valueOf(event.getEventDatetime()));
            stmt.setString(4, event.getVenue());
            stmt.setString(5, event.getImageUrl());
            stmt.setInt(6, event.getOrganizerId());
            stmt.setInt(7, event.getCategoryId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateEvent(Event event) {
        String sql = "UPDATE events SET title = ?, description = ?, event_datetime = ?, venue = ? WHERE event_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setTimestamp(3, Timestamp.valueOf(event.getEventDatetime()));
            stmt.setString(4, event.getVenue());
            stmt.setInt(5, event.getEventId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteEvent(int eventId) {
        String sql = "DELETE FROM events WHERE event_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Event> getRegisteredEventsByUserId(int userId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, c.name AS category_name, u.name AS organizer_name " +
                    "FROM events e " +
                    "JOIN registrations r ON e.event_id = r.event_id " +
                    "JOIN categories c ON e.category_id = c.category_id " +
                    "JOIN users u ON e.organizer_id = u.user_id " +
                    "WHERE r.user_id = ? AND e.event_datetime >= NOW() " +
                    "ORDER BY e.event_datetime ASC";

        try (Connection conn = DBUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {     
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setEventDatetime(rs.getTimestamp("event_datetime").toLocalDateTime());
                event.setImageUrl(rs.getString("image_url"));
                event.setOrganizerName(rs.getString("organizer_name"));
                event.setCategoryName(rs.getString("category_name"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
}