package com.eventmanager.controller;

import com.eventmanager.dao.UserDAO;
import com.eventmanager.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;
    public void init() { userDAO = new UserDAO(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));

        userDAO.createUser(user);

        response.sendRedirect("login.jsp");
    }
}