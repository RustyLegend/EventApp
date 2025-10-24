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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* Animation Keyframes */
        @keyframes fadeInRise {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
            -webkit-tap-highlight-color: transparent;
        }

        .event-detail-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
            /* Applying the animation */
            animation: fadeInRise 0.6s ease-out forwards;
            opacity: 0; /* Start invisible */
        }

        .image-column {
            width: 40%;
            max-width: 450px;
            flex-shrink: 0;
        }

        .details-column {
            width: 60%;
            min-width: 0; /* Prevents text overflow issues */
        }

        @media (max-width: 768px) {
            .event-detail-container {
                flex-direction: column;
                align-items: center;
            }

            .image-column {
                width: 100%;
            }

            .details-column {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <div class="event-detail-container">

        <div class="image-column">
            <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" style="width: 100%; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
        </div>

        <div class="details-column">

            <c:if test="${param.action == 'registered'}">
                <p style="color: #4CAF50; background-color: rgba(76, 175, 80, 0.1); padding: 10px; border-radius: 8px; border: 1px solid #4CAF50; text-align: center; margin-bottom: 20px;">
                    Successfully registered for this event!
                </p>
            </c:if>
            <c:if test="${param.action == 'unregistered'}">
                <p style="color: #ffc107; background-color: rgba(255, 193, 7, 0.1); padding: 10px; border-radius: 8px; border: 1px solid #ffc107; text-align: center; margin-bottom: 20px;">
                    Successfully unregistered from this event.
                </p>
            </c:if>
            <p style="font-size: 1em; color: #bb86fc; font-weight: 500; margin: 0 0 5px 0;">${event.categoryName}</p>
            <h1 style="color: #ffffff; margin-top: 0; margin-bottom: 15px; font-size: 2.8em; line-height: 1.2;">${event.title}</h1>

            <div style="font-size: 1.1em; color: #aaaaaa; margin-bottom: 25px;">
                <p style="margin: 5px 0;"><strong>When:</strong> ${event.eventDatetime}</p>
                <p style="margin: 5px 0;"><strong>Where:</strong> ${event.venue}</p>
                <p style="margin: 5px 0;"><strong>Hosted by:</strong> ${event.organizerName}</p>
            </div>

            <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'attendee'}">
                <c:choose>
                    <c:when test="${isUserRegistered}">
                        <form action="unregisterForEvent" method="post" style="display:inline;">
                            <input type="hidden" name="eventId" value="${event.eventId}">
                            <input type="submit" value="Unregister" style="padding: 12px 25px; font-size: 1em; color: #111; background-color: #ffc107; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="registerForEvent" method="post" style="display:inline;">
                            <input type="hidden" name="eventId" value="${event.eventId}">
                            <input type="submit" value="Register for this Event" style="padding: 12px 25px; font-size: 1em; color: white; background-color: #28a745; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <hr style="border: 0; height: 1px; background-color: #333; margin: 30px 0;">

            <h2 style="color: #ffffff;">Details</h2>
            <p style="line-height: 1.6; font-size: 1em; color: #aaaaaa;">${event.description}</p>

            <hr style="border: 0; height: 1px; background-color: #333; margin: 30px 0;">

            <h2 style="color: #ffffff;">Who's Going? (${attendeeList.size()})</h2>

            <c:if test="${not empty attendeeList}">
                <ul style="list-style-type: none; padding: 0;">
                    <c:forEach var="attendee" items="${attendeeList}">
                        <li style="padding: 10px 0; border-bottom: 1px solid #333; font-size: 1em; color: #e0e0e0;">${attendee.name}</li>
                    </c:forEach>
                </ul>
            </c:if>

            <c:if test="${empty attendeeList}">
                <p style="font-style: italic; color: #777;">No one has registered yet. Be the first!</p>
            </c:if>

            <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.id == event.organizerId}">
                <hr style="border: 0; height: 1px; background-color: #333; margin: 30px 0;">
                <div style="margin-top: 20px; text-align: left;">
                    <a href="<c:url value='/editEvent?id=${event.eventId}' />" style="display: inline-block; text-decoration: none; padding: 10px 20px; background-color: #007bff; color: white; border-radius: 8px; margin-right: 10px; font-weight: 500;">Edit Event</a>
                    <a href="<c:url value='/deleteEvent?id=${event.eventId}' />" style="display: inline-block; text-decoration: none; padding: 10px 20px; background-color: #dc3545; color: white; border-radius: 8px; font-weight: 500;">Delete Event</a>
                </div>
            </c:if>
        </div>
    </div>
    </body>
</html>