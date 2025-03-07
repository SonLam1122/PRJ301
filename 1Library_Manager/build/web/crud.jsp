<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="images" href="${pageContext.request.contextPath}/images/icons/favicon.png">
        <style>
            body {
                color: #566787;
                background: #f5f5f5;
                font-family: 'Varela Round', sans-serif;
                font-size: 13px;
            }
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px 25px;
                border-radius: 3px;
                min-width: 1000px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                background: #435d7d;
                color: #fff;
                padding: 16px 30px;
                min-width: 100%;
                margin: -20px -25px 10px;
                border-radius: 3px 3px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .btn-group {
                float: right;
            }
            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }
            .table-title .btn i {
                float: left;
                font-size: 21px;
                margin-right: 5px;
            }
            .table-title .btn span {
                float: left;
                margin-top: 2px;
            }
            table.table tr th, table.table tr td {
                border-color: #e9e9e9;
                padding: 12px 15px;
                vertical-align: middle;
            }
            table.table tr th:first-child {
                width: 60px;
            }
            table.table tr th:last-child {
                width: 100px;
            }
            table.table-striped tbody tr:nth-of-type(odd) {
                background-color: #fcfcfc;
            }
            table.table-striped.table-hover tbody tr:hover {
                background: #f5f5f5;
            }
            table.table th i {
                font-size: 13px;
                margin: 0 5px;
                cursor: pointer;
            }
            table.table td:last-child i {
                opacity: 0.9;
                font-size: 22px;
                margin: 0 5px;
            }
            table.table td a {
                font-weight: bold;
                color: #566787;
                display: inline-block;
                text-decoration: none;
                outline: none !important;
            }
            table.table td a:hover {
                color: #2196F3;
            }
            table.table td a.edit {
                color: #FFC107;
            }
            table.table td a.delete {
                color: #F44336;
            }
            table.table td i {
                font-size: 19px;
            }
            table.table .avatar {
                border-radius: 50%;
                vertical-align: middle;
                margin-right: 10px;
            }
            .pagination {
                float: right;
                margin: 0 0 5px;
            }
            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }
            .pagination li a:hover {
                color: #666;
            }
            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }
            .pagination li.active a:hover {
                background: #0397d6;
            }
            .pagination li.disabled i {
                color: #ccc;
            }
            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }
            .hint-text {
                float: left;
                margin-top: 10px;
                font-size: 13px;
            }
            /* Custom checkbox */
            .custom-checkbox {
                position: relative;
            }
            .custom-checkbox input[type="checkbox"] {
                opacity: 0;
                position: absolute;
                margin: 5px 0 0 3px;
                z-index: 9;
            }
            .custom-checkbox label:before{
                width: 18px;
                height: 18px;
            }
            .custom-checkbox label:before {
                content: '';
                margin-right: 10px;
                display: inline-block;
                vertical-align: text-top;
                background: white;
                border: 1px solid #bbb;
                border-radius: 2px;
                box-sizing: border-box;
                z-index: 2;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                content: '';
                position: absolute;
                left: 6px;
                top: 3px;
                width: 6px;
                height: 11px;
                border: solid #000;
                border-width: 0 3px 3px 0;
                transform: inherit;
                z-index: 3;
                transform: rotateZ(45deg);
            }
            .custom-checkbox input[type="checkbox"]:checked + label:before {
                border-color: #03A9F4;
                background: #03A9F4;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                border-color: #fff;
            }
            .custom-checkbox input[type="checkbox"]:disabled + label:before {
                color: #b8b8b8;
                cursor: auto;
                box-shadow: none;
                background: #ddd;
            }
            /* Modal styles */
            .modal .modal-dialog {
                max-width: 400px;
            }
            .modal .modal-header, .modal .modal-body, .modal .modal-footer {
                padding: 20px 30px;
            }
            .modal .modal-content {
                border-radius: 3px;
                font-size: 14px;
            }
            .modal .modal-footer {
                background: #ecf0f1;
                border-radius: 0 0 3px 3px;
            }
            .modal .modal-title {
                display: inline-block;
            }
            .modal .form-control {
                border-radius: 2px;
                box-shadow: none;
                border-color: #dddddd;
            }
            .modal textarea.form-control {
                resize: vertical;
            }
            .modal .btn {
                border-radius: 2px;
                min-width: 100px;
            }
            .modal form label {
                font-weight: normal;
            }
            /*css cho chart*/
            /* Căn chỉnh toàn bộ thẻ card */
            .card {
                border: none !important;
                border-radius: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            /* Tùy chỉnh card từng loại */
            .card-mini {
                padding: 15px;
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: white;
                transition: transform 0.3s ease-in-out;
            }

            .card-mini:hover {
                transform: scale(1.05);
            }

            /* Các màu khác nhau cho từng card */
            .card-1 {
                background: linear-gradient(135deg, #ff7eb3, #ff758c);
            }

            .card-2 {
                background: linear-gradient(135deg, #ffb347, #ffcc33);
            }

            .card-3 {
                background: linear-gradient(135deg, #42e695, #3bb2b8);
            }

            .card-4 {
                background: linear-gradient(135deg, #667eea, #764ba2);
            }

            /* Tùy chỉnh icon */
            .card-mini span {
                font-size: 40px;
                display: block;
                margin-top: 10px;
            }

            /* Căn giữa nội dung card */
            .card-body {
                text-align: center;
            }

            /* Bỏ border của bảng biểu đồ */
            .card-default {
                border: none !important;
                border-radius: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Form chọn ngày */
            .form-control {
                border-radius: 10px;
                border: none;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 8px 12px;
            }

            /* Button */
            .btn-primary {
                background-color: #007bff;
                border: none;
                border-radius: 10px;
                padding: 8px 16px;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            /* Link chi tiết */
            .card-footer a {
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }

            .card-footer a:hover {
                text-decoration: underline;
            }

            /* Tiêu đề lớn (User Activity) */
            .card-header h2 {
                font-size: 22px;
                font-weight: bold;
                color: #333;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            /* Nhãn (Select Date Range) */
            .card-header label {
                font-weight: 600;
                color: #555;
            }

            /* Tùy chỉnh dropdown */
            #dateRange {
                background: white;
                border-radius: 10px;
                border: none;
                padding: 8px 12px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            /* Tùy chỉnh input date */
            #startDate, #endDate {
                border-radius: 10px;
                border: none;
                padding: 8px 12px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            /* Căn chỉnh form */
            .form-inline {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* Chỉnh lại chữ trong button */
            .btn-primary {
                font-weight: bold;
                letter-spacing: 0.5px;
            }





        </style>
        <script>
            $(document).ready(function () {
                // Activate tooltip
                $('[data-toggle="tooltip"]').tooltip();
                // Select/Deselect checkboxes
                var checkbox = $('table tbody input[type="checkbox"]');
                $("#selectAll").click(function () {
                    if (this.checked) {
                        checkbox.each(function () {
                            this.checked = true;
                        });
                    } else {
                        checkbox.each(function () {
                            this.checked = false;
                        });
                    }
                });
                checkbox.click(function () {
                    if (!this.checked) {
                        $("#selectAll").prop("checked", false);
                    }
                });
            });
            function showModal(entityType) {
                $('#add' + entityType + 'Modal').modal('show');
            }
        </script>
    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">

                            <div class="row">
                                <div class="col">
                                    <a href="acrud"><button class="btn btn-secondary"  >Account</button></a>
                                </div>
                                <div class="col">
                                    <a href="lcrud"><button class="btn btn-secondary"  >Library</button></a>
                                </div>
                                <div class="col">
                                    <a href="bcrud"><button class="btn btn-secondary"  >Borrow</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">

                        <h1 style="text-align: center;">Trình quản lý dành cho Admin</h1>


                        <div class="container-fluid">
                            <!-- Card thống kê -->
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                <div class="col">
                                    <div class="card card-mini dash-card card-1 text-center">
                                        <div class="card-body">
                                            <h2 class="mb-1">${totalnumberbook}</h2>
                                            <p>Book Borrowed</p>
                                            <span class="mdi mdi-book"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="card card-mini dash-card card-2 text-center">
                                        <div class="card-body">
                                            <h2 class="mb-1">${totalPeople}</h2>
                                            <p>Total People Borrowed</p>
                                            <span class="mdi mdi-account-clock"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="card card-mini dash-card card-3 text-center">
                                        <div class="card-body">
                                            <h2 class="mb-1">${totalUsers}</h2>
                                            <p>Total Users</p>
                                            <span class="mdi mdi-account-multiple"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Biểu đồ hoạt động -->
                            <div class="row mt-4">
                                <div class="col-lg-10 mx-auto">
                                    <div class="card card-default">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h2>User Activity</h2>
                                            <form id="dateRangeForm" method="get" action="${pageContext.request.contextPath}/crud" class="form-inline">
                                                <label for="dateRange" class="mr-2">Select Date Range:</label>
                                                <select name="dateRange" id="dateRange" class="form-control mr-2" onchange="toggleCustomDateRange()">
                                                    <option value="yesterday" ${param.dateRange == 'yesterday' ? 'selected' : ''}>Yesterday</option>
                                                    <option value="last7days" ${param.dateRange == 'last7days' || param.dateRange == null ? 'selected' : ''}>Last 7 Days</option>
                                                    <option value="last30days" ${param.dateRange == 'last30days' ? 'selected' : ''}>Last 30 Days</option>
                                                    <option value="custom" ${param.dateRange == 'custom' ? 'selected' : ''}>From-To</option>
                                                </select>
                                                <div id="customDateRange" style="display: none;">
                                                    <input type="date" name="startDate" id="startDate" class="form-control mr-2" value="${param.startDate}">
                                                    <input type="date" name="endDate" id="endDate" class="form-control mr-2" value="${param.endDate}">
                                                </div>
                                                <button type="submit" class="btn btn-primary">Apply</button>
                                            </form>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="activity" class="chartjs"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>
                            function toggleCustomDateRange() {
                                var dateRange = document.getElementById('dateRange').value;
                                var customDateRange = document.getElementById('customDateRange');
                                if (dateRange === 'custom') {
                                    customDateRange.style.display = 'block';
                                } else {
                                    customDateRange.style.display = 'none';
                                }
                            }
                        </script>



                        <div class="hint-text"><a href="home.jsp">Back to home</a></div>
                    </div>
                </div>
            </div>        
        </div>


        <!-- Import Chart.js -->
        <!-- Import Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                console.log("Chart.js version:", Chart.version);

                                var activity = document.getElementById("activity");
                                if (!activity) {
                                    console.error("Lỗi: Không tìm thấy canvas #activity!");
                                    return;
                                }

                                var activityData = {
                                first: [
            <c:forEach var="map" items="${dataChart1}" varStatus="loop">
                ${map.borrowedCount}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
                                ],
                                        second: [
            <c:forEach var="map" items="${dataChart1}" varStatus="loop">
                ${map.returnedCount}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
                                        ]
                                }
                                ;

                                var labels = [
            <c:forEach var="map" items="${dataChart1}" varStatus="loop">
                                "${map.date}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
                                ];

                                console.log("borrowedCount:", activityData.first);
                                console.log("returnedCount:", activityData.second);
                                console.log("labels:", labels);

                                if (!activityData.first.length || !activityData.second.length) {
                                    console.error("Dữ liệu biểu đồ trống!");
                                            return;
                                }

                                var ctx = activity.getContext("2d");

                                new Chart(ctx, {
                                    type: "line",
                                    data: {
                                        labels: labels,
                                        datasets: [
                                            {
                                                label: "Người mượn",
                                                borderColor: "rgba(82, 136, 255, .8)",
                                                data: activityData.first,
                                                lineTension: 0,
                                                pointRadius: 5
                                            },
                                            {
                                                label: "Người trả",
                                                borderColor: "rgba(255, 199, 15, .8)",
                                                data: activityData.second,
                                                lineTension: 0,
                                                borderDash: [10, 5]
                                            }
                                        ]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {display: true}
                                        },
                                        scales: {
                                            x: {grid: {display: false}},
                                            y: {ticks: {stepSize: 50}}
                                        }
                                    }
                                });
                            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Kiểm tra nếu chưa có dateRange (lần đầu vào trang)
                const urlParams = new URLSearchParams(window.location.search);
                if (!urlParams.has('dateRange')) {
                    document.getElementById("dateRange").value = "last7days"; // Chọn mặc định
                    document.getElementById("dateRangeForm").submit(); // Tự động gửi form
                }
            });
        </script>



    </body>
</html>
