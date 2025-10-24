package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.Event;
import com.eventmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        List<Event> allEvents = eventDAO.getAllEvents();
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // --- NEW: Group events by date for the timeline ---
        LocalDate today = LocalDate.now();
        LocalDate tomorrow = today.plusDays(1);

        // Use LinkedHashMap to maintain the chronological order of days
        Map<String, List<Event>> groupedEvents = new LinkedHashMap<>();

        for (Event event : allEvents) {
            LocalDate eventDate = event.getEventDatetime().toLocalDate();
            String dateKey;
            String dayOfWeek = eventDate.format(DateTimeFormatter.ofPattern("EEEE")); // "Friday"

            if (eventDate.equals(today)) {
                // Use a separator that we can replace in the JSP for styling
                dateKey = "Today | " + dayOfWeek;
            } else if (eventDate.equals(tomorrow)) {
                dateKey = "Tomorrow | " + dayOfWeek;
            } else {
                // For other dates
                dateKey = eventDate.format(DateTimeFormatter.ofPattern("MMMM d | EEEE"));
            }

            // This adds the event to the list for the correct date group
            groupedEvents.computeIfAbsent(dateKey, k -> new ArrayList<>()).add(event);
        }

        // Pass the new grouped map to the JSP
        request.setAttribute("groupedEvents", groupedEvents);
        // --- END OF NEW LOGIC ---


        // Fetch registered events for attendee sidebar (this logic remains)
        if (user != null && "attendee".equals(user.getRole())) {
            List<Event> myRegisteredEvents = eventDAO.getRegisteredEventsByUserId(user.getId());
            request.setAttribute("myRegisteredEvents", myRegisteredEvents);
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}