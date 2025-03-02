<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>Library</title>
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
                    </svg>
                </div>
            </nav>
        </div>
        <!-- header section end -->
        <!-- movies section start -->
        <div class="movies_section layout_padding" style="background-color: #c43131">
            <div class="container">                      
                <div class="movies_section_2 layout_padding">
                    <div class="movies_main">
                        <div class="iamge_movies_main " >

                            <c:forEach items="${requestScope.library}" var="p" >
                                <div class="iamge_movies col-2" >
                                    <div class="image_3">
                                        <img src="${p.image}" class="image" style="width:100%">
                                        <div class="middle">
                                            <div class="playnow_bt"><a href="detailbook?id=${p.bookId}">Borrow</a></div>
                                        </div>
                                    </div>
                                    <h1 class="code_text">${p.title}</h1>
                                    <div class="star_icon">
                                        <ul>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>
                <div class="clearfix">
                    <ul class="pagination">                          
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <li class="page-item"><a class="page-link" href="library?page=${pageNumber}">${pageNumber}</a></li>
                            </c:forEach>   
                    </ul>
                </div>
                <script>
                    $('#datepicker').datepicker({
                        uiLibrary: 'bootstrap4'
                    });
                    //                            function change() {
                    //                                document.getElementById("f1").submit();
                    //                            }

                    function show() {
                        var x = document.getElementById("profile");
                        if (x.style.display == "none") {
                            x.style.display = "block";
                        } else {
                            x.style.display = "none";
                        }
                    }
                </script>
                </body>
                </html>

                <style>
                    .iamge_movies_main {
                        display: flex;
                        flex-wrap: wrap;
                    }
                    .image_3 img {
                        width: 200px; /* Đặt chiều rộng cố định */
                        height: 300px; /* Đặt chiều cao cố định */
                        object-fit: cover; /* Giữ nguyên tỷ lệ và cắt ảnh để vừa khung */
                        border-radius: 10px; /* Bo góc ảnh (tùy chỉnh) */
                        display: block;
                        margin: 0 auto; /* Căn giữa hình ảnh */
                    }

                    .iamge_movies {
                        text-align: center; /* Căn giữa tiêu đề sách */
                        padding: 10px;
                        max-width: 220px; /* Đảm bảo không quá to */
                    }

                    .iamge_movies_main {
                        display: flex;
                        justify-content: center; /* Căn giữa hình ảnh */
                        flex-wrap: wrap;
                        gap: 20px; /* Tạo khoảng cách giữa các mục */
                    }

                </style>
