<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create New Event</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 20px; color: #333;">

    <form action="createEvent" method="post" enctype="multipart/form-data" style="max-width: 500px; margin: 50px auto; padding: 25px; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); background-color: #ffffff;">

        <h1 style="text-align: center; color: #0056b3; margin-bottom: 30px;">Create a New Event</h1>

        <p style="margin-bottom: 15px; color: #555;">Title:
            <input type="text" name="title" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p style="margin-bottom: 15px; color: #555;">Description:
            <textarea name="description" rows="5" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px; font-family: Arial, sans-serif;"></textarea>
        </p>

        <p style="margin-bottom: 15px; color: #555;">Date and Time:
            <input type="datetime-local" name="eventDatetime" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p style="margin-bottom: 15px; color: #555;">Venue:
            <input type="text" name="venue" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p style="margin-bottom: 20px; color: #555;">Category:
            <select name="categoryId" style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
                <option value="1">Technology</option>
                <option value="2">Cultural</option>
                <option value="3">Sports</option>
                <option value="4">Workshop</option>
            </select>
        </p>

        <p style="margin-bottom: 25px; color: #555;">Banner Image:
            <input type="file" name="image" style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
        </p>

        <p>
            <input type="submit" value="Create Event" style="width: 100%; padding: 12px; background-color: #007BFF; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
        </p>

    </form>

</body>
</html>