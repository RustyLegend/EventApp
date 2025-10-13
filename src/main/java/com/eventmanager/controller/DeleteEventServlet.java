package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.User;
import com.eventmanager.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteEvent")
public class DeleteEventServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Security Check 1: Is a user logged in?
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("id"));
            Event event = eventDAO.getEventById(eventId);

            // Security Check 2: Is the logged-in user the owner of this event?
            if (event != null && event.getOrganizerId() == loggedInUser.getId()) {
                // If checks pass, delete the event
                eventDAO.deleteEvent(eventId);
                response.sendRedirect("home");
            } else {
                // If not the owner, send a "Forbidden" error
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to delete this event.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID.");
        }
    }
}