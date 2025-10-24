<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Page caching headers (still good to keep for the HTML page itself)
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>Discover Events</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* Animation keyframes removed */

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            -webkit-tap-highlight-color: transparent; /* Removes blue tap highlight */
        }

        .main-content {
            padding: 20px;
            box-sizing: border-box;
            width: 100%;
            /* Animation and opacity properties removed */
        }

        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        /* --- Mobile Styles (Default) --- */

        .hamburger-btn {
            background: none;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            padding: 10px;
            z-index: 500;
        }

        .desktop-hello {
            display: none; /* Hide "Hello" text on mobile */
        }

        .close-sidebar-btn {
            display: inline-block; /* Show close button on mobile */
        }

        /* Sidebar styles for mobile (slide-out) */
        .sidebar {
            width: 280px;
            background-color: rgba(30, 30, 30, 0.9); /* Semi-transparent */
            backdrop-filter: blur(8px);
            border-right: 1px solid #333;
            padding: 20px;
            box-sizing: border-box;
            height: 100vh;
            position: fixed; /* Fixed position to overlay content */
            top: 0;
            left: 0;
            z-index: 1000;
            transform: translateX(-100%); /* Hide it off-screen */
            transition: transform 0.3s ease-in-out; /* Slide Animation */
        }

        .sidebar-open {
            transform: translateX(0);
        }

        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .sidebar-overlay-open {
            display: block;
        }

        /* --- Desktop Styles (Overrides) --- */
        @media (min-width: 769px) {
            .main-flex-container {
                display: flex;
                align-items: flex-start;
            }

            .hamburger-btn {
                display: none;
            }

            .desktop-hello {
                display: inline-block;
            }

            .main-content {
                flex-grow: 1;
                min-width: 0;
            }

            .sidebar {
                position: sticky !important;
                transform: translateX(0) !important;
                background-color: #1e1e1e !important;
                backdrop-filter: none !important;
                z-index: 1 !important;
                height: 100vh !important;
            }

            .close-sidebar-btn {
                display: none;
            }

            .sidebar-overlay {
                display: none !important;
            }
        }
    </style>
</head>
<body>

    <div class="main-flex-container">

        <c:if test="${sessionScope.loggedInUser.role == 'attendee'}">
            <jsp:include page="sidebar.jsp" />
            <div id="sidebarOverlay" class="sidebar-overlay"></div>
        </c:if>

        <div class="main-content">

            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding: 10px 0;">

                <div>
                    <c:if test="${sessionScope.loggedInUser.role == 'attendee'}">
                        <button id="openSidebarBtn" class="hamburger-btn">&#9776;</button>
                    </c:if>

                    <c:if test="${not empty sessionScope.loggedInUser}">
                        <span class="desktop-hello" style="font-size: 1.5em; font-weight: bold; color: #ffffff;">Hello, ${sessionScope.loggedInUser.name}!</span>
                    </c:if>
                </div>

                <div>
                    <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
                        <a href="dashboard" style="text-decoration: none; color: #bbbbbb; font-weight: 500; margin-right: 20px;">My Dashboard</a>
                    </c:if>
                    <c:if test="${sessionScope.loggedInUser.role == 'organizer'}">
                        <a href="create-event.jsp" style="text-decoration: none; color: #bbbbbb; font-weight: 500; margin-right: 20px;">Create Event</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.loggedInUser}">
                        <a href="<c:url value='/logout' />" style="display: inline-block; padding: 8px 18px; background-color: #2a2a2a; color: #ffffff; text-decoration: none; border-radius: 20px; font-weight: 500; border: 1px solid #444;">Logout</a>
                    </c:if>
                </div>
            </div>

            <div style="text-align: center; margin-bottom: 40px;">
                 <h1 style="font-size: 3em; color: #ffffff; margin: 0;">Find your next experience</h1>
                 <p style="font-size: 1.2em; color: #aaaaaa; margin-top: 10px;">Events hosted by the community, for the community.</p>
            </div>

            <div class="events-container">
                <c:forEach var="event" items="${eventList}">
                    <div class="event-card"
                         style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.3); overflow: hidden; text-decoration: none; color: #e0e0e0; transition: all 0.2s ease-in-out;"
                         onmouseover="this.style.transform='translateY(-5px)'; this.style.borderColor='#555';"
                         onmouseout="this.style.transform='translateY(0)'; this.style.borderColor='#333';">

                        <a href="<c:url value='/event?id=${event.eventId}' />" style="display: block; position: relative;">
                            <img src="<c:url value='/event-images/${event.imageUrl}' />" alt="${event.title}" style="width: 100%; height: 300px; object-fit: cover; display: block; border-bottom: 1px solid #333;">
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
    </div>

    <script>
        if (document.getElementById('sidebar')) {
            const sidebar = document.getElementById('sidebar');
            const openBtn = document.getElementById('openSidebarBtn');
            const closeBtn = document.getElementById('closeSidebarBtn');
            const overlay = document.getElementById('sidebarOverlay');

            function openSidebar() {
                sidebar.classList.add('sidebar-open');
                overlay.classList.add('sidebar-overlay-open');
            }

            function closeSidebar() {
                sidebar.classList.remove('sidebar-open');
                overlay.classList.remove('sidebar-overlay-open');
            }

            openBtn.addEventListener('click', openSidebar);
            closeBtn.addEventListener('click', closeSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    </script>

    <script>
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                window.location.reload();
            }
        });
    </script>
</body>
</html>