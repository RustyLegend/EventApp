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
<body>

    <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" width="500">

    <h1>${event.title}</h1>
    <p><strong>Hosted by:</strong> ${event.organizerName}</p>
    <p><strong>Category:</strong> ${event.categoryName}</p>
    <p><strong>When:</strong> ${event.eventDatetime}</p>
    <p><strong>Where:</strong> ${event.venue}</p>

    <hr>
    
    <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'attendee'}">
        <c:choose>
            <c:when test="${isUserRegistered}">
                <form action="unregisterForEvent" method="post" style="display:inline;">
                    <input type="hidden" name="eventId" value="${event.eventId}">
                    <input type="submit" value="Unregister from this Event">
                </form>
            </c:when>
            <c:otherwise>
                <form action="registerForEvent" method="post" style="display:inline;">
                    <input type="hidden" name="eventId" value="${event.eventId}">
                    <input type="submit" value="Register for this Event">
                </form>
            </c:otherwise>
        </c:choose>
    </c:if>

    <h2>Details</h2>
    <p>${event.description}</p>

    <hr>
    <h2>Who's Going? (${attendeeList.size()})</h2>
    
    <c:if test="${not empty attendeeList}">
        <ul>
            <c:forEach var="attendee" items="${attendeeList}">
                <li>${attendee.name}</li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty attendeeList}">
        <p>No one has registered yet. Be the first!</p>
    </c:if>
    
    <hr>

    <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.id == event.organizerId}">
        <a href="<c:url value='/editEvent?id=${event.eventId}' />">Edit This Event</a>
        <a href="<c:url value='/deleteEvent?id=${event.eventId}' />">Delete This Event</a>
    </c:if>

</body>
</html>