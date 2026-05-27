<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="layout/header.jsp"/>

<div class="container-fluid py-4" style="height: calc(100vh - 80px);">
    <div class="row h-100 bg-white rounded shadow-sm overflow-hidden">
        
        <!-- Sidebar Danh sách Chat -->
        <div class="col-md-4 col-lg-3 border-end p-0 h-100 d-flex flex-column">
            <div class="p-3 border-bottom bg-light">
                <h5 class="fw-bold m-0"><i class="bi bi-chat-dots-fill text-primary me-2"></i>Tin nhắn</h5>
            </div>
            <div class="list-group list-group-flush flex-grow-1 overflow-auto">
                <c:forEach var="conv" items="${conversations}">
                    <a href="${pageContext.request.contextPath}/chat?id=${conv.id}" 
                       class="list-group-item list-group-item-action p-3 ${not empty activeConversation and activeConversation.id == conv.id ? 'active' : ''}">
                        <div class="d-flex align-items-center">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.user.role == 'STUDENT' ? conv.landlord.fullName : conv.student.fullName}&background=random" class="rounded-circle me-3" width="50" height="50">
                            <div class="flex-grow-1 min-w-0">
                                <div class="d-flex justify-content-between align-items-baseline">
                                    <h6 class="mb-1 fw-bold text-truncate">${sessionScope.user.role == 'STUDENT' ? conv.landlord.fullName : conv.student.fullName}</h6>
                                    <small class="${not empty activeConversation and activeConversation.id == conv.id ? 'text-white-50' : 'text-muted'}"><fmt:formatDate value="${conv.updatedAt}" pattern="HH:mm dd/MM"/></small>
                                </div>
                                <p class="mb-0 small text-truncate ${not empty activeConversation and activeConversation.id == conv.id ? 'text-white-50' : 'text-muted'}">Phòng: ${conv.room.title}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
                <c:if test="${empty conversations}">
                    <div class="text-center p-4 text-muted">
                        <i class="bi bi-chat-square-text fs-1"></i>
                        <p class="mt-2">Chưa có cuộc trò chuyện nào.</p>
                    </div>
                </c:if>
            </div>
        </div>
        
        <!-- Khu vực Chat -->
        <div class="col-md-8 col-lg-9 p-0 h-100 d-flex flex-column">
            <c:choose>
                <c:when test="${not empty activeConversation}">
                    <!-- Header -->
                    <div class="p-3 border-bottom bg-light d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.user.role == 'STUDENT' ? activeConversation.landlord.fullName : activeConversation.student.fullName}&background=random" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h5 class="fw-bold m-0">${sessionScope.user.role == 'STUDENT' ? activeConversation.landlord.fullName : activeConversation.student.fullName}</h5>
                                <small class="text-muted">Quan tâm phòng: <a href="${pageContext.request.contextPath}/room-detail?id=${activeConversation.room.id}" target="_blank">${activeConversation.room.title}</a></small>
                            </div>
                        </div>
                        <a href="tel:${sessionScope.user.role == 'STUDENT' ? activeConversation.landlord.phone : activeConversation.student.phone}" class="btn btn-outline-success rounded-circle"><i class="bi bi-telephone-fill"></i></a>
                    </div>
                    
                    <!-- Nội dung Chat -->
                    <div class="flex-grow-1 overflow-auto p-4 bg-light" id="chatContainer">
                        <c:forEach var="msg" items="${messages}">
                            <div class="d-flex mb-4 ${msg.sender.id == sessionScope.user.id ? 'justify-content-end' : 'justify-content-start'}">
                                <c:if test="${msg.sender.id != sessionScope.user.id}">
                                    <img src="https://ui-avatars.com/api/?name=${msg.sender.fullName}&background=random" class="rounded-circle me-2" width="40" height="40">
                                </c:if>
                                <div class="${msg.sender.id == sessionScope.user.id ? 'bg-primary text-white' : 'bg-white border'} rounded-3 py-2 px-3 shadow-sm" style="max-width: 70%;">
                                    <p class="mb-1">${msg.content}</p>
                                    <small class="${msg.sender.id == sessionScope.user.id ? 'text-white-50' : 'text-muted'} d-block ${msg.sender.id == sessionScope.user.id ? 'text-end' : ''}" style="font-size: 0.75rem;"><fmt:formatDate value="${msg.createdAt}" pattern="HH:mm"/></small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Form nhập tin -->
                    <div class="p-3 border-top bg-white">
                        <form action="${pageContext.request.contextPath}/chat/send" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="conversationId" value="${activeConversation.id}">
                            <div class="input-group input-group-lg">
                                <input type="text" class="form-control border-end-0" name="content" placeholder="Nhập tin nhắn..." required autofocus autocomplete="off">
                                <button type="submit" class="btn btn-primary px-4"><i class="bi bi-send-fill"></i></button>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="h-100 d-flex flex-column justify-content-center align-items-center text-muted bg-light">
                        <i class="bi bi-chat-dots fs-1 mb-3"></i>
                        <h4>Chọn một cuộc trò chuyện để bắt đầu</h4>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    // Cuộn xuống cuối khung chat
    var chatContainer = document.getElementById('chatContainer');
    if(chatContainer){
        chatContainer.scrollTop = chatContainer.scrollHeight;
    }
</script>

<jsp:include page="layout/footer.jsp"/>
