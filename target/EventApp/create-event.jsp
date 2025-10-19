<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create New Event</title>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; padding: 40px;">

    <div style="display: flex; justify-content: center; align-items: flex-start; gap: 40px;">

        <div id="imagePreviewContainer" style="width: 350px; height: 500px; background-color: #ffeb3b; color: #111; border-radius: 16px; padding: 30px; box-sizing: border-box; display: flex; flex-direction: column; justify-content: space-between; position: relative; overflow: hidden;">
            <div id="defaultPreviewContent">
                <div style="font-size: 3em; font-weight: bold; line-height: 1.1;">
                    YOU'RE<br>ON THE<br>GUEST-<br>LIST*
                </div>
                <div style="font-size: 1.2em; text-align: right; font-weight: 500;">
                    *HOW<br>LUCKY<br>YOU<br>ARE
                </div>
            </div>
            <img id="imagePreview" src="#" alt="Event Banner Preview" style="display: none; position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 16px;">
        </div>

        <div class="form-container" style="max-width: 500px; width: 100%;">
            <form action="createEvent" method="post" enctype="multipart/form-data">

                <input type="text" name="title" required placeholder="Event Name" style="width: 100%; padding: 10px 0; margin-bottom: 25px; background-color: transparent; border: none; border-bottom: 2px solid #444; color: #ffffff; font-size: 2.5em; font-weight: bold; box-sizing: border-box;">

                <div style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; padding: 20px;">

                    <c:if test="${not empty sessionScope.createEventError}">
                        <p style="color: #ff8a80; text-align: center; background-color: rgba(255, 138, 128, 0.1); padding: 10px; border-radius: 8px; border: 1px solid #ff8a80; margin-bottom: 20px;">
                            ${sessionScope.createEventError}
                        </p>
                        <c:remove var="createEventError" scope="session"/> </c:if>
                
                    <div style="margin-bottom: 20px;">
                        <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Date and Time</label>
                        <input type="datetime-local" name="eventDatetime" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Location</label>
                        <input type="text" name="venue" id="venueInput" required placeholder="Offline location or virtual link" style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                        
                        <div id="map" style="width: 100%; height: 250px; margin-top: 15px; border-radius: 8px; background-color: #2a2a2a;"></div>
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Description</label>
                        <textarea name="description" rows="5" required placeholder="Add more details about your event..." style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box; font-family: inherit;"></textarea>
                    </div>
                    
                    <div style="margin-bottom: 20px;">
                         <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Category</label>
                         <select name="categoryId" style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                            <option value="1">Technology</option>
                            <option value="4">Cultural</option>
                            <option value="3">Sports</option>
                            <option value="5">Workshop</option>
                            <option value="2">Music</option>
                        </select>
                    </div>

                    <div>
                         <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Banner Image</label>
                         <input type="file" name="image" id="imageUpload" style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                    </div>
                </div>

                <input type="submit" value="Create Event" style="width: 100%; padding: 15px; margin-top: 25px; background-color: #f0f0f0; color: #111; border: none; border-radius: 8px; font-size: 1.1em; font-weight: bold; cursor: pointer;">

            </form>
        </div>
    </div>

    <script>
        const imageUpload = document.getElementById('imageUpload');
        const imagePreview = document.getElementById('imagePreview');
        const defaultPreviewContent = document.getElementById('defaultPreviewContent');
        const imagePreviewContainer = document.getElementById('imagePreviewContainer');

        imageUpload.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                    defaultPreviewContent.style.display = 'none';
                    imagePreviewContainer.style.backgroundColor = 'transparent';
                };
                reader.readAsDataURL(file);
            } else {
                imagePreview.src = '#';
                imagePreview.style.display = 'none';
                defaultPreviewContent.style.display = 'flex';
                imagePreviewContainer.style.backgroundColor = '#ffeb3b';
            }
        });
    </script>

    <script>
        let map;
        let marker;
        let geocoder;
        let timeout;

        function initMap() {
            const defaultLocation = { lat: 20.5937, lng: 78.9629 };
            geocoder = new google.maps.Geocoder();
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 5,
                center: defaultLocation,
                styles: [ { elementType: "geometry", stylers: [{ color: "#242f3e" }] }, { elementType: "labels.text.stroke", stylers: [{ color: "#242f3e" }] }, { elementType: "labels.text.fill", stylers: [{ color: "#746855" }] }, { featureType: "administrative.locality", elementType: "labels.text.fill", stylers: [{ color: "#d59563" }] }, { featureType: "poi", elementType: "labels.text.fill", stylers: [{ color: "#d59563" }] }, { featureType: "road", elementType: "geometry", stylers: [{ color: "#38414e" }] }, { featureType: "road", elementType: "geometry.stroke", stylers: [{ color: "#212a37" }] }, { featureType: "road", elementType: "labels.text.fill", stylers: [{ color: "#9ca5b3" }] }, { featureType: "transit", elementType: "geometry", stylers: [{ color: "#2f3948" }] }, { featureType: "water", elementType: "geometry", stylers: [{ color: "#17263c" }] }, { featureType: "water", elementType: "labels.text.fill", stylers: [{ color: "#515c6d" }] }, ]
            });
            marker = new google.maps.Marker({ map: map });
        }

        const venueInput = document.getElementById('venueInput');

        venueInput.addEventListener('input', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                geocodeAddress(venueInput.value);
            }, 1000);
        });

        function geocodeAddress(address) {
            if (!address) return;
            geocoder.geocode({ 'address': address }, function(results, status) {
                if (status === 'OK') {
                    map.setCenter(results[0].geometry.location);
                    map.setZoom(15);
                    marker.setPosition(results[0].geometry.location);
                } else {
                    console.error('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>
    
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>

</body>
</html>