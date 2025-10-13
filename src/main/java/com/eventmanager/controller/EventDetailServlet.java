package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/event")
public class EventDetailServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get the event ID from the URL parameter
        int eventId = Integer.parseInt(request.getParameter("id"));

        // 2. Fetch the detailed event data using the DAO
        Event event = eventDAO.getEventById(eventId);

        // 3. Set the event object as an attribute to pass to the JSP
        request.setAttribute("event", event);

        // 4. Forward to the new detail page JSP
        request.getRequestDispatcher("event-detail.jsp").forward(request, response);
    }
}