package com.tro.controller;

import com.tro.dao.RoomDAO;
import com.tro.entity.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/room-detail"})
public class HomeServlet extends HttpServlet {
    
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        if ("/home".equals(path)) {
            String keyword = request.getParameter("keyword");
            String address = request.getParameter("address");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            
            // Phase 4 parameters
            Boolean hasWifi = request.getParameter("hasWifi") != null;
            Boolean hasAirConditioner = request.getParameter("hasAirConditioner") != null;
            Boolean hasParking = request.getParameter("hasParking") != null;
            String genderAllowed = request.getParameter("genderAllowed");

            Double minPrice = null;
            Double maxPrice = null;

            try {
                if (minPriceStr != null && !minPriceStr.isEmpty()) minPrice = Double.parseDouble(minPriceStr);
                if (maxPriceStr != null && !maxPriceStr.isEmpty()) maxPrice = Double.parseDouble(maxPriceStr);
            } catch (NumberFormatException e) {
                // ignore
            }

            List<Room> rooms;
            if (keyword != null || address != null || minPrice != null || maxPrice != null || hasWifi || hasAirConditioner || hasParking || genderAllowed != null) {
                rooms = roomDAO.searchRooms(keyword, minPrice, maxPrice, address, hasWifi, hasAirConditioner, hasParking, genderAllowed);
            } else {
                rooms = roomDAO.findAllActive();
            }

            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
            
        } else if ("/room-detail".equals(path)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    Long id = Long.parseLong(idStr);
                    Room room = roomDAO.findById(id);
                    if (room != null && room.getStatus()) {
                        request.setAttribute("room", room);
                        
                        // Fetch reviews
                        com.tro.dao.ReviewDAO reviewDAO = new com.tro.dao.ReviewDAO();
                        request.setAttribute("reviews", reviewDAO.findByRoomId(id));
                        request.setAttribute("averageRating", reviewDAO.getAverageRatingByRoomId(id));
                        
                        // Check if favorite
                        com.tro.entity.User user = (com.tro.entity.User) request.getSession().getAttribute("user");
                        if (user != null) {
                            com.tro.dao.FavoriteDAO favDAO = new com.tro.dao.FavoriteDAO();
                            com.tro.entity.Favorite fav = favDAO.findByUserAndRoom(user.getId(), id);
                            request.setAttribute("isFavorite", fav != null);
                        }
                        
                        // Phase 6: AI Recommendations
                        List<Room> recommendations = roomDAO.getRecommendations(room, 4);
                        request.setAttribute("recommendations", recommendations);
                        
                        request.getRequestDispatcher("/WEB-INF/views/room-detail.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
