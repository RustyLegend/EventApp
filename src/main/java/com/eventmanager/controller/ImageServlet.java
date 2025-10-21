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
    private static final Path UPLOAD_DIRECTORY = Paths.get(System.getProperty("user.home"), "event-images");
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestedFile = request.getPathInfo();
        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        Path filePath = UPLOAD_DIRECTORY.resolve(requestedFile.substring(1)).normalize();
        File file = filePath.toFile();
        if (!file.getAbsolutePath().startsWith(UPLOAD_DIRECTORY.toAbsolutePath().toString())) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!file.exists() || file.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String contentType = getServletContext().getMimeType(file.getName());
        response.setContentType(contentType);
        response.setContentLength((int) file.length());
        Files.copy(file.toPath(), response.getOutputStream());
    }
}