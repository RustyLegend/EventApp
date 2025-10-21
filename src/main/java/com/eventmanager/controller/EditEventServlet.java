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
import java.time.LocalDateTime;

@WebServlet("/editEvent")
public class EditEventServlet extends HttpServlet {
    private EventDAO eventDAO;

    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int eventId = Integer.parseInt(request.getParameter("id"));
        Event existingEvent = eventDAO.getEventById(eventId);

        if (existingEvent != null && existingEvent.getOrganizerId() == loggedInUser.getId()) {
            request.setAttribute("event", existingEvent);
            request.getRequestDispatcher("edit-event.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to edit this event.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int eventId = Integer.parseInt(request.getParameter("eventId"));
        Event eventToUpdate = eventDAO.getEventById(eventId);

        if (eventToUpdate != null && eventToUpdate.getOrganizerId() == loggedInUser.getId()) {
            eventToUpdate.setTitle(request.getParameter("title"));
            eventToUpdate.setDescription(request.getParameter("description"));
            eventToUpdate.setEventDatetime(LocalDateTime.parse(request.getParameter("eventDatetime")));
            eventToUpdate.setVenue(request.getParameter("venue"));

            eventDAO.updateEvent(eventToUpdate);
            response.sendRedirect("event?id=" + eventId);
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to edit this event.");
        }
    }
}