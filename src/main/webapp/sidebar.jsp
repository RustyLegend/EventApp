<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar" style="width: 280px; background-color: #1e1e1e; border-right: 1px solid #333; padding: 20px; box-sizing: border-box; height: 100vh; position: sticky; top: 0; flex-shrink: 0;">
    
    <h2 style="color: #ffffff; margin-top: 0; margin-bottom: 20px; font-size: 1.2em;">My Upcoming Events</h2>

    <c:choose>
        <c:when test="${not empty myRegisteredEvents}">
            <ul style="list-style: none; padding: 0; margin: 0;">
                <c:forEach var="event" items="${myRegisteredEvents}">
                    <li style="margin-bottom: 15px;">
                        <a href="<c:url value='/event?id=${event.eventId}' />" style="text-decoration: none; display: flex; align-items: center; gap: 10px;">
                            <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px;">
                            
                            <div>
                                <div style="color: #e0e0e0; font-weight: 500; font-size: 0.9em; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 180px;">
                                    ${event.title}
                                </div>
                                <div style="color: #aaaaaa; font-size: 0.8em;">
                                    ${event.eventDatetime.toString().substring(0, 10)}
                                </div>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p style="color: #aaaaaa; font-size: 0.9em;">You haven't registered for any events yet.</p>
        </c:otherwise>
    </c:choose>

</div>