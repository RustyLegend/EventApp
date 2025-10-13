<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upcoming Events</title>
</head>
<body>
    <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
        <a href="create-event.jsp">Create a New Event</a>
    </c:if>
    <h1>Upcoming Events</h1>
    <ul>
        <c:forEach var="event" items="${eventList}">
            <li><a href="event?id=${event.eventId}">${event.title}</a></li>
        </c:forEach>
    </ul>
</body>
</html>