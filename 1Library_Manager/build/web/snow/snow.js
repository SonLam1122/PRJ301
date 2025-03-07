/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function createSnowflake() {
    const snowflake = document.createElement("div");
    snowflake.classList.add("snowflake");
    snowflake.innerHTML = "&#10052;";
    document.body.appendChild(snowflake);

    snowflake.style.left = Math.random() * window.innerWidth + "px";
    snowflake.style.animationDuration = (Math.random() * 3 + 2) + "s";

    setTimeout(() => snowflake.remove(), 5000);
}

setInterval(createSnowflake, 100);

document.addEventListener("click", function(e) {
    const effect = document.createElement("div");
    effect.classList.add("click-effect");
    effect.style.left = e.pageX + "px";
    effect.style.top = e.pageY + "px";
    document.body.appendChild(effect);
    setTimeout(() => effect.remove(), 500);
});
