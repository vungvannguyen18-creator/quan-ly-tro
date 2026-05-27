package com.tro.controller;

import com.tro.dao.CategoryDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Category;
import com.tro.entity.Room;
import com.tro.entity.User;
import com.tro.util.UploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/landlord/rooms", "/landlord/room/add", "/landlord/room/edit", "/landlord/room/delete"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class RoomServlet extends HttpServlet {

    private RoomDAO roomDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if ("/landlord/rooms".equals(path)) {
            List<Room> rooms = roomDAO.findByOwnerId(user.getId());
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/WEB-INF/views/landlord/rooms.jsp").forward(request, response);
            
        } else if ("/landlord/room/add".equals(path)) {
            request.setAttribute("categories", categoryDAO.findAll());
            request.getRequestDispatcher("/WEB-INF/views/landlord/room-form.jsp").forward(request, response);
            
        } else if ("/landlord/room/edit".equals(path)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Room room = roomDAO.findById(id);
            if (room != null && room.getOwner().getId().equals(user.getId())) {
                request.setAttribute("room", room);
                request.setAttribute("categories", categoryDAO.findAll());
                request.getRequestDispatcher("/WEB-INF/views/landlord/room-form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/landlord/rooms");
            }
        } else if ("/landlord/room/delete".equals(path)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Room room = roomDAO.findById(id);
            if (room != null && room.getOwner().getId().equals(user.getId())) {
                room.setStatus(false); // Soft delete / ẩn
                roomDAO.update(room);
            }
            response.sendRedirect(request.getContextPath() + "/landlord/rooms");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        String title = request.getParameter("title");
        Double price = Double.parseDouble(request.getParameter("price"));
        Double area = Double.parseDouble(request.getParameter("area"));
        String address = request.getParameter("address");
        String description = request.getParameter("description");
        Long categoryId = Long.parseLong(request.getParameter("categoryId"));
        Category category = categoryDAO.findById(categoryId);

        if ("/landlord/room/add".equals(path)) {
            Room room = new Room();
            room.setTitle(title);
            room.setPrice(price);
            room.setArea(area);
            room.setAddress(address);
            room.setDescription(description);
            room.setCategory(category);
            room.setOwner(user);
            room.setStatus(true);
            
            // Phase 4 fields
            room.setLatitude(request.getParameter("latitude") != null && !request.getParameter("latitude").isEmpty() ? Double.parseDouble(request.getParameter("latitude")) : null);
            room.setLongitude(request.getParameter("longitude") != null && !request.getParameter("longitude").isEmpty() ? Double.parseDouble(request.getParameter("longitude")) : null);
            room.setHasWifi(request.getParameter("hasWifi") != null);
            room.setHasAirConditioner(request.getParameter("hasAirConditioner") != null);
            room.setHasWashingMachine(request.getParameter("hasWashingMachine") != null);
            room.setHasParking(request.getParameter("hasParking") != null);
            room.setHasCamera(request.getParameter("hasCamera") != null);
            room.setHasGuard(request.getParameter("hasGuard") != null);
            room.setHasMezzanine(request.getParameter("hasMezzanine") != null);
            room.setGenderAllowed(request.getParameter("genderAllowed") != null ? request.getParameter("genderAllowed") : "ALL");
            
            String maxPeopleStr = request.getParameter("maxPeople");
            if (maxPeopleStr != null && !maxPeopleStr.trim().isEmpty()) {
                room.setMaxPeople(Integer.parseInt(maxPeopleStr));
            }

            Part filePart = request.getPart("image");
            String imageUrl = UploadUtil.uploadFile(request, filePart);
            if (imageUrl != null) {
                room.setImage(imageUrl);
            }

            roomDAO.create(room);
            response.sendRedirect(request.getContextPath() + "/landlord/rooms");

        } else if ("/landlord/room/edit".equals(path)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Room room = roomDAO.findById(id);
            
            if (room != null && room.getOwner().getId().equals(user.getId())) {
                room.setTitle(title);
                room.setPrice(price);
                room.setArea(area);
                room.setAddress(address);
                room.setDescription(description);
                room.setCategory(category);
                
                // Phase 4 fields
                room.setLatitude(request.getParameter("latitude") != null && !request.getParameter("latitude").isEmpty() ? Double.parseDouble(request.getParameter("latitude")) : null);
                room.setLongitude(request.getParameter("longitude") != null && !request.getParameter("longitude").isEmpty() ? Double.parseDouble(request.getParameter("longitude")) : null);
                room.setHasWifi(request.getParameter("hasWifi") != null);
                room.setHasAirConditioner(request.getParameter("hasAirConditioner") != null);
                room.setHasWashingMachine(request.getParameter("hasWashingMachine") != null);
                room.setHasParking(request.getParameter("hasParking") != null);
                room.setHasCamera(request.getParameter("hasCamera") != null);
                room.setHasGuard(request.getParameter("hasGuard") != null);
                room.setHasMezzanine(request.getParameter("hasMezzanine") != null);
                room.setGenderAllowed(request.getParameter("genderAllowed") != null ? request.getParameter("genderAllowed") : "ALL");

                String maxPeopleStr = request.getParameter("maxPeople");
                if (maxPeopleStr != null && !maxPeopleStr.trim().isEmpty()) {
                    room.setMaxPeople(Integer.parseInt(maxPeopleStr));
                }

                String statusStr = request.getParameter("status");
                room.setStatus(statusStr != null && statusStr.equals("true"));

                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String imageUrl = UploadUtil.uploadFile(request, filePart);
                    if (imageUrl != null) {
                        room.setImage(imageUrl);
                    }
                }

                roomDAO.update(room);
            }
            response.sendRedirect(request.getContextPath() + "/landlord/rooms");
        }
    }
}
