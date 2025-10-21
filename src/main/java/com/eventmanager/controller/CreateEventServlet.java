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
@MultipartConfig
public class CreateEventServlet extends HttpServlet {

    private EventDAO eventDAO;
    private static final Path UPLOAD_DIRECTORY = Paths.get(System.getProperty("user.home"), "event-images");

    @Override
    public void init() {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equals(loggedInUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You must be an organizer to create an event.");
            return;
        }

        try {
            int organizerId = loggedInUser.getId();
            Files.createDirectories(UPLOAD_DIRECTORY);
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            LocalDateTime eventDatetime = LocalDateTime.parse(request.getParameter("eventDatetime"));
            String venue = request.getParameter("venue");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName == null || fileName.trim().isEmpty()) {
                session.setAttribute("createEventError", "Please upload a banner image for the event.");
                response.sendRedirect("create-event.jsp");
                return;
            }
            Path filePath = UPLOAD_DIRECTORY.resolve(fileName);
            filePart.write(filePath.toString());
            Event newEvent = new Event();
            newEvent.setTitle(title);
            newEvent.setDescription(description);
            newEvent.setEventDatetime(eventDatetime);
            newEvent.setVenue(venue);
            newEvent.setCategoryId(categoryId);
            newEvent.setOrganizerId(organizerId);
            newEvent.setImageUrl(fileName);
            eventDAO.createEvent(newEvent);
            session.removeAttribute("createEventError");
            response.sendRedirect("home");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("createEventError", "An error occurred while creating the event. Please check your inputs.");
            response.sendRedirect("create-event.jsp");
        }
    }
}