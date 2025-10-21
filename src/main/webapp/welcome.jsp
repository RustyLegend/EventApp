<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Automatically redirect to the "home" servlet after 3 seconds
    response.setHeader("Refresh", "3;url=home");
%>
<html>
<head>
    <title>Welcome!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        /* Define the animation keyframes */
        @keyframes fadeInZoom {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center;">
    
    <div style="animation: fadeInZoom 1.5s ease-out;">
        <h1 style="font-size: 3em; color: #ffffff; margin: 0;">
            Welcome, ${sessionScope.loggedInUser.name}!
        </h1>
        <p style="font-size: 1.2em; color: #aaaaaa; margin-top: 10px;">
            Redirecting you to the homepage...
        </p>
    </div>

</body>
</html>