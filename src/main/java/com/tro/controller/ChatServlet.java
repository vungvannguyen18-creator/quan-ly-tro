package com.tro.controller;

import com.tro.dao.ConversationDAO;
import com.tro.dao.MessageDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Conversation;
import com.tro.entity.Message;
import com.tro.entity.Room;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/chat", "/chat/send"})
public class ChatServlet extends HttpServlet {

    private ConversationDAO conversationDAO;
    private MessageDAO messageDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        conversationDAO = new ConversationDAO();
        messageDAO = new MessageDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        if ("/chat".equals(path)) {
            // Lấy danh sách hội thoại của user
            List<Conversation> conversations = conversationDAO.findByUserId(user.getId());
            request.setAttribute("conversations", conversations);

            // Nếu user click từ phòng trọ -> tạo hoặc lấy hội thoại
            String roomIdStr = request.getParameter("roomId");
            Long activeConversationId = null;

            if (roomIdStr != null && user.getRole().equals("STUDENT")) {
                Long roomId = Long.parseLong(roomIdStr);
                Room room = roomDAO.findById(roomId);
                
                if (room != null) {
                    Conversation conv = conversationDAO.findByStudentAndRoom(user.getId(), roomId);
                    if (conv == null) {
                        conv = new Conversation();
                        conv.setStudent(user);
                        conv.setLandlord(room.getOwner());
                        conv.setRoom(room);
                        conversationDAO.create(conv);
                        conversations.add(0, conv); // Thêm lên đầu
                    }
                    activeConversationId = conv.getId();
                }
            } else {
                String convIdStr = request.getParameter("id");
                if (convIdStr != null) {
                    activeConversationId = Long.parseLong(convIdStr);
                } else if (!conversations.isEmpty()) {
                    activeConversationId = conversations.get(0).getId();
                }
            }

            if (activeConversationId != null) {
                Conversation activeConv = conversationDAO.findById(activeConversationId);
                // Kiểm tra quyền truy cập hội thoại
                if (activeConv != null && (activeConv.getStudent().getId().equals(user.getId()) || activeConv.getLandlord().getId().equals(user.getId()))) {
                    List<Message> messages = messageDAO.findByConversationId(activeConversationId);
                    request.setAttribute("activeConversation", activeConv);
                    request.setAttribute("messages", messages);
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/chat.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if ("/chat/send".equals(path)) {
            Long conversationId = Long.parseLong(request.getParameter("conversationId"));
            String content = request.getParameter("content");

            Conversation conv = conversationDAO.findById(conversationId);
            if (conv != null && (conv.getStudent().getId().equals(user.getId()) || conv.getLandlord().getId().equals(user.getId()))) {
                if (content != null && !content.trim().isEmpty()) {
                    Message msg = new Message();
                    msg.setConversation(conv);
                    msg.setSender(user);
                    msg.setContent(content.trim());
                    messageDAO.create(msg);
                    
                    // Trigger preUpdate for updatedAt
                    conversationDAO.update(conv); 
                }
            }
            response.sendRedirect(request.getContextPath() + "/chat?id=" + conversationId);
        }
    }
}
