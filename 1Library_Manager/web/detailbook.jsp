
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>Detai Product</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- bootstrap css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <!-- owl stylesheets --> 
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

        <style>
            .img-container {
                width: 400px;  /* Kích thước cố định */
                height: 500px;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                border-radius: 15px;
                background-color: #fff; /* Đảm bảo nền không có màu lạ */
            }

            .img-container img {
                width: 100%;
                height: 100%;
                object-fit: contain; /* Ảnh sẽ co giãn để vừa với container mà không bị mất phần nào */
            }






        </style>
    </head>
    <body>
        <!-- header section start -->
        <div class="header_section">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="logo" href="home"><img src="images/iconbook.png"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="home">Home</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="search">Library</a>
                        </li>
                    </ul>
                    <form id="f1" action="search" method="GET" style="display: flex; gap: 10px;">
                        <input type="text" name="key" placeholder="Nhập tên, miêu tả"
                               style="height: 40px; font-size: 14px; padding: 0 10px; width: 200px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;" />

                        <select name="category" style="height: 40px; font-size: 14px; padding: 0 10px; border: 1px solid #ccc; border-radius: 5px;">
                            <option value="">Tất cả thể loại</option>
                            <c:if test="${not empty categories}">
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat}">${cat}</option>
                                </c:forEach>
                            </c:if>
                        </select>

                        <input type="submit" value="Search"
                               style="height: 40px; font-size: 14px; padding: 0 15px; box-sizing: border-box; border: 1px solid #007bff; border-radius: 5px; background-color: #007bff; color: white; cursor: pointer; font-weight: bold; text-align: center;" />
                    </form>
                </div>

            </nav>
        </div>
        <section class="py-5">
            <div class="container">
                <div class="row gx-5">
                    <aside class="col-lg-6">
                        <div class="img-container">
                            <img src="${book.image}" alt="Book Image">
                        </div>
                    </aside>
                    <main class="col-lg-6">
                        <c:set value="${book.bookId}" var="id"/>
                        <div class="ps-lg-3">
                            <h1 class="title text-dark">
                                ${book.title}
                            </h1>
                            <div class="d-flex flex-row my-3">
                                <div class="text-warning mb-1 me-2">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                    <span class="ms-1">
                                        4.5
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <dt class="col-3">Category</dt>
                            <dd class="col-9">${book.category}</dd>

                            <dt class="col-3">Author</dt>
                            <dd class="col-9">${book.author}</dd>

                            <dt class="col-3">Publisher</dt>
                            <dd class="col-9">${book.publisher}</dd>
                        </div>

                        <hr />
                        <div class="row mb-4">
                            <div class="col-md-4 col-6 mb-3">
                                <label class="mb-2 d-block">Số lượng còn lại:</label>
                                <div class="input-group mb-3" style="width: 170px;">
                                    <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon1" data-mdb-ripple-color="dark">
                                        ${book.quantity}
                                    </button>                                  
                                </div>

                                <c:choose>
                                    <c:when test="${book.quantity > 0}">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.userId and user != null}">
                                                <a class="btn btn-primary shadow-0" style="background-color: #d66385" data-bs-toggle="modal" data-bs-target="#rentBookModal"> 
                                                    <i class="me-1 fa fa-shopping-basket"></i> Thuê Ngay
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="login.jsp" class="btn btn-primary shadow-0" style="background-color: #d66385"> 
                                                    <i class="me-1 fa fa-shopping-basket"></i> Đăng nhập để thuê
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-danger fw-bold">Hết sách</p>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Popup Modal thuê sách -->
                                <div class="modal fade" id="rentBookModal" tabindex="-1" aria-labelledby="rentBookLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="rentBookLabel">Thông tin thuê sách</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- FORM CHÍNH -->
                                                <form id="rentForm" action="rentBookServlet" method="post">
                                                    <input type="hidden" name="user_id" value="${sessionScope.userId}">
                                                    <input type="hidden" name="book_id" value="${book.bookId}">
                                                    <input type="hidden" name="status" value="borrowed">

                                                    <div class="mb-3">
                                                        <label for="borrowDate" class="form-label">Ngày mượn</label>
                                                        <input type="date" class="form-control" id="borrowDate" name="borrow_date" required readonly>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="rentalDays" class="form-label">Số ngày thuê</label>
                                                        <input type="number" class="form-control" id="rentalDays" name="rental_days" min="1" value="7" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="dueDate" class="form-label">Ngày hết hạn</label>
                                                        <input type="date" class="form-control" id="dueDate" name="due_date" required readonly>
                                                    </div>

                                                    <button type="submit" class="btn btn-success">Xác nhận thuê</button>
                                                </form>

                                                <script>
                                                    document.addEventListener("DOMContentLoaded", function () {
                                                        let today = new Date();
                                                        let formattedToday = today.toISOString().split('T')[0];
                                                        document.getElementById("borrowDate").value = formattedToday;

                                                        function updateDueDate() {
                                                            let rentalDays = parseInt(document.getElementById("rentalDays").value) || 0;
                                                            let dueDate = new Date(today);
                                                            dueDate.setDate(dueDate.getDate() + rentalDays);
                                                            document.getElementById("dueDate").value = dueDate.toISOString().split('T')[0];
                                                        }

                                                        document.getElementById("rentalDays").addEventListener("input", updateDueDate);
                                                        updateDueDate();
                                                    });
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>






                            </div>
                        </div>
                    </main>
                </div>
            </div>
        </section>

        <!-- content -->

        <section class="bg-light border-top py-4">
            <div class="container">
                <div class="row gx-4">
                    <div class="col-lg-8 mb-4">
                        <div class="border rounded-2 px-3 py-2 bg-white">
                            <!-- Pills navs -->
                            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                                <li class="nav-item d-flex" role="presentation">
                                    <a class="nav-link d-flex align-items-center justify-content-center w-100 active" id="ex1-tab-1" data-mdb-toggle="pill" href="#ex1-pills-1" role="tab" aria-controls="ex1-pills-1" aria-selected="true">Mô tả sách</a>
                                </li>
                            </ul>
                            <div class="tab-content" id="ex1-content">
                                <div class="tab-pane fade show active" id="ex1-pills-1" role="tabpanel" aria-labelledby="ex1-tab-1">
                                    <p>
                                        ${empty book.description ? "Không có mô tả" : book.description}
                                    </p>
                                    <table class="table border mt-3 mb-2">
                                        <tr>
                                            <th class="py-2">Publisher</th>
                                            <td class="py-2">${empty book.publisher ? "Không có dữ liệu" : book.publisher}</td>
                                        </tr>
                                        <tr>
                                            <th class="py-2">Author</th>
                                            <td class="py-2">${empty book.author ? "Không có dữ liệu" : book.author}</td>
                                        </tr>
                                        <tr>
                                            <th class="py-2">Created At</th>
                                            <td class="py-2">${empty book.createdAt ? "Không có dữ liệu" : book.createdAt}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <!-- Pills content -->
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="px-0 border rounded-2 shadow-0">
                            <div class="card">
                                <div class="card-body">

                                    <h4 class="card-title">Same Category</h4>

                                    <c:if test="${not empty book.relatedBooks}">
                                        <c:forEach var="s" items="${book.relatedBooks}" varStatus="loop">
                                            <c:if test="${loop.index < 5}"> 
                                                <div class="d-flex mb-3">
                                                    <a href="detailbook?id=${s.bookId}" class="me-3">
                                                        <img src="${s.image}" style="min-width: 96px; height: 150px;" class="img-md img-thumbnail" />
                                                    </a>
                                                    <div class="info">
                                                        <a href="detailbook?id=${s.bookId}" class="nav-link mb-1">
                                                            ${s.title}
                                                        </a>
                                                        <a href="detailbook?id=${s.bookId}" class="nav-link mb-1">
                                                            Author: ${s.author}
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty book.relatedBooks}">
                                        <p>Không có sách cùng thể loại.</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- footer  section end -->
        <!-- copyright section start -->
        <div class="copyright_section">
            <div class="container">
                <div class="copyright_text">PRJ301-LibraryManager</div>
            </div>
        </div>

        <script src="js/jquery.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/jquery-3.0.0.min.js"></script>
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/owl.carousel.js"></script>
        <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
        <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>    