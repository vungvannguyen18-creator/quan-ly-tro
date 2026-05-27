package com.tro.controller;

import com.tro.dao.FavoriteDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Favorite;
import com.tro.entity.Room;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/favorite/toggle", "/favorites"})
public class FavoriteServlet extends HttpServlet {

    private FavoriteDAO favoriteDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        favoriteDAO = new FavoriteDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/favorites".equals(path)) {
            List<Favorite> favorites = favoriteDAO.findByUserId(user.getId());
            request.setAttribute("favorites", favorites);
            request.getRequestDispatcher("/WEB-INF/views/student/favorites.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long roomId = Long.parseLong(request.getParameter("roomId"));
        Room room = roomDAO.findById(roomId);

        if (room != null) {
            Favorite existingFav = favoriteDAO.findByUserAndRoom(user.getId(), room.getId());
            if (existingFav != null) {
                favoriteDAO.delete(existingFav.getId()); // Bỏ thích
            } else {
                Favorite newFav = new Favorite();
                newFav.setUser(user);
                newFav.setRoom(room);
                favoriteDAO.create(newFav); // Thích
            }
        }
        
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
    }
}
