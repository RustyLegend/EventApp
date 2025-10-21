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

// This annotation maps the URL "/home" to this servlet
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get the list of events from the DAO
        List<Event> eventList = eventDAO.getAllEvents();

        // 2. Set the list as an attribute in the request
        request.setAttribute("eventList", eventList);

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            
            // Call the new DAO method
            List<Event> myRegisteredEvents = eventDAO.getRegisteredEventsByUserId(user.getId());
            
            // Pass this new list to the JSP
            request.setAttribute("myRegisteredEvents", myRegisteredEvents);
        }

        // 3. Forward the request to the JSP file for display
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
