<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Security check (primarily handled by servlet, fallback here)
    com.eventmanager.model.User loggedInUser = (com.eventmanager.model.User) session.getAttribute("loggedInUser");
    if (loggedInUser == null || !"organizer".equals(loggedInUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    // Cache control headers
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>My Events Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* Animation Keyframes */
        @keyframes scaleUp {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
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

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            animation: scaleUp 0.6s ease-out forwards;
            opacity: 0;
        }

        /* --- Updated Header Styles for Responsiveness --- */
        .header {
             display: flex;
             justify-content: space-between;
             align-items: center;
             margin-bottom: 30px;
             padding: 10px 0;
             flex-wrap: wrap; /* Allows items to wrap onto the next line */
             gap: 10px; /* Adds space between wrapped items */
        }
        .header-title {
             font-size: 2.5em;
             color: #ffffff;
             margin: 0;
             flex-basis: 100%; /* Title takes full width on its own line initially */
             text-align: left; /* Ensure title stays left */
        }
        .header-actions {
             text-align: right;
             flex-grow: 1; /* Allows actions to take available space */
             width: 100%; /* Ensures it can take full width if needed */
        }
        .header-actions a {
             text-decoration: none;
             color: #bbbbbb;
             font-weight: 500;
             margin-left: 15px;
             white-space: nowrap; /* Prevents links breaking mid-word */
             display: inline-block; /* Helps with spacing */
             margin-top: 5px; /* Adds space when wrapped */
        }
        .logout-btn {
             padding: 8px 18px;
             background-color: #2a2a2a;
             color: #ffffff;
             text-decoration: none;
             border-radius: 20px;
             font-weight: 500;
             border: 1px solid #444;
             margin-left: 15px;
        }
        /* --- End of Updated Header Styles --- */

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        /* Event card styles */
        .event-card {
            background-color: #1e1e1e;
            border: 1px solid #333;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            overflow: hidden;
            text-decoration: none;
            color: #e0e0e0;
            transition: all 0.2s ease-in-out;
        }
        .event-card:hover {
            transform: translateY(-5px);
            border-color:#555;
        }
        .card-image-link {
            display: block;
            position: relative;
        }
        .card-image {
             width: 100%;
             height: 300px; /* Square images */
             object-fit: cover;
             display: block;
             border-bottom: 1px solid #333;
        }
        .date-badge {
             position: absolute;
             top: 12px; left: 12px;
             background-color: rgba(0,0,0,0.6);
             color: white;
             padding: 5px 10px;
             border-radius: 20px;
             font-size: 0.8em;
             backdrop-filter: blur(5px);
             border: 1px solid rgba(255,255,255,0.1);
        }
        .card-content {
             padding: 15px;
        }
        .card-category {
             font-size: 0.9em;
             color: #bb86fc;
             font-weight: 500;
             margin: 0 0 5px 0;
        }
        .card-title-link {
             text-decoration: none;
        }
        .card-title {
             font-size: 1.2em;
             color: #ffffff;
             margin: 0 0 8px 0;
             font-weight: 600;
        }
        .card-actions {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #333;
            text-align: right;
        }
        .card-actions a {
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 0.9em;
            margin-left: 10px;
            font-weight: 500;
        }
        .edit-link {
            background-color: #007bff;
            color: white;
        }
        .delete-link {
             background-color: #dc3545;
             color: white;
        }

        /* Smaller adjustments for mobile header */
        @media (max-width: 600px) { /* Adjust breakpoint if needed */
            .header-title {
                font-size: 2em;
            }
            .header-actions {
                 text-align: left; /* Align actions left when wrapped */
                 width: 100%;
            }
            .header-actions a {
                 margin-left: 0;
                 margin-right: 15px; /* Space between links */
            }
             .logout-btn {
                 margin-left: 0;
                 margin-right: 15px;
            }
        }

    </style>
</head>
<body>

    <div class="dashboard-container">

        <div class="header">
            <h1 class="header-title">My Events Dashboard</h1>
            <div class="header-actions">
                 <a href="create-event.jsp">+ Create New Event</a>
                 <a href="<c:url value='/logout' />" class="logout-btn">Logout</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty organizerEventList}">
                <div class="events-grid">
                    <c:forEach var="event" items="${organizerEventList}">
                        <div class="event-card">
                            <a href="<c:url value='/event?id=${event.eventId}' />" class="card-image-link">
                                <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" class="card-image">
                                <div class="date-badge">
                                    ${event.eventDatetime.toString().substring(0, 10)}
                                </div>
                            </a>
                            <div class="card-content">
                                <p class="card-category">${event.categoryName}</p>
                                <a href="<c:url value='/event?id=${event.eventId}' />" class="card-title-link">
                                    <h3 class="card-title">${event.title}</h3>
                                </a>
                                <div class="card-actions">
                                     <a href="<c:url value='/event?id=${event.eventId}' />" class="edit-link" style="background: none; border: 1px solid #555; color: #aaa;">View Details</a>
                                     <a href="<c:url value='/editEvent?id=${event.eventId}' />" class="edit-link">Edit</a>
                                     <a href="<c:url value='/deleteEvent?id=${event.eventId}' />" class="delete-link">Delete</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p style="text-align: center; font-size: 1.1em; color: #aaaaaa; margin-top: 50px;">
                    You haven't created any events yet. <a href="create-event.jsp" style="color: #bb86fc;">Create one now!</a>
                </p>
            </c:otherwise>
        </c:choose>

    </div>
</body>
</html>