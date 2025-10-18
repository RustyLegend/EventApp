<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma","no-cache"); // HTTP 1.0.
    response.setDateHeader ("Expires", 0); // Proxies.
%>
<html>
<head>
    <title>Upcoming Events</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 20px; color: #333;">

    <c:if test="${sessionScope.loggedInUser != null}">
        <p style="max-width: 800px; margin: 0 auto 20px auto; text-align: right; font-size: 16px;">
            Welcome, ${sessionScope.loggedInUser.name}!
            <a href="<c:url value='/logout' />" style="display: inline-block; padding: 8px 15px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 5px; margin-left: 10px;">Logout</a>
        </p>
    </c:if>

    <div style="max-width: 800px; margin: 20px auto; padding: 20px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">

        <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
            <a href="create-event.jsp" style="display: inline-block; padding: 12px 25px; margin-bottom: 25px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; font-size: 16px;">Create a New Event</a>
        </c:if>

        <h1 style="color: #0056b3; text-align: center; margin-bottom: 30px; border-bottom: 2px solid #0056b3; padding-bottom: 10px;">Upcoming Events</h1>
        
        <ul style="list-style-type: none; padding: 0;">
            <c:forEach var="event" items="${eventList}">
                <li style="border-bottom: 1px solid #eee;">
                    <a href="event?id=${event.eventId}" style="display: block; padding: 15px 20px; text-decoration: none; color: #007bff; font-size: 18px;">
                        ${event.title}
                    </a>
                </li>
            </c:forEach>
        </ul>
        
    </div>
</body>
</html>