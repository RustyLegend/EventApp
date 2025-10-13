package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteEvent")
public class DeleteEventServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Get the event ID from the URL parameter
            int eventId = Integer.parseInt(request.getParameter("id"));

            // TODO: In a real application, you would first verify that the logged-in user
            // is the actual owner of this event before deleting it.

            // 2. Call the DAO method to delete the event from the database
            eventDAO.deleteEvent(eventId);

            // 3. Redirect the user back to the homepage
            response.sendRedirect("home");

        } catch (NumberFormatException e) {
            // Handle cases where the ID is not a valid number
            e.printStackTrace();
            response.sendRedirect("home"); // Redirect to home on error
        }
    }
}