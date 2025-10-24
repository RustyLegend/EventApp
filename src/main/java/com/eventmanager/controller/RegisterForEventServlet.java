package com.eventmanager.controller;

import com.eventmanager.dao.EventDAO;
import com.eventmanager.dao.RegistrationDAO;
import com.eventmanager.model.User;
import com.eventmanager.util.EmailService;
import com.eventmanager.model.Event;
import java.time.format.DateTimeFormatter;
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
    private EventDAO eventDAO;
    public void init() {
        registrationDAO = new RegistrationDAO();
        eventDAO = new EventDAO();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int userId = loggedInUser.getId();
            registrationDAO.registerUserForEvent(userId, eventId);
            Event event = eventDAO.getEventById(eventId);
            String eventTitle = eventDAO.getEventTitleById(eventId);
            
            if (eventTitle != null) {
                // Get user's details from session
                String userEmail = loggedInUser.getEmail();
                String userName = loggedInUser.getName();

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' h:mm a");
                String formattedDateTime = event.getEventDatetime().format(formatter);
                String subject = "You're confirmed for: " + event.getTitle() + "!";
                String eventLink = "https://overdefiant-somberly-izabella.ngrok-free.dev/EventApp/event?id=" + event.getEventId();
                String emailBody = "<html>" +
                    "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;'>" +
                    
                    "<h2 style='color: #0056b3;'>You're All Set!</h2>" +
                    "<p>Hi " + userName + ",</p>" +
                    "<p>Thanks for registering! We've saved your spot for this event:</p>" +
                    
                    "<div style='background-color: #f4f4f9; padding: 15px; border-radius: 8px; margin: 20px 0;'>" +
                    "  <h3 style='margin-top: 0; color: #111;'>" + event.getTitle() + "</h3>" +
                    "  <p style='margin: 5px 0;'><strong>When:</strong> " + formattedDateTime + "</p>" +
                    "  <p style='margin: 5px 0;'><strong>Where:</strong> " + event.getVenue() + "</p>" +
                    "</div>" +

                    "<p style='margin: 25px 0; text-align: center;'>" +
                    "  <a href='" + eventLink + "' " +
                    "     style='background-color: #28a745; color: white; padding: 12px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;'>" +
                    "     View Event Details" +
                    "  </a>" +
                    "</p>" +
                    
                    "<p>We look forward to seeing you there!</p>" +
                    "<br>" + "<p>- The EventApp Team</p>" +
                    "</body>" +
                    "</html>";
                
                // Call the email service to send the email
                EmailService.sendEmail(userEmail, subject, emailBody);
            }
            response.sendRedirect("event?id=" + eventId);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID.");
        }
    }
}