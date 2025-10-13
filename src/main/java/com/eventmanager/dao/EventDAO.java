package com.eventmanager.dao;

import com.eventmanager.model.Event;
import com.eventmanager.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    /**
     * Fetches all events from the database that are scheduled for the future.
     * @return A list of Event objects.
     */
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE event_datetime >= NOW() ORDER BY event_datetime ASC";

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
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    /**
     * Fetches a single, detailed event by its ID, including organizer and category names.
     * @param eventId The ID of the event to fetch.
     * @return An Event object, or null if not found.
     */
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

    /**
     * Inserts a new event into the database.
     * @param event The Event object to be created.
     */
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

    /**
     * Updates an existing event in the database.
     * @param event The Event object with updated information.
     */
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

    /**
     * Deletes an event from the database.
     * @param eventId The ID of the event to delete.
     */
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
}