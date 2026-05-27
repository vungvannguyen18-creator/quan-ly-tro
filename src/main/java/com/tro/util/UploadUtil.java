package com.tro.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

public class UploadUtil {
    
    public static final String UPLOAD_DIR = "uploads";

    public static String uploadFile(HttpServletRequest request, Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = getFileName(part);
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i);
        }

        String newFileName = UUID.randomUUID().toString() + extension;
        String filePath = uploadFilePath + File.separator + newFileName;

        part.write(filePath);
        
        return UPLOAD_DIR + "/" + newFileName;
    }

    private static String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
