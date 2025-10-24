<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Determine the redirect URL based on user role
    String redirectUrl = "home"; // Default to home
    com.eventmanager.model.User loggedInUser = (com.eventmanager.model.User) session.getAttribute("loggedInUser");
    if (loggedInUser != null && "organizer".equals(loggedInUser.getRole())) {
        redirectUrl = "dashboard"; // Organizers go to dashboard
    }
    
    // Set the refresh header with the correct URL
    response.setHeader("Refresh", "3;url=" + redirectUrl);
%>
<html>
<head>
    <title>Welcome!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        @keyframes scaleUp {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; -webkit-tap-highlight-color: transparent;">
    
    <div style="animation: scaleUp 1.0s ease-out forwards; opacity: 0;">
        <h1 style="font-size: 3em; color: #ffffff; margin: 0;">
            Welcome, ${sessionScope.loggedInUser.name}!
        </h1>
        <p style="font-size: 1.2em; color: #aaaaaa; margin-top: 10px;">
            Redirecting you shortly...
        </p>
    </div>

</body>
</html>