<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            /* Định dạng form */
            #f1 {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* Input và select đồng bộ */
            #searchInput, select[name="category"] {
                height: 40px;
                font-size: 14px;
                padding: 0 10px;
                width: 200px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 5px;
                background: white;
            }

            /* Dropdown chọn ngôn ngữ */
            .language-dropdown {
                position: relative;
                display: inline-block;
            }

            .language-btn {
                display: flex;
                align-items: center;
                gap: 5px;
                background: white;
                border: 1px solid #ccc;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
                width: 110px;
                font-size: 14px;
            }

            .language-btn img {
                width: 20px;
                height: 15px;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background: white;
                border: 1px solid #ccc;
                min-width: 110px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                z-index: 1000;
            }

            .dropdown-content div {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 8px;
                cursor: pointer;
                font-size: 14px;
            }

            .dropdown-content div:hover {
                background: #f1f1f1;
            }

            .dropdown-content img {
                width: 20px;
                height: 15px;
            }

            /* Nút tìm kiếm và micro */
            #voiceSearchBtn, #searchButton {
                height: 40px;
                font-size: 14px;
                padding: 0 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            #voiceSearchBtn {
                background-color: #28a745;
                color: white;
            }

            #searchButton {
                background-color: #007bff;
                color: white;
                font-weight: bold;
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
                    </ul>
                    <form id="f1" action="search" method="GET">
                        <input type="text" id="searchInput" name="key" placeholder="Nhập tên, miêu tả" />

                        <!-- Dropdown chọn thể loại sách -->
                        <select name="category">
                            <option value="">Tất cả thể loại</option>
                            <c:if test="${not empty categories}">
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat}">${cat}</option>
                                </c:forEach>
                            </c:if>
                        </select>

                        <!-- Dropdown chọn ngôn ngữ -->
                        <div class="language-dropdown">
                            <div class="language-btn" id="selectedLanguage">
                                <img src="images/logo/covietnam.jpg" alt="Vietnamese Flag"> 🇻🇳
                            </div>
                            <div class="dropdown-content" id="languageDropdown">
                                <div data-lang="vi-VN">
                                    <img src="images/logo/covietnam.jpg" alt="Vietnamese Flag"> 🇻🇳
                                </div>
                                <div data-lang="en-US">
                                    <img src="images/logo/nuocanh.jpg" alt="UK Flag"> ENG
                                </div>
                            </div>
                        </div>

                        <button type="button" id="voiceSearchBtn">🎤</button>
                        <button type="submit" id="searchButton">SEARCH</button>
                    </form>   
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
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const voiceSearchBtn = document.getElementById("voiceSearchBtn");
        const searchInput = document.getElementById("searchInput");
        const searchForm = document.getElementById("f1");

        // Dropdown chọn ngôn ngữ
        const langBtn = document.getElementById("selectedLanguage");
        const langDropdown = document.getElementById("languageDropdown");
        let selectedLang = "vi-VN"; // Ngôn ngữ mặc định là tiếng Việt

        // Hiển thị menu khi click
        langBtn.addEventListener("click", function () {
            langDropdown.style.display = langDropdown.style.display === "block" ? "none" : "block";
        });

        // Chọn ngôn ngữ
        langDropdown.querySelectorAll("div").forEach(item => {
            item.addEventListener("click", function () {
                selectedLang = this.getAttribute("data-lang"); // Lấy giá trị ngôn ngữ
                langBtn.innerHTML = this.innerHTML; // Cập nhật giao diện
                langDropdown.style.display = "none"; // Ẩn menu
            });
        });

        // Đóng menu nếu click bên ngoài
        document.addEventListener("click", function (event) {
            if (!langBtn.contains(event.target) && !langDropdown.contains(event.target)) {
                langDropdown.style.display = "none";
            }
        });

        // Kiểm tra trình duyệt có hỗ trợ Web Speech API không
        if (!('webkitSpeechRecognition' in window)) {
            alert("Trình duyệt của bạn không hỗ trợ nhận diện giọng nói.");
            return;
        }

        // Khởi tạo đối tượng nhận diện giọng nói
        const recognition = new webkitSpeechRecognition();
        recognition.continuous = false; // Không lắng nghe liên tục
        recognition.interimResults = false; // Chỉ lấy kết quả cuối cùng

        // Xử lý kết quả khi nhận diện giọng nói xong
        recognition.onresult = function (event) {
            let transcript = event.results[0][0].transcript.trim(); // Lấy nội dung và xóa khoảng trắng thừa

            // Loại bỏ dấu chấm cuối câu nếu có
            if (transcript.endsWith(".")) {
                transcript = transcript.slice(0, -1);
            }

            searchInput.value = transcript; // Điền vào ô tìm kiếm
            searchForm.submit(); // Tự động gửi form tìm kiếm
        };

        // Xử lý lỗi (nếu có)
        recognition.onerror = function (event) {
            console.error("Lỗi nhận diện giọng nói:", event.error);
        };

        // Khi nhấn nút micro, đặt ngôn ngữ đã chọn rồi bắt đầu nhận diện giọng nói
        voiceSearchBtn.addEventListener("click", function () {
            recognition.lang = selectedLang;
            recognition.start();
        });
    });
</script>
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
