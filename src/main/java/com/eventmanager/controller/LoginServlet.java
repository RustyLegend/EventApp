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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;
    public void init() { userDAO = new UserDAO(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = userDAO.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            response.sendRedirect("home");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}