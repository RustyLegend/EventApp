<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create New Event</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; 
            background-color: #121212; 
            color: #e0e0e0; 
            margin: 0; 
            padding: 20px; /* Added padding for mobile */
            box-sizing: border-box;
        }
        
        .create-event-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 40px;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .preview-column {
            width: 350px; 
            height: 500px; 
            background-color: #ffeb3b; 
            color: #111; 
            border-radius: 16px; 
            padding: 30px; 
            box-sizing: border-box; 
            display: flex; 
            flex-direction: column; 
            justify-content: space-between; 
            position: relative; 
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .form-column {
            max-width: 500px;
            width: 100%;
        }
        
        /* --- 3. THIS IS THE MOBILE FIX --- */
        @media (max-width: 768px) {
            .create-event-container {
                /* Stacks the columns vertically */
                flex-direction: column;
                align-items: center; /* Centers them */
                gap: 20px;
            }
            
            .preview-column {
                width: 100%; /* Makes preview full-width */
                max-width: 350px; /* But not too wide */
                height: auto; /* Lets height be automatic */
                aspect-ratio: 350 / 500; /* Keeps the original shape */
            }
            
            .form-column {
                width: 100%; /* Makes form full-width */
            }
        }
    </style>
</head>
<body>

    <div class="create-event-container">

        <div id="imagePreviewContainer" class="preview-column">
            <div id="defaultPreviewContent">
                <div style="font-size: 2.8em; font-weight: bold; line-height: 1.1;">
                    UPLOAD<br>A<br>PHOTO<br>FOR<br>PREVIEW
                </div>
            </div>
            <img id="imagePreview" src="#" alt="Event Banner Preview" style="display: none; position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 16px;">
        </div>

        <div class="form-column">
            <form action="createEvent" method="post" enctype="multipart/form-data">

                <input type="text" name="title" required placeholder="Event Name" style="width: 100%; padding: 10px 0; margin-bottom: 25px; background-color: transparent; border: none; border-bottom: 2px solid #444; color: #ffffff; font-size: 2.5em; font-weight: bold; box-sizing: border-box;">

                <div style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; padding: 20px;">

                    <c:if test="${not empty sessionScope.createEventError}">
                        <p style="color: #ff8a80; text-align: center; background-color: rgba(255, 138, 128, 0.1); padding: 10px; border-radius: 8px; border: 1px solid #ff8a80; margin-bottom: 20px;">
                            ${sessionScope.createEventError}
                        </p>
                        <c:remove var="createEventError" scope="session"/>
                    </c:if>
                
                    <div style="margin-bottom: 20px;">
                        <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Date and Time</label>
                        <input type="datetime-local" name="eventDatetime" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Location</label>
                        <input type="text" name="venue" required placeholder="Offline location or virtual link" style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
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
</body>
</html>