<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>Discover Events</title>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; padding: 20px;">

    <div style="max-width: 1200px; margin: 0 auto;">

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding: 10px 0;">
            <div>
                <a href="<c:url value='/home' />" style="font-size: 1.5em; font-weight: bold; color: #ffffff; text-decoration: none;">Discover</a>
            </div>
            <div>
                <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
                    <a href="create-event.jsp" style="text-decoration: none; color: #bbbbbb; font-weight: 500; margin-right: 20px;">Create Event</a>
                </c:if>
                <c:if test="${sessionScope.loggedInUser != null}">
                    <a href="<c:url value='/logout' />" style="display: inline-block; padding: 8px 18px; background-color: #2a2a2a; color: #ffffff; text-decoration: none; border-radius: 20px; font-weight: 500; border: 1px solid #444;">Logout</a>
                </c:if>
            </div>
        </div>
        
        <div style="text-align: center; margin-bottom: 40px;">
             <h1 style="font-size: 3em; color: #ffffff; margin: 0;">Upcoming Events</h1>
             <p style="font-size: 1.2em; color: #aaaaaa; margin-top: 10px;">Events hosted by the community, for the community.</p>
        </div>


        <div class="events-container" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px;">

            <c:forEach var="event" items="${eventList}">
                <div class="event-card" 
                     style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.3); overflow: hidden; text-decoration: none; color: #e0e0e0; transition: all 0.2s ease-in-out;"
                     onmouseover="this.style.transform='translateY(-5px)'; this.style.borderColor='#555';"
                     onmouseout="this.style.transform='translateY(0)'; this.style.borderColor='#333';">
                    
                    <a href="<c:url value='/event?id=${event.eventId}' />" style="display: block; position: relative;">
                        <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" style="width: 100%; height: 180px; object-fit: cover; display: block; border-bottom: 1px solid #333;">
                        
                        <div class="date-badge" style="position: absolute; top: 12px; left: 12px; background-color: rgba(0,0,0,0.6); color: white; padding: 5px 10px; border-radius: 20px; font-size: 0.8em; backdrop-filter: blur(5px); border: 1px solid rgba(255,255,255,0.1);">
                            ${event.eventDatetime.toString().substring(0, 10)}
                        </div>
                    </a>
                    
                    <div class="card-content" style="padding: 15px;">
                        <p style="font-size: 0.9em; color: #bb86fc; font-weight: 500; margin: 0 0 5px 0;">${event.categoryName}</p>
                        <a href="<c:url value='/event?id=${event.eventId}' />" style="text-decoration: none;">
                            <h3 style="font-size: 1.2em; color: #ffffff; margin: 0 0 8px 0; font-weight: 600;">${event.title}</h3>
                        </a>
                        <p style="font-size: 0.9em; color: #aaaaaa; margin: 0;">Hosted by ${event.organizerName}</p>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</body>
</html>