package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.Event;
import com.eventmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;

@WebServlet("/createEvent")
@MultipartConfig // Required for handling file uploads
public class CreateEventServlet extends HttpServlet {

    private EventDAO eventDAO;
    // Defines the upload directory using Java's modern Path API
    private static final Path UPLOAD_DIRECTORY = Paths.get(System.getProperty("user.home"), "event-images");

    @Override
    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Security Check 1: Is a user logged in?
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Security Check 2: Is the user an organizer?
        if (!"organizer".equals(loggedInUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You must be an organizer to create an event.");
            return;
        }

        try {
            // This is the real organizer ID from the logged-in user
            int organizerId = loggedInUser.getId();

            // The rest of your code is the same...
            Files.createDirectories(UPLOAD_DIRECTORY);
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            LocalDateTime eventDatetime = LocalDateTime.parse(request.getParameter("eventDatetime"));
            String venue = request.getParameter("venue");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            Path filePath = UPLOAD_DIRECTORY.resolve(fileName);
            filePart.write(filePath.toString());

            Event newEvent = new Event();
            newEvent.setTitle(title);
            newEvent.setDescription(description);
            newEvent.setEventDatetime(eventDatetime);
            newEvent.setVenue(venue);
            newEvent.setCategoryId(categoryId);
            newEvent.setOrganizerId(organizerId); // Using the real ID now
            newEvent.setImageUrl(fileName);

            eventDAO.createEvent(newEvent);
            response.sendRedirect("home");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error creating event", e);
        }
    }
}