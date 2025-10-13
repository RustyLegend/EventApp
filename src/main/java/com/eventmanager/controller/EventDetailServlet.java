package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.dao.RegistrationDAO;
import com.eventmanager.model.Event;
import com.eventmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/event")
public class EventDetailServlet extends HttpServlet {
    private EventDAO eventDAO;
    private RegistrationDAO registrationDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
        registrationDAO = new RegistrationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("id"));

            // 1. Fetch the main event details
            Event event = eventDAO.getEventById(eventId);
            request.setAttribute("event", event);

            // 2. Fetch the list of attendees for this event
            List<User> attendeeList = registrationDAO.getAttendeesForEvent(eventId);
            request.setAttribute("attendeeList", attendeeList);

            HttpSession session = request.getSession(false);
            User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

            boolean isUserRegistered = false;
            if (loggedInUser != null) {
                isUserRegistered = registrationDAO.isUserRegistered(loggedInUser.getId(), eventId);
            }
            request.setAttribute("isUserRegistered", isUserRegistered);
            // 3. Forward to the JSP for display
            request.getRequestDispatcher("event-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID.");
        }
    }
}