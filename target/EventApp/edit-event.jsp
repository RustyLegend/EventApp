<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Event</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 20px; color: #333;">

    <form action="editEvent" method="post" style="max-width: 500px; margin: 50px auto; padding: 25px; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); background-color: #ffffff;">

        <h1 style="text-align: center; color: #0056b3; margin-bottom: 30px;">Edit Event</h1>

        <input type="hidden" name="eventId" value="${event.eventId}">

        <p style="margin-bottom: 15px; color: #555;">Title:
            <input type="text" name="title" value="${event.title}" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p style="margin-bottom: 15px; color: #555;">Description:
            <textarea name="description" rows="5" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px; font-family: Arial, sans-serif;">${event.description}</textarea>
        </p>

        <p style="margin-bottom: 15px; color: #555;">Date and Time:
            <input type="datetime-local" name="eventDatetime" value="${event.eventDatetime}" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p style="margin-bottom: 25px; color: #555;">Venue:
            <input type="text" name="venue" value="${event.venue}" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p>
            <input type="submit" value="Save Changes" style="width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
        </p>

    </form>

</body>
</html>