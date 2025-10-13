package com.eventmanager.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/event-images/*")
public class ImageServlet extends HttpServlet {

    // This path MUST be identical to the one in CreateEventServlet
    private static final Path UPLOAD_DIRECTORY = Paths.get(System.getProperty("user.home"), "event-images");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestedFile = request.getPathInfo();

        // Check if a filename is present in the URL
        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Send 404 Not Found
            return;
        }

        // Use Path API to safely join the base directory and the requested filename
        // .normalize() helps prevent directory traversal attacks
        Path filePath = UPLOAD_DIRECTORY.resolve(requestedFile.substring(1)).normalize();
        File file = filePath.toFile();

        // Security check: ensure the resolved path is still inside the upload directory
        if (!file.getAbsolutePath().startsWith(UPLOAD_DIRECTORY.toAbsolutePath().toString())) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST); // Send 400 Bad Request
            return;
        }
        
        // Check if the file exists and is not a directory
        if (!file.exists() || file.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Send 404 Not Found
            return;
        }

        // Get the file's content type (e.g., "image/jpeg") and set it on the response
        String contentType = getServletContext().getMimeType(file.getName());
        response.setContentType(contentType);
        response.setContentLength((int) file.length());

        // Write the file's content to the response output stream
        Files.copy(file.toPath(), response.getOutputStream());
    }
}