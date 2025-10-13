<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Event</title>
</head>
<body>
    <h1>Edit Event</h1>
    <form action="editEvent" method="post">
        <input type="hidden" name="eventId" value="${event.eventId}">

        <p>Title: <input type="text" name="title" value="${event.title}" required></p>
        <p>Description: <textarea name="description" rows="5" cols="30" required>${event.description}</textarea></p>
        <p>Date and Time: <input type="datetime-local" name="eventDatetime" value="${event.eventDatetime}" required></p>
        <p>Venue: <input type="text" name="venue" value="${event.venue}" required></p>

        <p><input type="submit" value="Save Changes"></p>
    </form>
</body>
</html>