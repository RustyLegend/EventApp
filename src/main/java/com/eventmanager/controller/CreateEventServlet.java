package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        try {
            // Ensure the upload directory exists; create it if it doesn't.
            Files.createDirectories(UPLOAD_DIRECTORY);

            // 1. Get text data from the form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            LocalDateTime eventDatetime = LocalDateTime.parse(request.getParameter("eventDatetime"));
            String venue = request.getParameter("venue");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            
            // TODO: Replace this with logic to get the logged-in user's ID from the session
            int organizerId = 1;

            // 2. Handle the file upload
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            Path filePath = UPLOAD_DIRECTORY.resolve(fileName);
            filePart.write(filePath.toString());

            // 3. Create a new Event object and set its properties
            Event newEvent = new Event();
            newEvent.setTitle(title);
            newEvent.setDescription(description);
            newEvent.setEventDatetime(eventDatetime);
            newEvent.setVenue(venue);
            newEvent.setCategoryId(categoryId);
            newEvent.setOrganizerId(organizerId);
            newEvent.setImageUrl(fileName); // Important: Save ONLY the filename to the DB

            // 4. Use the DAO to save the event to the database
            eventDAO.createEvent(newEvent);

            // 5. Redirect the user back to the homepage after successful creation
            response.sendRedirect("home");

        } catch (Exception e) {
            // Log the error and forward to an error page or re-throw as a ServletException
            e.printStackTrace();
            throw new ServletException("Error creating event", e);
        }
    }
}