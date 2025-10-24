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
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // --- Prevent Caching ---
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession(false);

        // 1. Check if user is logged in AND is an organizer
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp"); // Not logged in
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (!"organizer".equals(loggedInUser.getRole())) {
            response.sendRedirect("home"); // Not an organizer, redirect to home
            return;
        }

        // 2. Fetch events created by this organizer
        int organizerId = loggedInUser.getId();
        List<Event> organizerEvents = eventDAO.getEventsByOrganizerId(organizerId);

        // 3. Set the list as an attribute for the JSP
        request.setAttribute("organizerEventList", organizerEvents);

        // 4. Forward to the dashboard JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}