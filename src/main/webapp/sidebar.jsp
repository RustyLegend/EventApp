<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="sidebar" class="sidebar">
    
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #ffffff; margin-top: 0; margin-bottom: 0; font-size: 1.2em;">My Upcoming Events</h2>
        <button id="closeSidebarBtn" class="close-sidebar-btn" style="background: none; border: none; color: #aaa; font-size: 1.8em; cursor: pointer; padding: 0;">&times;</button>
    </div>

    <c:choose>
        <c:when test="${not empty myRegisteredEvents}">
            <ul style="list-style: none; padding: 0; margin: 0; overflow-y: auto; height: calc(100% - 60px);">
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