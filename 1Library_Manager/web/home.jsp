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
<!DOCTYPE html>
<html lang="en">
    <head>

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

        </style>
    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <div id="header-wrap">

            <div class="top-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="social-links">
                                <ul>

                                    <form id="f1" action="search">
                                        <input type="text" name="key" placeholder="SEARCH"/><br/>
                                        <input type="submit" value="Search"/>
                                    </form>
                                </ul>
                            </div><!--social-links-->
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
                                <a href="index.html"><img src="images/logo/main-logo.png" alt="logo"></a>
                            </div>

                        </div>

                        <div class="col-md-10">

                            <nav id="navbar">
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list">
                                        <li class="menu-item active"><a href="home.jsp">Home</a></li>
                                        <li class="menu-item"><a href="library" class="nav-link">Library</a></li>

                                        <% if (user != null) { %>  <!-- Kiểm tra nếu đã đăng nhập -->
                                        <li class="menu-item"><a href="borrow" class="nav-link">Borrow</a></li>
                                        <li class="menu-item"><a href="borrowHistory" class="nav-link">Borrow History</a></li>
                                        <li class="menu-item"><a href="fines" class="nav-link">Fines</a></li>
                                        <li class="menu-item"><a href="payment" class="nav-link">Payments</a></li>
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

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/book/bo_gia.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow Book
                                            </button>
                                        </figure>
                                        <figcaption>
                                            <h3>Bố Già</h3>
                                            <span>Mario Puzo</span>

                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/book/dacnhantam.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow Book
                                            </button>
                                        </figure>
                                        <figcaption>
                                            <h3>Đắc Nhân Tâm</h3>
                                            <span>Dale Carnegie</span>

                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/book/doremon.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow Book
                                            </button>
                                        </figure>
                                        <figcaption>
                                            <h3>Doremon</h3>
                                            <span>Fujiko F. Fujio</span>

                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/book/hanhtrinhvephuongdong.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow Book
                                            </button>
                                        </figure>
                                        <figcaption>
                                            <h3>Hành trình về phương Đông</h3>
                                            <span>Baird T. Spalding</span>

                                        </figcaption>
                                    </div>
                                </div>

                            </div><!--ft-books-slider-->
                        </div><!--grid-->


                    </div><!--inner-content-->
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="btn-wrap align-right">
                            <a href="library" class="btn-accent-arrow">View all products <i
                                    class="icon icon-ns-arrow-right"></i></a>
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
                                    <img width="500px" src="images/book/sachtotnhat.jpg" alt="book" class="single-image">
                                </figure>
                            </div>

                            <div class="col-md-6">
                                <div class="product-entry">
                                    <h2 class="section-title divider">Best Selling Book</h2>

                                    <div class="products-content">
                                        <div class="author-name">By Carol S. Dweck</div>
                                        <h3 class="item-title">Lối tư duy của người thành công</h3>
                                        <p>Tư duy là nền tảng của sự thành công trong cuộc sống và lãnh đạo.</p>

                                        <div class="btn-wrap">
                                            <a href="#" class="btn-accent-arrow">borrow it now <i
                                                    class="icon icon-ns-arrow-right"></i></a>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                        <!-- / row -->

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
                            <li data-tab-target="#all-genre" class="active tab">ALL</li>
                            <li data-tab-target="#business" class="tab">Kinh Doanh</li>
                            <li data-tab-target="#technology" class="tab">Tâm Linh</li>
                            <li data-tab-target="#romantic" class="tab">Tư Duy</li>
                            <li data-tab-target="#adventure" class="tab">Truyện Tranh</li>
                            <li data-tab-target="#fictional" class="tab">Tiểu Thuyết</li>
                        </ul>

                        <div class="tab-content">
                            <div id="all-genre" data-tab-content class="active">
                                <div class="row">

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/nhagiakim.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Nhà giả kim</h3>
                                                <span>Paulo Coelho</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/7thoiquenhieuqua.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>7 Thói Quen Hiệu QUả</h3>
                                                <span>Stephen R. Covey</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/hanhtrinhvephuongdong.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Hành Trình Về Phương Đông</h3>
                                                <span>Baird T. Spalding</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/bimatcuanuoc.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Bí Mật Của Nước</h3>
                                                <span>Masaru Emoto</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/nghigiaulamgiau.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Nghĩ Giàu Làm Giàu</h3>
                                                <span>Napoleon Hill</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/sucmanhcuathoiquen.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Sức Mạnh Của Thói Quen</h3>
                                                <span>Charles Duhigg</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/tamlyhocdamdong.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Tâm Lý Học Đám Đông</h3>
                                                <span>Gustave Le Bon</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/onpiece.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">borrow it now
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>One Piece</h3>
                                                <span>Eiichiro Oda</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <div id="business" data-tab-content>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/khoinghiemtinhgon.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Khởi nghiệp tinh gọn</h3>
                                                <span>Eric Ries</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/zerotoone.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Zero to One</h3>
                                                <span>Peter Thiel</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/nghigiaulamgiau.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                    Cart</button>
                                            </figure>
                                            <figcaption>
                                                <h3>Nghĩ giàu làm giàu</h3>
                                                <span>Napoleon Hill</span>

                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/cachmangcongnghiep.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Cách mạng công nghiệp 4.0</h3>
                                                <span>Klaus Schwab</span>

                                            </figcaption>
                                        </div>
                                    </div>

                               

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/book/damthatbai.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                            </button>
                                        </figure>
                                        <figcaption>
                                            <h3>Dám thất bại</h3>
                                            <span>Billi P.S. Lim</span>

                                        </figcaption>
                                    </div>
                                </div>
                                     </div>
                            </div>



                            <div id="technology" data-tab-content>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/hanhtrinhvephuongdong.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Hành trình về phương Đông</h3>
                                                <span>Baird T. Spalding</span>

                                            </figcaption>
                                        </div>
                                    </div>


                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/muonkiepnhansinh.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Muôn kiếp nhân sinh</h3>
                                                <span>Nguyên Phong</span>
                                                
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/bimatcuanuoc.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                 </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Bí mật của nước</h3>
                                                <span>Masaru Emoto</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/tutotdenvidai.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    Cart</button>
                                            </figure>
                                            <figcaption>
                                                <h3>Sức mạnh của hiện tại</h3>
                                                <span>Eckhart Tolle</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="romantic" data-tab-content>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/tuduynhanhvacham.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Tư duy nhanh và chậm</h3>
                                                <span>Daniel Kahneman</span>
                                                
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/loituduycuanguoithanhcong.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Lối tư duy của người thành công</h3>
                                                <span>Carol S. Dweck</span>
                                                
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/bancosthedamphanbatcudieugi.png" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Bạn có thể đàm phán bất cứ điều gì</h3>
                                                <span>Herb Cohen</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/sucmanhcuathoiquen.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Sức mạnh của thói quen</h3>
                                                <span>Charles Duhigg</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/tamlyhocdamdong.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Tâm lý học đám đông</h3>
                                                <span>Gustave Le Bon</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>

                            <div id="adventure" data-tab-content>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/onpiec.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>One Piece</h3>
                                                <span>Eiichiro Oda</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/doremon.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Doraemon</h3>
                                                <span>Fujiko F. Fujio</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                      <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/titan.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Attack on Titan</h3>
                                                <span>Hajime Isayama</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                       <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/daragon.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Dragon Ball</h3>
                                                <span>Akira Toriyama</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                    

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/naruto.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                 </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Naruto</h3>
                                                <span>Masashi Kishimoto</span>
                                               
                                            </figcaption>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="fictional" data-tab-content>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/doremon.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                   </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Harry Potter và Hòn Đá Phù Thủy</h3>
                                                <span>J.K. Rowling</span>
                                            
                                            </figcaption>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/holmes.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Sherlock Holmes: Tập Truyện Ngắn</h3>
                                                <span>Arthur Conan Doyle</span>
                                              
                                            </figcaption>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/doigiohu.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Đồi Gió Hú</h3>
                                                <span>Emily Brontë</span>
                                              
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/kedocsach.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Kẻ Đọc Sách (The Reader)</h3>
                                                <span>Bernhard Schlink</span>
                                              
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="product-item">
                                            <figure class="product-style">
                                                <img src="images/book/changvang.jpg" alt="Books" class="product-item">
                                                <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Borrow
                                                    </button>
                                            </figure>
                                            <figcaption>
                                                <h3>Chạng Vạng (Twilight)</h3>
                                                <span>Stephenie Meyer</span>
                                              
                                            </figcaption>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>

                        </div>

                    </div><!--inner-tabs-->

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