<%-- 
    Document   : home
    Created on : Feb 25, 2025, 11:26:18 PM
    Author     : MSI
--%>
<%@ page import="model.Users" %>
<%@ page session="true" %>
<%
    Users user = (Users) session.getAttribute("user");
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="author" content="">
        <meta name="keywords" content="">
        <meta name="description" content="">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            * {
                font-family: 'Roboto', sans-serif !important;
                font-weight: 400;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Roboto', sans-serif;
                font-weight: 700;
            }
            body, p, span, a, li, label, button {
                font-family: 'Roboto', sans-serif;
                font-weight: 400;
            }
        </style>
        <style>

            .user-info-container {
                display: flex;
                align-items: center;
                gap: 15px; /* Khoảng cách giữa các phần tử */
                padding: 10px 15px;
            }

            .user-info-container img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }

            .user-details {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 16px;
                font-weight: 500;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: white;
                padding: 10px;
                border-radius: 5px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
                top: 50px; /* Điều chỉnh vị trí xuất hiện */
                right: 0;
                z-index: 1000;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }
            .product-item figure img {
                width: 100%; /* Chiều rộng đầy đủ */
                height: 400px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Đảm bảo hình ảnh không bị méo */
                border-radius: 10px; /* Bo góc hình ảnh (tùy chỉnh) */
            }

            .product-style img {
                width: 100%;
                height: 100px;
                object-fit: cover;

            }
            .grid {
                display: flex;
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                flex-wrap: wrap; /* Đảm bảo các phần tử không bị tràn */
                gap: 20px; /* Tạo khoảng cách giữa các phần tử */
                text-align: center; /* Căn giữa nội dung bên trong */
                width: 100%; /* Chiếm toàn bộ chiều rộng */
            }

            form {
                width: 100%;
                max-width: 400px;
                margin: 5px auto;
                padding: 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            input[type="text"] {
                padding: 6px 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                height: 36px;
                box-sizing: border-box;
                width: 75%;
                margin: 0;
            }
            button {
                padding: 6px 12px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s;
                height: 36px;
                box-sizing: border-box;
                margin-left: 8px;
            }

            button:hover {
                background-color: #0056b3;
            }

        </style>
    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <div id="header-wrap">

            <div class="top-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <div>
                                <form id="f111" action="search" method="GET">
                                    <input type="text" name="key" placeholder="Nhập tên sách" />
                                    <button type="submit">SEARCH</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="right-element d-flex justify-content-end align-items-center" style="gap: 10px;">
                                <% if (user == null) { %>
                                <!-- Nếu chưa đăng nhập -->
                                <a href="login.jsp" class="user-account for-buy">
                                    <i class="icon icon-user"></i><span>Login</span>
                                </a>
                                <% } else { %>
                                <!-- Nếu đã đăng nhập -->
                                <div class="user-info-container d-flex align-items-center">
                                    <div class="user-details">
                                        <span>👤 <%= user.getUsername() %></span>
                                        <span>📧 <%= user.getEmail() %></span>
                                        <span>📖 <%= user.getName() %></span>
                                    </div>

                                    <% if ("admin".equals(user.getRole())) { %>
                                    <a href="crud.jsp" class="btn-admin">🔧CRUD</a>
                                    <% } %>

                                    <a href="changepassword.jsp" class="search_icon d-flex align-items-center mx-2">
                                        <img src="images/reset-password.png">
                                        <span>Change Password</span>
                                    </a>

                                    <a href="logout" class="search_icon d-flex align-items-center mx-2">
                                        <img src="images/logout.png">
                                        <span>Logout</span>
                                    </a>
                                </div>
                                <% } %>
                            </div>
                            <!-- right-element -->
                        </div>

                    </div>
                </div>
            </div><!--top-content-->

            <header id="header">
                <div class="container-fluid">
                    <div class="row">

                        <div class="col-md-2">
                            <div class="main-logo">
                                <a href="home.jsp"><img src="images/logo/main-logo.png" alt="logo"></a>
                            </div>

                        </div>

                        <div class="col-md-10">

                            <nav id="navbar">
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list">
                                        <li class="menu-item active"><a href="home.jsp">Home</a></li>
                                        <li class="menu-item"><a href="search" class="nav-link">Library</a></li>

                                        <% if (user != null) { %>  <!-- Kiểm tra nếu đã đăng nhập -->
                                        <li class="menu-item"><a href="borrow" class="nav-link">Borrow History</a></li>
                                        <% } %>  <!-- Nếu chưa đăng nhập, chỉ hiển thị Home & Library -->
                                    </ul>

                                    <div class="hamburger">
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                    </div>
                                </div>
                            </nav>


                        </div>

                    </div>
                </div>
            </header>

        </div><!--header-wrap-->

        <section id="billboard">

            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <button class="prev slick-arrow">
                            <i class="icon icon-arrow-left"></i>
                        </button>

                        <div class="main-slider pattern-overlay">
                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title">Cẩm Nang Khởi Nghiệp</h2>
                                    <p>Đúng nghĩa với cẩm nang. Đây sẽ là một cuốn sách hay về kinh doanh ghi tóm lược lại 
                                        những điều quan trọng và thiết yếu ngay từ những bước chân đầu tiên cơ bản nhất 
                                        cho những ai khi bước vào hành trình khởi nghiệp. Cẩm Nang Khởi Nghiệp cũng sẽ là tài liệu quý giá 
                                        giúp các chủ doanh nghiệp vừa và nhỏ nhìn nhận lại, 
                                        xây dựng một tư duy đúng đắn và chiến lược kinh doanh phù hợp. </p>

                                </div><!--banner-content-->
                                <img width="400px" height="50px" src="images/banner/main-banner1.jpg" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title">Tư Duy Ngược</h2>
                                    <p>Tư Duy Ngược: Chúng ta thực sự có hạnh phúc không? Chúng ta có đang sống cuộc đời mình không? 
                                        Chúng ta có dám dũng cảm chiến thắng mọi khuôn mẫu, định kiến, 
                                        đi ngược đám đông để khẳng định bản sắc riêng của mình không?. 
                                        Có bao giờ bạn tự hỏi như thế, rồi có câu trả lời cho chính mình?
                                        Tôi biết biết, không phải ai cũng đang sống cuộc đời của mình, 
                                        không phải ai cũng dám vượt qua mọi lối mòn để sáng tạo và thành công… 
                                        Dựa trên việc nghiên cứu, tìm hiểu, chắt lọc, tìm kiếm, ghi chép từ các câu chuyện trong đời sống, 
                                        cũng như trải nghiệm của bản thân, tôi viết cuốn sách này.</p>

                                </div><!--banner-content-->
                                <img width="500px"  src="images/banner/main-banner2.jpg" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                        </div><!--slider-->

                        <button class="next slick-arrow">
                            <i class="icon icon-arrow-right"></i>
                        </button>

                    </div>
                </div>
            </div>

        </section>

        <section id="client-holder" data-aos="fade-up">
            <div class="container">
                <div class="row">
                    <div class="inner-content">
                        <div class="logo-wrap">
                            <div class="grid">
                                <a href="#"><img src="images/logo/client-image1.png" alt="client"></a>
                                <a href="#"><img src="images/logo/client-image2.png" alt="client"></a>
                                <a href="#"><img src="images/logo/client-image3.png" alt="client"></a>
                                <a href="#"><img src="images/logo/client-image4.png" alt="client"></a>

                            </div>
                        </div><!--image-holder-->
                    </div>
                </div>
            </div>
        </section>

        <section id="featured-books" class="py-5 my-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-header align-center">
                            <h2 class="section-title">Sách Nổi Bật</h2>
                        </div>
                        <div class="product-list" data-aos="fade-up">
                            <div class="row">
                                <c:forEach var="b" items="${featuredBooks}">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="${pageContext.request.contextPath}/${b.image}" 
                                                     alt="${b.title}" 
                                                     class="product-image">
                                                <button type="button" class="add-to-cart" onclick="window.location.href = 'detailbook?id=${b.bookId}'">Borrow Book</button>
                                            </figure>
                                            <figcaption>
                                                <h3>${b.title}</h3>
                                                <span>${b.author}</span>
                                            </figcaption>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-wrap align-right">
                            <a href="library" class="btn-accent-arrow">
                                View all products <i class="icon icon-ns-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="best-selling" class="leaf-pattern-overlay">
            <div class="corner-pattern-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-6">
                                <figure class="products-thumb">
                                    <img width="500px" src="${pageContext.request.contextPath}/${lowestBook.image}" alt="book" class="single-image">
                                </figure>
                            </div>
                            <div class="col-md-6">
                                <div class="product-entry">
                                    <h2 class="section-title divider">Best Selling Book</h2>
                                    <div class="products-content">
                                        <div class="author-name">By ${lowestBook.author}</div>
                                        <h3 class="item-title">${lowestBook.title}</h3>
                                        <p>${lowestBook.description}</p>
                                        <div class="btn-wrap">
                                            <a href="detailbook?id=${lowestBook.bookId}" class="btn-accent-arrow">borrow it now <i class="icon icon-ns-arrow-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="popular-books" class="bookshelf py-5 my-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="section-header align-center">
                            <h2 class="section-title">Popular Book</h2>
                        </div>

                        <ul class="tabs">
                            <c:forEach var="c" items="${categories}" varStatus="status">
                                <li class="tab ${status.first ? 'active' : ''}" data-category="${c}">${c}</li>
                                </c:forEach>
                        </ul>

                        <div class="tab-content">
                            <c:forEach var="c" items="${categories}" varStatus="status">
                                <div class="book-container ${status.first ? 'active' : ''}" data-category="${c}">
                                    <div class="row">
                                        <c:set var="count" value="0" />
                                        <c:forEach var="book" items="${books}">
                                            <c:if test="${book.category == c && count < 8}">
                                                <c:set var="count" value="${count + 1}" />
                                                <div class="col-md-3 book-item">
                                                    <div class="product-item">
                                                        <figure class="product-style">
                                                            <img src="${not empty book.image ? book.image : 'images/book/default.jpg'}" 
                                                                 alt="${book.title}" class="product-item">
                                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart" onclick="window.location.href = 'detailbook?id=${book.bookId}'">Borrow</button>
                                                        </figure>
                                                        <figcaption>
                                                            <h3>${book.title}</h3>
                                                            <span>${book.author}</span>
                                                        </figcaption>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${count == 0}">
                                            <p class="no-books">Không có sách trong thể loại này.</p>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>



                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const tabs = document.querySelectorAll(".tab");
                                const bookContainers = document.querySelectorAll(".book-container");

                                function showBooks(selectedCategory) {
                                    bookContainers.forEach(container => {
                                        if (container.dataset.category === selectedCategory) {
                                            container.style.display = "block";
                                        } else {
                                            container.style.display = "none";
                                        }
                                    });
                                }

                                const firstTab = tabs[0];
                                firstTab.classList.add("active");
                                showBooks(firstTab.dataset.category);

                                tabs.forEach(tab => {
                                    tab.addEventListener("click", function () {
                                        tabs.forEach(t => t.classList.remove("active"));
                                        this.classList.add("active");
                                        showBooks(this.dataset.category);
                                    });
                                });
                            });
                        </script>


                    </div>
                </div>
            </div>
        </section>

        <footer id="footer">
            <div class="container">
                <div class="row">

                    <div class="col-md-4">

                        <div class="footer-item">
                            <div class="company-brand">
                                <img src="images/iconbook.png" alt="logo" class="footer-logo">

                            </div>
                        </div>

                    </div>


                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>Address</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">Thạch Hòa - Thạch Thất - Thành Phố Hà Nội</a>
                                </li>

                            </ul>
                        </div>

                    </div>
                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>Phone Number</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">095875464</a>
                                </li>

                            </ul>
                        </div>

                    </div>
                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>Email</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">thuviensach@fpt.edu.vn</a>
                                </li>

                            </ul>
                        </div>

                    </div>

                </div>
                <!-- / row -->

            </div>
        </footer>

        <div id="footer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="copyright">
                            <div class="row">

                                <div class="col-md-6">
                                    <p>© 2022 All rights reserved. Free HTML Template by <a
                                            href="https://www.templatesjungle.com/" target="_blank">TemplatesJungle</a></p>
                                </div>

                                <div class="col-md-6">
                                    <div class="social-links align-right">
                                        <ul>
                                            <li>
                                                <a href="#"><i class="icon icon-facebook"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="icon icon-twitter"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="icon icon-youtube-play"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="icon icon-behance-square"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                        </div><!--grid-->

                    </div><!--footer-bottom-content-->
                </div>
            </div>
        </div>

        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
        <script>
                            function toggleProfile() {
                                var profileDiv = document.getElementById("profile");
                                if (profileDiv.style.display === "none" || profileDiv.style.display === "") {
                                    profileDiv.style.display = "block";
                                } else {
                                    profileDiv.style.display = "none";
                                }
                            }
        </script>

    </body>

</html>