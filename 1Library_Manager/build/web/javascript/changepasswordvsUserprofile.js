/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Get the modal ChangePassword
var modal = document.getElementById("password_modal");

// Get the button that opens the modal
var btn = document.getElementById("openModalBtn");

// Get the <span> element that closes the modal
//  var span = document.getElementsByClassName("btn");
var close = document.getElementById("close-changePassword");
// click change password to display

var password = document.getElementById("box1");
var password2 = document.getElementById("box2");
var password3 = document.getElementById("box3");
btn.onclick = function () {
    modal.style.display = "block";
};

// Click close to close
close.onclick = function () {
    modal.style.display = "none";
    password.value = "";
    password2.value = "";
    password3.value = "";
};

//  When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
        password.value = "";
        password2.value = "";
        password3.value = "";
    }
};





//Lay modal container User 
var modalProfile = document.getElementById("user-profile");
//Click de mo modal
var openProfile = document.getElementById("openModalBtn-user");
//Click close modal
var closeProfile = document.getElementById("close-profile");
//Open
openProfile.onclick = function () {
    modalProfile.style.display = "block";
};
//Close
closeProfile.onclick = function () {
    modalProfile.style.display = "none";
};
//  window.onclick = function (event){
//      if(event.target == modalProfile ){
//          modalProfile.style.display ="none";
//      }
//  }

//Show password

var showPassword = document.getElementById("showPassword1");
var showPassword2 = document.getElementById("showPassword2");
var showPassword3 = document.getElementById("showPassword3");


var currentPass = document.getElementById("box1");
var newPass = document.getElementById("box2");
var confirmPass = document.getElementById("box3");
let check = false;
showPassword.onclick = function () {
    if (!check) {
        currentPass.type = "text";
        check = true;
    } else {
        currentPass.type = "password";
        check = false;
    }
};
let check2 = false;
showPassword2.onclick = function () {
    if (!check2) {
        newPass.type = "text";
        check2 = true;
    } else {
        newPass.type = "password";
        check2 = false;
    }
};
let check3 = false;
showPassword3.onclick = function () {
    if (!check3) {
        confirmPass.type = "text";
        check3 = true;
    } else {
        confirmPass.type = "password";
        check3 = false;
    }
};
//Ket thuc show password

