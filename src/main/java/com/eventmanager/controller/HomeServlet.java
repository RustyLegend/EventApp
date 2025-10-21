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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Event> allEvents = eventDAO.getAllEvents();
        request.setAttribute("eventList", allEvents);
        // 2. Get the user's registered events (ONLY for attendees)
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");

            // Only fetch registered events if the user is an 'attendee'
            if ("attendee".equals(user.getRole())) {
                List<Event> myRegisteredEvents = eventDAO.getRegisteredEventsByUserId(user.getId());
                request.setAttribute("myRegisteredEvents", myRegisteredEvents);
            }
        }
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}