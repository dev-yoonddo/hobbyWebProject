(function($) {
  $(function($){

//navbar togglebuttton 눌렀을 때 메뉴 펼치고 접기
const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_menu');
const icons = document.querySelector('.navbar_login');

toggleBtn.addEventListener('click', () =>{
	menu.classList.toggle('active');
	icons.classList.toggle('active');

});


//스크롤 시 header color change
$(function(){
    // 스크롤 시 header fade-in
    $(document).on('scroll', function(){
        if($(window).scrollTop() > 200){
            $("#header").removeClass("de-active");
            $("#header").addClass("active");
        }else{
            $("#header").removeClass("active");
            $("#header").addClass("de-active");
        }
    })

});
/*
// 스크롤 움직일때 헤더 숨기기
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('header').outerHeight();

$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    var st = $(this).scrollTop();
    
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    
    if (st > lastScrollTop && st > navbarHeight){
        // Scroll Down
        $('header').removeClass('nav-down').addClass('nav-up');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('header').removeClass('nav-up').addClass('nav-down');
        }
    }
    lastScrollTop = st;
}

*/

var btn = document.querySelectorAll('.arrowBtn')
var slides = document.querySelectorAll('.slide').length - 1
var slot = 0

btn[0].addEventListener('click', function(e){
  if(play) {
    clearInterval(play)
  }
  var e = document.querySelector('.showing')
  
  if(slot == 0) {
    slot = 3   
    document.querySelectorAll('.slide')[slides].classList.add('showing')
    e.classList.remove('showing')     
  } else {
    slot-- 
    e.previousElementSibling.classList.add('showing')
    e.classList.remove('showing')     
  }   
})


btn[1].addEventListener('click', function(e){
  if(play) {
    clearInterval(play)
  }
  var e = document.querySelector('.showing')   
  
  if(slot == slides) {
    slot = 0
    document.querySelectorAll('.slide')[0].classList.add('showing')
    e.classList.remove('showing')      
  } else {
     slot++ 
    e.nextElementSibling.classList.add('showing')
    e.classList.remove('showing')  
  }  
})

function autoPlay() {
  e = document.querySelector('.showing')
  if(slot == slides) {
    slot = 0
    document.querySelectorAll('.slide')[0].classList.add('showing')
    e.classList.remove('showing')      
  } else {
    slot++ 
    e.nextElementSibling.classList.add('showing')
    e.classList.remove('showing')  
  }  
}
var play = setInterval(autoPlay, 5000)

//버튼 클릭 시 맨 위로 이동
$(function(){
    $('.moveTop').on('click', function(){
      window.scrollTo({ top: 0, behavior: "smooth" });  
    });
});


//버튼 클릭 시 페이지 하단으로 이동
$(function(){
    $('.moveBottom').on('click', function(){
      window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
    });
});


  });
})(jQuery);