// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {

  const menu = document.querySelector(".testmenu");
  console.log("test")
  console.log(menu)
  
  const hamburger = document.querySelector(".navbar-burger");
  console.log("hamburger")
  console.log(hamburger)
  
  hamburger.addEventListener("click",
    function(){
      console.log("ハンバーガーボタンがクリックされました");
      menu.classList.toggle("active")
      console.log("click")
    }
  )
  const home = document.querySelector(".testhome");
  console.log("test")
  console.log(home)
  
  const hamburger2 = document.querySelector(".navbar-burger");
  console.log("hamburger2")
  console.log(hamburger2)
  
  hamburger2.addEventListener("click",
    function(){
      console.log("ハンバーガーボタンがクリックされました");
      home.classList.toggle("active")
      console.log("click")
    }
  )
   const top = document.querySelector(".testtop");
  console.log("test")
  console.log(home)
  
  const hamburger3 = document.querySelector(".navbar-burger");
  console.log("hamburger3")
  console.log(hamburger3)
  
  hamburger3.addEventListener("click",
    function(){
      console.log("ハンバーガーボタンがクリックされました");
      top.classList.toggle("active")
      console.log("click")
    }
  )
  // ページが完全に読み込まれたときに実行されるコード
});

//= require jquery
//= require jquery_ujs