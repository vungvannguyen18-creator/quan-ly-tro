<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
</div> <!-- Close container from header -->
<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold"><i class="bi bi-house-heart-fill me-2"></i>TìmTrọ Nhanh</h6>
                <p>Nền tảng tìm kiếm và cho thuê phòng trọ uy tín, nhanh chóng và tiện lợi nhất dành cho sinh viên và người đi làm.</p>
            </div>
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold">Dịch vụ</h6>
                <p><a href="${pageContext.request.contextPath}/" class="text-white text-decoration-none">Tìm phòng trọ</a></p>
                <p><a href="#" class="text-white text-decoration-none">Tìm chung cư mini</a></p>
                <p><a href="#" class="text-white text-decoration-none">Tìm ở ghép</a></p>
                <p><a href="${pageContext.request.contextPath}/landlord/room/add" class="text-white text-decoration-none">Đăng tin cho thuê</a></p>
                <p><a href="#" class="text-white text-decoration-none">Đặt phòng trực tuyến</a></p>
            </div>
            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold">Hỗ trợ</h6>
                <p><a href="#!" class="text-white text-decoration-none">Hướng dẫn sử dụng</a></p>
                <p><span style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#privacyModal" class="text-white text-decoration-none">Chính sách bảo mật</span></p>
                <p><span style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#rulesModal" class="text-white text-decoration-none">Quy định đăng tin</span></p>
            </div>
            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                <h6 class="text-uppercase fw-bold">Liên hệ</h6>
                <p><i class="bi bi-house-door me-3"></i> Trần Vĩnh Kiết Quận Ninh Kiều Thành Phố Cần Thơ</p>
                <p><i class="bi bi-envelope me-3"></i> vungvannguyen18@gmail.com</p>
                <p><i class="bi bi-telephone me-3"></i> 0774182263</p>
            </div>
        </div>
        <hr>
        <div class="row align-items-center">
            <div class="col-md-7 col-lg-8">
                <p>© 2026 Copyright: <strong>TìmTrọ Nhanh</strong></p>
            </div>
        </div>
    </div>
</footer>

<!-- Modal Quy Định Đăng Tin (Global) -->
<div class="modal fade" id="rulesModal" tabindex="-1" aria-labelledby="rulesModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content text-dark">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title fw-bold" id="rulesModalLabel"><i class="bi bi-file-earmark-text me-2"></i> Quy Định Đăng Tin - Tìm Trọ Nhanh</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-start">
        <h6 class="fw-bold text-primary">1. Điều kiện đăng tin</h6>
        <p>Chỉ tài khoản Chủ trọ (LANDLORD) đã được Admin xác thực mới được đăng tin.</p>
        <p class="mb-1 fw-semibold text-danger">Không cho phép:</p>
        <ul>
            <li>Tài khoản Sinh viên đăng tin</li>
            <li>Tài khoản bị khóa đăng tin</li>
            <li>Tài khoản chưa xác thực đăng tin</li>
        </ul>

        <h6 class="fw-bold text-primary mt-4">2. Thông tin bắt buộc</h6>
        <p>Khi đăng tin phải cung cấp đầy đủ: Thông tin phòng, Tên phòng, Địa chỉ chính xác, Giá thuê, Diện tích, Số người tối đa, Mô tả phòng, Hình ảnh.</p>
        <ul>
            <li><strong>Ít nhất:</strong> 03 ảnh thực tế</li>
            <li><strong>Khuyến nghị:</strong> 05 - 10 ảnh</li>
        </ul>

        <h6 class="fw-bold text-primary mt-4">3. Nội dung bị cấm</h6>
        <p>Không được đăng:</p>
        <div class="row">
            <div class="col-md-6">
                <ul class="list-unstyled">
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Phòng không có thật</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Hình ảnh lấy từ Internet</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Giá thuê không đúng thực tế</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Nội dung lừa đảo</li>
                </ul>
            </div>
            <div class="col-md-6">
                <ul class="list-unstyled">
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Nội dung phản cảm</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Thông tin vi phạm pháp luật</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Quảng cáo dịch vụ không liên quan</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Spam nhiều bài giống nhau</li>
                </ul>
            </div>
        </div>

        <h6 class="fw-bold text-primary mt-4">4. Quy định hình ảnh</h6>
        <div class="row">
            <div class="col-md-6">
                <p class="mb-1 fw-semibold text-success">Ảnh phải:</p>
                <ul class="list-unstyled">
                    <li><i class="bi bi-check-circle text-success me-2"></i>Là ảnh thật của phòng</li>
                    <li><i class="bi bi-check-circle text-success me-2"></i>Rõ nét</li>
                    <li><i class="bi bi-check-circle text-success me-2"></i>Không chứa nội dung phản cảm</li>
                    <li><i class="bi bi-check-circle text-success me-2"></i>Không chứa logo website khác</li>
                </ul>
            </div>
            <div class="col-md-6">
                <p class="mb-1 fw-semibold text-danger">Không được:</p>
                <ul class="list-unstyled">
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Ảnh mờ</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Ảnh sai phòng</li>
                    <li><i class="bi bi-x-circle text-danger me-2"></i>Ảnh AI gây hiểu nhầm</li>
                </ul>
            </div>
        </div>

        <h6 class="fw-bold text-primary mt-4">5. Quy định giá thuê</h6>
        <p>Giá thuê phải chính xác. Ví dụ: Giá thuê: 2.500.000 VNĐ/tháng.</p>
        <p>Nếu có chi phí khác phải ghi rõ trong mô tả:</p>
        <ul>
            <li>Điện: 3.500 VNĐ/kWh</li>
            <li>Nước: 15.000 VNĐ/m³</li>
            <li>Wifi: 100.000 VNĐ/tháng</li>
        </ul>
        <p class="text-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Không được:</strong> Để giá 500.000 VNĐ nhưng thực tế thu 3.000.000 VNĐ.</p>

        <h6 class="fw-bold text-primary mt-4">6. Kiểm duyệt bài đăng</h6>
        <ul>
            <li>Sau khi đăng: <span class="badge bg-warning text-dark">PENDING</span> Admin kiểm tra.</li>
            <li>Nếu hợp lệ: <span class="badge bg-success">APPROVED</span> Hiển thị công khai.</li>
            <li>Nếu vi phạm: <span class="badge bg-danger">REJECTED</span> Kèm lý do từ chối.</li>
        </ul>

        <h6 class="fw-bold text-primary mt-4">7. Quy định liên hệ</h6>
        <p>Thông tin liên hệ phải chính xác: Họ tên chủ trọ, Số điện thoại, Email.</p>
        <p class="mb-1 fw-semibold text-danger">Không được:</p>
        <ul class="list-unstyled">
            <li><i class="bi bi-x-circle text-danger me-2"></i>Mạo danh người khác</li>
            <li><i class="bi bi-x-circle text-danger me-2"></i>Dùng số điện thoại giả</li>
        </ul>

        <h6 class="fw-bold text-primary mt-4">8. Xử lý vi phạm</h6>
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle">
                <tbody>
                    <tr><td class="fw-semibold" style="width: 30%;">Vi phạm lần 1</td><td>Cảnh báo</td></tr>
                    <tr><td class="fw-semibold">Vi phạm lần 2</td><td>Ẩn bài đăng</td></tr>
                    <tr><td class="fw-semibold">Vi phạm lần 3</td><td>Khóa tài khoản 7 ngày</td></tr>
                    <tr><td class="fw-semibold text-danger">Vi phạm nghiêm trọng</td><td><span class="text-danger fw-bold">Khóa vĩnh viễn</span> (VD: Lừa đảo tiền cọc, Phòng không tồn tại, Giả mạo giấy tờ)</td></tr>
                </tbody>
            </table>
        </div>

        <h6 class="fw-bold text-primary mt-4">9. Trạng thái bài đăng</h6>
        <div class="table-responsive">
            <table class="table table-bordered table-sm align-middle text-center">
                <thead class="table-light">
                    <tr><th>Trạng thái</th><th>Ý nghĩa</th></tr>
                </thead>
                <tbody>
                    <tr><td><span class="badge bg-warning text-dark">PENDING</span></td><td>Chờ kiểm duyệt</td></tr>
                    <tr><td><span class="badge bg-success">APPROVED</span></td><td>Đã duyệt</td></tr>
                    <tr><td><span class="badge bg-danger">REJECTED</span></td><td>Từ chối</td></tr>
                    <tr><td><span class="badge bg-secondary">HIDDEN</span></td><td>Bị ẩn</td></tr>
                    <tr><td><span class="badge bg-dark">EXPIRED</span></td><td>Hết hạn</td></tr>
                    <tr><td><span class="badge bg-light text-dark border">DELETED</span></td><td>Đã xóa</td></tr>
                </tbody>
            </table>
        </div>

      </div>
      <div class="modal-footer bg-light">
        <button type="button" class="btn btn-secondary fw-bold px-4" data-bs-dismiss="modal">Đã hiểu</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Chính Sách Bảo Mật (Global) -->
<div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content text-dark">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title fw-bold" id="privacyModalLabel"><i class="bi bi-shield-check me-2"></i> Chính Sách Bảo Mật - Tìm Trọ Nhanh</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-start">
        <p class="text-muted fst-italic">Cập nhật lần cuối: 23/05/2026</p>

        <h6 class="fw-bold text-success mt-4">1. Mục đích</h6>
        <p>Website Tìm Trọ Nhanh cam kết bảo vệ quyền riêng tư và thông tin cá nhân của người dùng. Chính sách này giải thích cách chúng tôi thu thập, sử dụng, lưu trữ và bảo vệ dữ liệu của người dùng khi sử dụng hệ thống.</p>

        <h6 class="fw-bold text-success mt-4">2. Thông tin được thu thập</h6>
        <p class="fw-semibold mt-3">2.1. Thông tin tài khoản</p>
        <p>Khi đăng ký tài khoản, hệ thống có thể thu thập: Họ và tên, Email, Số điện thoại, Mật khẩu (được mã hóa), Vai trò tài khoản.</p>
        <ul>
            <li><strong>Vai trò:</strong> Sinh viên, Chủ trọ, Quản trị viên</li>
        </ul>

        <p class="fw-semibold mt-3">2.2. Thông tin giao dịch</p>
        <p>Khi thực hiện thanh toán tiền cọc hoặc các giao dịch khác, hệ thống có thể lưu:</p>
        <ul>
            <li>Mã giao dịch</li>
            <li>Số tiền</li>
            <li>Thời gian giao dịch</li>
            <li>Trạng thái thanh toán</li>
            <li>Nội dung giao dịch</li>
        </ul>

        <p class="fw-semibold mt-3">2.3. Thông tin hoạt động</p>
        <p>Hệ thống có thể ghi nhận:</p>
        <ul>
            <li>Lịch sử đăng nhập</li>
            <li>Lịch sử tìm kiếm phòng</li>
            <li>Lịch sử đặt phòng</li>
            <li>Đánh giá và bình luận</li>
            <li>Danh sách phòng yêu thích</li>
        </ul>

        <h6 class="fw-bold text-success mt-4">3. Mục đích sử dụng thông tin</h6>
        <p>Thông tin được sử dụng để:</p>
        <div class="row">
            <div class="col-md-6">
                <ul>
                    <li>Xác thực tài khoản</li>
                    <li>Quản lý người dùng</li>
                    <li>Hỗ trợ tìm kiếm phòng trọ</li>
                    <li>Xử lý yêu cầu thuê phòng</li>
                </ul>
            </div>
            <div class="col-md-6">
                <ul>
                    <li>Xử lý thanh toán</li>
                    <li>Gửi thông báo hệ thống</li>
                    <li>Cải thiện chất lượng dịch vụ</li>
                    <li>Hỗ trợ giải quyết tranh chấp</li>
                </ul>
            </div>
        </div>

        <h6 class="fw-bold text-success mt-4">4. Bảo mật thông tin</h6>
        <p>Chúng tôi áp dụng các biện pháp bảo mật phù hợp:</p>
        <ul>
            <li><strong>Mật khẩu:</strong> Không lưu mật khẩu dạng văn bản thuần (Plain Text). Mật khẩu được mã hóa bằng BCrypt.</li>
            <li><strong>Phân quyền:</strong> Sinh viên chỉ xem được dữ liệu của mình. Chủ trọ chỉ quản lý phòng thuộc quyền sở hữu. Admin có quyền quản trị hệ thống.</li>
            <li><strong>Kết nối:</strong> Khuyến nghị triển khai HTTPS / SSL để mã hóa dữ liệu truyền tải.</li>
        </ul>

        <h6 class="fw-bold text-success mt-4">5. Chia sẻ thông tin</h6>
        <p>Website <strong class="text-danger">không bán, trao đổi hoặc cho thuê</strong> thông tin cá nhân của người dùng cho bên thứ ba.</p>
        <p>Thông tin chỉ được cung cấp khi:</p>
        <ul>
            <li>Có yêu cầu từ cơ quan nhà nước có thẩm quyền</li>
            <li>Phục vụ điều tra các hành vi vi phạm pháp luật</li>
            <li>Được sự đồng ý của người dùng</li>
        </ul>

        <h6 class="fw-bold text-success mt-4">6. Thanh toán trực tuyến</h6>
        <p>Hệ thống sử dụng dịch vụ thanh toán của <strong>PayOS</strong>.</p>
        <ul>
            <li>Người dùng được chuyển tới cổng thanh toán PayOS</li>
            <li>Website <strong class="text-danger">không lưu</strong> thông tin tài khoản ngân hàng</li>
            <li>Website <strong class="text-danger">không lưu</strong> thông tin thẻ thanh toán</li>
        </ul>
        <p><em>Việc xử lý thanh toán tuân theo chính sách của PayOS.</em></p>

        <h6 class="fw-bold text-success mt-4">7. Quyền của người dùng</h6>
        <div class="row">
            <div class="col-md-6">
                <p class="fw-semibold text-primary mb-1">Sinh viên</p>
                <ul>
                    <li>Xem thông tin cá nhân</li>
                    <li>Chỉnh sửa thông tin cá nhân</li>
                    <li>Đổi mật khẩu</li>
                    <li>Xóa tài khoản (theo quy định hệ thống)</li>
                </ul>
            </div>
            <div class="col-md-6">
                <p class="fw-semibold text-primary mb-1">Chủ trọ</p>
                <ul>
                    <li>Cập nhật thông tin cá nhân</li>
                    <li>Quản lý tin đăng</li>
                    <li>Yêu cầu chỉnh sửa hoặc xóa dữ liệu</li>
                </ul>
            </div>
        </div>

        <h6 class="fw-bold text-success mt-4">8. Lưu trữ dữ liệu</h6>
        <p>Dữ liệu được lưu trữ trên hệ thống máy chủ của website nhằm: Quản lý hoạt động, Hỗ trợ giao dịch, Phục hồi dữ liệu khi có sự cố.</p>
        <p>Thời gian lưu trữ phụ thuộc vào: Quy định pháp luật, Nhu cầu vận hành hệ thống.</p>

        <h6 class="fw-bold text-success mt-4">9. Cookie và phiên đăng nhập</h6>
        <p>Website có thể sử dụng <strong>Cookie</strong> và <strong>Session</strong> nhằm: Duy trì trạng thái đăng nhập, Ghi nhớ tùy chọn người dùng, Tăng trải nghiệm sử dụng.</p>
        <p class="text-muted"><i class="bi bi-info-circle me-1"></i>Người dùng có thể tắt Cookie trong trình duyệt, tuy nhiên một số chức năng có thể hoạt động không đầy đủ.</p>

        <h6 class="fw-bold text-success mt-4">10. Trách nhiệm của người dùng</h6>
        <ul>
            <li>Bảo mật tài khoản cá nhân</li>
            <li>Không chia sẻ mật khẩu</li>
            <li>Không sử dụng hệ thống vào mục đích trái pháp luật</li>
            <li>Thông báo ngay khi phát hiện tài khoản bị truy cập trái phép</li>
        </ul>

        <h6 class="fw-bold text-success mt-4">11. Thay đổi chính sách</h6>
        <p>Website có quyền cập nhật Chính sách bảo mật khi cần thiết nhằm phù hợp với: Quy định pháp luật, Nhu cầu vận hành hệ thống, Nâng cấp dịch vụ.</p>
        <p>Phiên bản mới sẽ được công bố trên website.</p>

        <h6 class="fw-bold text-success mt-4">12. Thông tin liên hệ</h6>
        <div class="bg-light p-3 rounded border border-success-subtle">
            <p class="fw-bold text-dark mb-2">TÌM TRỌ NHANH</p>
            <ul class="list-unstyled mb-0">
                <li class="mb-1"><i class="bi bi-geo-alt-fill text-danger me-2"></i><strong>Địa chỉ:</strong> Trần Vĩnh Kiết Quận Ninh Kiều Thành Phố Cần Thơ</li>
                <li class="mb-1"><i class="bi bi-envelope-fill text-primary me-2"></i><strong>Email:</strong> vungvannguyen18@gmail.com</li>
                <li class="mb-1"><i class="bi bi-telephone-fill text-success me-2"></i><strong>Hotline:</strong> 0774182263</li>
                <li><i class="bi bi-globe text-info me-2"></i><strong>Website:</strong> timtronhanh.com</li>
            </ul>
        </div>
      </div>
      <div class="modal-footer bg-light">
        <button type="button" class="btn btn-secondary fw-bold px-4" data-bs-dismiss="modal">Đã hiểu</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
