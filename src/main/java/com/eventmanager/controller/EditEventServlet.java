package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/editEvent")
public class EditEventServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    // This method handles GET requests: It shows the edit form.
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("id"));
        Event existingEvent = eventDAO.getEventById(eventId);
        request.setAttribute("event", existingEvent);
        request.getRequestDispatcher("edit-event.jsp").forward(request, response);
    }

    // This method handles POST requests: It processes the form submission.
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDateTime eventDatetime = LocalDateTime.parse(request.getParameter("eventDatetime"));
        String venue = request.getParameter("venue");

        Event updatedEvent = new Event();
        updatedEvent.setEventId(eventId);
        updatedEvent.setTitle(title);
        updatedEvent.setDescription(description);
        updatedEvent.setEventDatetime(eventDatetime);
        updatedEvent.setVenue(venue);

        eventDAO.updateEvent(updatedEvent);

        // Redirect back to the detail page for the event that was just updated
        response.sendRedirect("event?id=" + eventId);
    }
}