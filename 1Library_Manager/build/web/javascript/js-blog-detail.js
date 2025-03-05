/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function addCommentBlogDetail(userId, blogDetailId) {
    let rating = document.getElementById("rating-blog-detail").value;
    let content = document.getElementById("content-comment-blog-detail").value;


    $.ajax({
        url: `/TechStore/commentblogdetail`,
        type: 'get',
        data: {
            userId: userId,
            blogDetailId: blogDetailId,
            rating: rating,
            content: content,
            option: 'add'
        }, success: function (response) {
            var row = document.getElementById("list-comment-blog-detail");
            row.innerHTML = response;

            showToast("Add comment successfuly, awaiting approval!");
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}


function showToast(text) {
    const container = document.getElementById('toast-container');

    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.innerHTML = `${text} <div class="progress"></div>`;

    const closeBtn = document.createElement('button');
    closeBtn.className = 'close-btn';
    closeBtn.innerHTML = '&times;';
    closeBtn.onclick = () => toast.remove();

    toast.appendChild(closeBtn);
    container.insertBefore(toast, container.firstChild);

    setTimeout(() => {
        toast.remove();
    }, 5000);
}



function selectEditComment(commentId, contentOld, blogDetailId) {
    document.getElementById("message-text").value = contentOld;
    document.getElementById("commentId-change").value = commentId;
    document.getElementById("blogDetailId-change").value = blogDetailId;
}

function saveChange() {
    let content = document.getElementById("message-text").value
    let commentId = document.getElementById("commentId-change").value;
    let blogDetailId = document.getElementById("blogDetailId-change").value;

    $.ajax({
        url: `/TechStore/commentblogdetail`,
        type: 'get',
        data: {
            commentId: commentId,
            blogDetailId: blogDetailId,
            content: content,
            option: 'edit'
        }, success: function (response) {
            var row = document.getElementById("list-comment-blog-detail");
            row.innerHTML = response;

            showToast("Edit comment successfuly!");
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}

function deleteComment(commentId, blogDetailId) {
    if (window.confirm("Bạn có chắc chắn muốn xóa comment này không?")) {
        $.ajax({
            url: `/TechStore/commentblogdetail`,
            type: 'get',
            data: {
                commentId: commentId,
                blogDetailId: blogDetailId,
                option: 'delete'
            }, success: function (response) {
                var row = document.getElementById("list-comment-blog-detail");
                row.innerHTML = response;

                showToast("Delete comment successfuly!");
            }, error: function (fail) {
                console.log("loi get search product" + fail);
            }
        });
    }
}

function loadMoreComment(blogDetailId, total) {
    let countComment = document.getElementsByClassName("comment").length;


    $.ajax({
        url: `/TechStore/loadmorecommentblogdetail`,
        type: 'get',
        data: {
            blogDetailId: blogDetailId,
            countComment: countComment
        }, success: function (response) {
            var row = document.getElementById("list-comment-blog-detail");
            row.innerHTML += response;
            let countComment = document.getElementsByClassName("comment").length;
//            if (countComment == total) {
//                document.getElementById("loadMoree").style.display = 'none';
//            }else{
//                document.getElementById("loadMoree").style.display = 'block';
//            }

        }, error: function (fail) {
            console.log("loi get load more comment" + fail);
        }
    });
}