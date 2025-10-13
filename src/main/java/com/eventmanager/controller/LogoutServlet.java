package com.eventmanager.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get the current session, but don't create a new one if it doesn't exist.
        HttpSession session = request.getSession(false);

        // 2. If a session exists, invalidate it (log the user out).
        if (session != null) {
            session.invalidate();
        }

        // 3. Redirect the user to the login page.
        response.sendRedirect("login.jsp");
    }
}