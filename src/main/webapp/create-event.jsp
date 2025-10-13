<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create New Event</title>
</head>
<body>
    <h1>Create a New Event</h1>
    <form action="createEvent" method="post" enctype="multipart/form-data">
        <p>Title: <input type="text" name="title" required></p>
        <p>Description: <textarea name="description" rows="5" cols="30" required></textarea></p>
        <p>Date and Time: <input type="datetime-local" name="eventDatetime" required></p>
        <p>Venue: <input type="text" name="venue" required></p>
        <p>Category:
            <select name="categoryId">
                <option value="1">Technology</option>
                <option value="2">Cultural</option>
                <option value="3">Sports</option>
                <option value="4">Workshop</option>
            </select>
        </p>
        <p>Banner Image: <input type="file" name="image"></p>
        <p><input type="submit" value="Create Event"></p>
    </form>
</body>
</html>