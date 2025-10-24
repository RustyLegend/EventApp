<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>Events</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        /* --- Base Styles --- */
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            line-height: 1.6;
            -webkit-tap-highlight-color: transparent;
        }
        a {
            color: #e0e0e0;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        /* --- Main Layout --- */
        .page-container {
            display: flex;
            align-items: flex-start;
        }
        .main-content {
            flex-grow: 1;
            padding: 24px 32px;
            box-sizing: border-box;
            min-width: 0;
        }

        /* --- Header Section --- */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 800px;
            margin: 0 auto 40px auto;
            flex-wrap: wrap; /* Allow wrapping */
            gap: 10px; /* Space when wrapped */
        }
        .header-left { /* Container for hamburger/title */
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .header-title {
            font-size: 2em;
            font-weight: 600;
            color: #ffffff;
            margin: 0; /* Remove default margin */
        }
        .header-actions {
            text-align: right;
            margin-left: auto; /* Push actions to the right */
        }
        .header-actions a {
            color: #bbbbbb;
            font-weight: 500;
            margin-left: 16px;
            padding: 8px 16px;
            border: 1px solid #333;
            border-radius: 8px;
            transition: background-color 0.2s ease, border-color 0.2s ease;
            white-space: nowrap;
            display: inline-block; /* Helps with spacing */
        }
        .header-actions a:hover {
            background-color: #1e1e1e;
            border-color: #555;
            color: #ffffff;
        }
        .hamburger-btn {
            background: none; border: none; color: white;
            font-size: 28px; cursor: pointer; padding: 5px; /* Adjust padding */
            z-index: 500;
            display: none; /* Hidden by default */
        }

        /* --- Events Timeline --- */
        .events-timeline {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            padding-left: 30px;
        }
        .events-timeline::before { /* Timeline line */
            content: ''; position: absolute; left: 8px; top: 10px; bottom: 10px;
            width: 2px; background-color: #2a2a2a;
        }
        .timeline-group { margin-bottom: 48px; position: relative; }
        .timeline-group::before { /* Timeline circle */
            content: ''; position: absolute; left: -23px; top: 8px;
            width: 12px; height: 12px; background-color: #e0e0e0;
            border: 2px solid #121212; border-radius: 50%; z-index: 1;
        }
        .timeline-date {
            font-size: 1.3em; font-weight: 600; color: #ffffff; margin-bottom: 24px;
        }
        .timeline-date span { font-weight: 400; color: #aaaaaa; margin-left: 8px; }

        /* --- Event Card --- */
        .event-card {
            display: flex; gap: 20px; align-items: center;
            background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px;
            padding: 16px; margin-bottom: 16px;
            transition: background-color 0.2s ease, border-color 0.2s ease;
            color: #e0e0e0;
        }
        .event-card:hover { background-color: #2a2a2a; border-color: #555; }
        .card-details { flex-grow: 1; }
        .card-time { font-size: 0.9em; font-weight: 500; color: #ffffff; margin-bottom: 12px; }
        .card-title { font-size: 1.4em; font-weight: 600; color: #ffffff; margin: 0 0 8px 0; line-height: 1.3; }
        .card-meta { font-size: 0.9em; color: #aaaaaa; margin-bottom: 4px; display: block; }
        .card-image-wrapper { width: 120px; height: 120px; flex-shrink: 0; border-radius: 8px; overflow: hidden; }
        .card-image { width: 100%; height: 100%; object-fit: cover; }

        /* --- Sidebar & Mobile --- */
        .sidebar { display: none; } /* Hidden by default */
        .close-sidebar-btn { display: none; } /* Hidden by default */

        /* Styles for mobile slide-out sidebar */
        @media (max-width: 992px) { /* Increased breakpoint for sidebar slide-out */
             .hamburger-btn { display: inline-block; } /* Show hamburger */
             .sidebar {
                display: block; /* Make sure it's displayable */
                width: 280px; background-color: rgba(30, 30, 30, 0.9);
                backdrop-filter: blur(8px); border-right: 1px solid #333;
                padding: 24px; box-sizing: border-box; height: 100vh;
                position: fixed; top: 0; left: 0; z-index: 1000;
                transform: translateX(-100%); transition: transform 0.3s ease-in-out;
                overflow-y: auto;
             }
             .sidebar-open { transform: translateX(0); }
             .close-sidebar-btn {
                display: block; background: none; border: none;
                color: #aaa; font-size: 2em; cursor: pointer; padding: 0;
                position: absolute; top: 16px; right: 20px;
             }
             .sidebar-overlay {
                display: none; position: fixed; top: 0; left: 0;
                width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;
             }
             .sidebar-overlay-open { display: block; }
             .main-content { padding: 16px; }
             .events-timeline { padding-left: 20px; }
             .timeline-group::before { left: -13px; }
             .page-header { flex-direction: row; } /* Keep row layout but allow wrap */
             .header-actions { margin-left: 0; width: auto; } /* Adjust width for wrapping */
             .header-actions a { margin-left: 10px; padding: 6px 12px; }
             .event-card { flex-direction: column-reverse; align-items: flex-start; }

             /* --- UPDATED IMAGE WRAPPER --- */
             .card-image-wrapper {
                 width: 100%;
                 height: auto; /* Remove fixed height */
                 margin-bottom: 16px;
                 aspect-ratio: 3 / 4 ; /* Maintain a common widescreen aspect ratio */
             }
             /* --- END OF UPDATE --- */

        }

        /* Desktop specific overrides (Sticky sidebar) */
        @media (min-width: 993px) { /* Corresponds to max-width above */
             .sidebar {
                 display: block !important; /* Ensure it shows */
                 position: fixed !important; transform: translateX(0) !important;
                 background-color: #1e1e1e !important; backdrop-filter: none !important;
                 z-index: 1 !important; height: 100vh !important;
                 width: 320px; border-right: 1px solid #333; padding: 24px;
                 box-sizing: border-box; flex-shrink: 0; overflow-y: auto;
             }
             .hamburger-btn { display: none !important; }
             .close-sidebar-btn { display: none !important; }
             .sidebar-overlay { display: none !important; }
        }

         /* Sidebar content styling (for both mobile and desktop) */
         .sidebar h2 { color: #ffffff; margin-top: 0; margin-bottom: 24px; font-size: 1.3em; font-weight: 600; }
         .sidebar ul { list-style: none; padding: 0; margin: 0; }
         .sidebar li { margin-bottom: 16px; }
         .sidebar a { text-decoration: none; display: flex; align-items: center; gap: 12px; padding: 8px; border-radius: 8px; transition: background-color 0.2s ease; }
         .sidebar a:hover { background-color: #2a2a2a; }
         .sidebar img { width: 45px; height: 45px; object-fit: cover; border-radius: 6px; flex-shrink: 0; }
         .sidebar .event-title { color: #e0e0e0; font-weight: 500; font-size: 0.95em; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 160px; }
         .sidebar .event-date { color: #aaaaaa; font-size: 0.8em; }
         .sidebar .no-events { color: #aaaaaa; font-size: 0.9em; font-style: italic; }

    </style>
</head>
<body>

    <div class="page-container">
        <c:if test="${sessionScope.loggedInUser.role == 'attendee'}">
            <jsp:include page="sidebar.jsp" />
            <div id="sidebarOverlay" class="sidebar-overlay"></div>
        </c:if>

        <div class="main-content">
            <header class="page-header">
                <div class="header-left">
                     <c:if test="${sessionScope.loggedInUser.role == 'attendee'}">
                        <button id="openSidebarBtn" class="hamburger-btn">&#9776;</button>
                    </c:if>
                    <h1 class="header-title">Events</h1>
                </div>
                <div class="header-actions">
                     <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
                        <a href="dashboard">Dashboard</a>
                        <a href="create-event.jsp">+ Submit Event</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.loggedInUser}">
                         <a href="<c:url value='/logout' />">Logout</a>
                    </c:if>
                </div>
            </header>

            <div class="events-timeline">
                <c:forEach var="group" items="${groupedEvents}">
                    <div class="timeline-group">
                        <h2 class="timeline-date">
                            ${fn:split(group.key, '|')[0]} <%-- Today --%>
                            <span>${fn:split(group.key, '|')[1]}</span> <%-- Friday --%>
                        </h2>
                        <c:forEach var="event" items="${group.value}">
                            <a href="<c:url value='/event?id=${event.eventId}' />" class="event-card">
                                <div class="card-details">
                                    <p class="card-time">${event.eventDatetime.toLocalTime()}</p>
                                    <h3 class="card-title">${event.title}</h3>
                                    <span class="card-meta">By ${event.organizerName}</span>
                                    <span class="card-meta">${event.venue}</span>
                                </div>
                                <div class="card-image-wrapper">
                                    <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" class="card-image">
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script>
        if (document.getElementById('sidebar')) {
            const sidebar = document.getElementById('sidebar');
            const openBtn = document.getElementById('openSidebarBtn');
            const closeBtn = document.getElementById('closeSidebarBtn'); // Ensure ID exists in sidebar.jsp
            const overlay = document.getElementById('sidebarOverlay');

            function openSidebar() {
                if (sidebar && overlay) { // Check if elements exist
                    sidebar.classList.add('sidebar-open');
                    overlay.classList.add('sidebar-overlay-open');
                }
            }
            function closeSidebar() {
                 if (sidebar && overlay) { // Check if elements exist
                    sidebar.classList.remove('sidebar-open');
                    overlay.classList.remove('sidebar-overlay-open');
                 }
            }

            if (openBtn) openBtn.addEventListener('click', openSidebar);
            if (closeBtn) closeBtn.addEventListener('click', closeSidebar);
            if (overlay) overlay.addEventListener('click', closeSidebar);
        }
    </script>
    <script>
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) { window.location.reload(); }
        });
    </script>
</body>
</html>