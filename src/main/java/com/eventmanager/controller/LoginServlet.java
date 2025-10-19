package com.eventmanager.controller;

import com.eventmanager.dao.UserDAO;
import com.eventmanager.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder; // Import URLEncoder

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;
    public void init() { userDAO = new UserDAO(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            // CASE 1: User does not exist. Redirect to the register page.
            // We pass the email as a URL parameter to pre-fill the form.
            String encodedEmail = URLEncoder.encode(email, "UTF-8");
            response.sendRedirect("register.jsp?email=" + encodedEmail);

        } else {
            // CASE 2: User exists, now check the password.
            if (user.getPassword().equals(password)) {
                // SUCCESS: Password matches.
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                response.sendRedirect("home");
            } else {
                // FAILURE: Password is incorrect.
                request.setAttribute("errorMessage", "Password incorrect");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}