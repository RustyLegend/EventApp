<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>${event.title}</title>
</head>
<body>
    <h1>${event.title}</h1>
    <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" width="500">
    <p><strong>Hosted by:</strong> ${event.organizerName}</p>
    <p><strong>Category:</strong> ${event.categoryName}</p>
    <p><strong>When:</strong> ${event.eventDatetime}</p>
    <p><strong>Where:</strong> ${event.venue}</p>

    <hr>

    <h2>Details</h2>
    <p>${event.description}</p>
    <hr>
    <a href="<c:url value='/editEvent?id=${event.eventId}' />">Edit This Event</a>
    <a href="<c:url value='/deleteEvent?id=${event.eventId}' />">Delete This Event</a>
</body>
</html>