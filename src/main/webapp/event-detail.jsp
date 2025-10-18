<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>${event.title}</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 20px; color: #333;">

<div style="max-width: 800px; margin: 20px auto; padding: 30px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">

    <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" style="width: 100%; height: auto; border-radius: 8px; margin-bottom: 20px;">

    <h1 style="color: #0056b3; margin-top: 0; margin-bottom: 10px;">${event.title}</h1>
    <p style="font-size: 1.1em; color: #555; margin: 5px 0;"><strong>Hosted by:</strong> ${event.organizerName}</p>
    <p style="font-size: 1.1em; color: #555; margin: 5px 0;"><strong>Category:</strong> ${event.categoryName}</p>
    <p style="font-size: 1.1em; color: #555; margin: 5px 0;"><strong>When:</strong> ${event.eventDatetime}</p>
    <p style="font-size: 1.1em; color: #555; margin: 5px 0 20px 0;"><strong>Where:</strong> ${event.venue}</p>

    <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'attendee'}">
        <c:choose>
            <c:when test="${isUserRegistered}">
                <form action="unregisterForEvent" method="post" style="display:inline;">
                    <input type="hidden" name="eventId" value="${event.eventId}">
                    <input type="submit" value="Unregister from this Event" style="padding: 12px 25px; font-size: 16px; color: #333; background-color: #ffc107; border: none; border-radius: 5px; cursor: pointer;">
                </form>
            </c:when>
            <c:otherwise>
                <form action="registerForEvent" method="post" style="display:inline;">
                    <input type="hidden" name="eventId" value="${event.eventId}">
                    <input type="submit" value="Register for this Event" style="padding: 12px 25px; font-size: 16px; color: white; background-color: #28a745; border: none; border-radius: 5px; cursor: pointer;">
                </form>
            </c:otherwise>
        </c:choose>
    </c:if>

    <hr style="border: 0; height: 1px; background-color: #eee; margin: 30px 0;">
    
    <h2 style="color: #333; border-bottom: 2px solid #eee; padding-bottom: 10px;">Details</h2>
    <p style="line-height: 1.6; font-size: 16px;">${event.description}</p>

    <hr style="border: 0; height: 1px; background-color: #eee; margin: 30px 0;">
    
    <h2 style="color: #333; border-bottom: 2px solid #eee; padding-bottom: 10px;">Who's Going? (${attendeeList.size()})</h2>
    
    <c:if test="${not empty attendeeList}">
        <ul style="list-style-type: none; padding: 0;">
            <c:forEach var="attendee" items="${attendeeList}">
                <li style="padding: 10px; border-bottom: 1px solid #f0f0f0; font-size: 16px;">${attendee.name}</li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty attendeeList}">
        <p style="font-style: italic; color: #777;">No one has registered yet. Be the first!</p>
    </c:if>
    
    <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.id == event.organizerId}">
        <hr style="border: 0; height: 1px; background-color: #eee; margin: 30px 0;">
        <div style="margin-top: 20px; text-align: right;">
            <a href="<c:url value='/editEvent?id=${event.eventId}' />" style="display: inline-block; text-decoration: none; padding: 10px 20px; background-color: #007bff; color: white; border-radius: 5px; margin-right: 10px;">Edit Event</a>
            <a href="<c:url value='/deleteEvent?id=${event.eventId}' />" style="display: inline-block; text-decoration: none; padding: 10px 20px; background-color: #dc3545; color: white; border-radius: 5px;">Delete Event</a>
        </div>
    </c:if>

</div>

</body>
</html>