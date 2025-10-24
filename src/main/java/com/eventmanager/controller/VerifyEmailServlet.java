package com.eventmanager.controller;

import com.eventmanager.dao.UserDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/verify")
public class VerifyEmailServlet extends HttpServlet {
    private UserDAO userDAO;
    public void init() { userDAO = new UserDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        
        boolean isVerified = userDAO.verifyUser(token);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body style='font-family: sans-serif; text-align: center; margin-top: 50px;'>");
        if (isVerified) {
            out.println("<h1>Verification Successful!</h1>");
            out.println("<p>Your account is now verified. You can now log in.</p>");
            out.println("<a href='login.jsp'>Go to Login</a>");
        } else {
            out.println("<h1>Verification Failed</h1>");
            out.println("<p>The verification link is invalid or has expired.</p>");
        }
        out.println("</body></html>");
    }
}