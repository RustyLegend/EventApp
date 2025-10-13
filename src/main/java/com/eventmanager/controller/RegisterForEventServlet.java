package com.eventmanager.controller;

import com.eventmanager.dao.RegistrationDAO;
import com.eventmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/registerForEvent")
public class RegisterForEventServlet extends HttpServlet {
    private RegistrationDAO registrationDAO;

    public void init() {
        registrationDAO = new RegistrationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Security check: User must be logged in to register
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int userId = loggedInUser.getId();

            // Use the DAO to create the registration entry
            registrationDAO.registerUserForEvent(userId, eventId);

            // Redirect back to the same event detail page
            response.sendRedirect("event?id=" + eventId);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID.");
        }
    }
}