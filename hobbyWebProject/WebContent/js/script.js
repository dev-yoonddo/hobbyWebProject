(function($) {
  $(function($){
    
//userID == null일때 로그인팝업창 
$(function(){
  $('#go-group-1').on('click',function(){
    var login = confirm('로그인이 필요합니다');
    if (login) {
      window.open("loginPopUp", "Login", "width=500, height=550, top=50%, left=50%");
    }else{
    	
    }
  });
});
 

// ------------------------

/*
//navbar togglebuttton 눌렀을 때 메뉴 펼치고 접기
const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_menu');
const icons = document.querySelector('.navbar_login');

toggleBtn.addEventListener('click', () =>{
	menu.classList.toggle('active');
	icons.classList.toggle('active');

});
*/

//화면 축소 header animation 
$(function(){
	var click = 0;
	//토글버튼을 클릭했을 때
	$('.navbar_toggleBtn').on('click', function(){
		//click == 0이면 접혀있는상태
    	if(click == 0){
    		//deactive class 지우고 active class 추가하기 (css에서 active에 애니메이션 효과 주기)
    		$('.navbar').removeClass("deactive");
    		$('.navbar_toggleBtn').removeClass("deactive");
     		$('.navbar_menu').removeClass("deactive");
 	        $('.navbar_login').removeClass("deactive");      
    		//$('#toggleDeActive').prop('checked',false); --> 체크박스로 시도해봄
 	        $('.navbar').addClass("active");
    		$('.navbar_toggleBtn').addClass("active");
	        $('.navbar_menu').addClass("active");
	        $('.navbar_login').addClass("active");
	        click ++; //click = 1이면 펼쳐있는 상태
    	}else{
    		//click != 0이면 토글버튼을 클릭했을 때 deactive class를 추가하고 active class 지우기 (css에서 deactive에 애니메이션 효과 주기)
    		//$('#toggleDeActive').prop('checked',true);
    		$('.navbar').addClass("deactive");
    		$('.navbar_toggleBtn').addClass("deactive");
	        $('.navbar_menu').addClass("deactive");
	        $('.navbar_login').addClass("deactive");
	        //deactive의 애니메이션 효과가 끝나고 난 후 메뉴 창을 닫기 위해 시간차 두기
    		setTimeout(function(){
    			$('.navbar').removeClass("active");
				$('.navbar_toggleBtn').removeClass("active");
	    		$('.navbar_menu').removeClass("active");
		        $('.navbar_login').removeClass("active");
		        click --; //다시 click - 1 해서 접어있는 상태를 알려주기
    		}, 800);
    	}
    })
});

//큰 화면 스크롤 시 header color change
$(function(){
    // 스크롤 시 header fade-in
    $(document).on('scroll', function(){
        if($(window).scrollTop() > 150){
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

//마우스 커서 이벤트 ------
let a = document.createElement('div');
let header = document.getElementById('header');
//모든 페이지에 <div class="cursor"> 삽입
a.setAttribute("class","cursor");
header.appendChild(a);

let mouseCursor = document.querySelector(".cursor");
//window 객체에 scroll & mouse 이벤트를 추가하고 cursor함수 실행되도록 함
window.addEventListener("scroll", cursor);
window.addEventListener("mousemove", cursor);
//커스텀 커서의 left값과 top값을 커서의 XY좌표값과 일치시킴
function cursor(e) {
mouseCursor.style.left = e.pageX + "px";
mouseCursor.style.top = e.pageY - scrollY + "px";
}
// ------------------

//mainPage 슬라이드
var btn = document.querySelectorAll('.arrowBtn')
var slides = document.querySelectorAll('.slide').length - 1
var slot = 0

//왼쪽 버튼
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
});

//오른쪽 버튼
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
});

//자동으로 슬라이드
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
//------------------

// mainPage 오른쪽 스크롤버튼

//클릭 시 페이지 상단으로 이동
$(function(){
    $('.moveTop').on('click', function(){
      window.scrollTo({ top: 0, behavior: "smooth" });  
    });
});

//클릭 시 페이지 하단으로 이동
$(function(){
    $('.moveBottom').on('click', function(){
      window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
    });
});

$(function(){
    $('.moveBottom').on('click', function(){
      window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
    });
});
//------------------

//userUpdate 페이지
//select box 클릭하면 접고 펼치기
function onClickSelect(e) {
	  const isActive = e.currentTarget.className.indexOf("active") !== -1;
	  if (isActive) {
	    e.currentTarget.className = "select";
	  } else {
	    e.currentTarget.className = "select active";
	  }
	}
	document.querySelector("#select-sec .select").addEventListener("click", onClickSelect);

function onClickOption(e) {
  const selectedValue = e.currentTarget.innerHTML;
  document.querySelector("#select-sec .text").innerHTML = selectedValue;
}

var optionList = document.querySelectorAll("#select-sec .option");
for (var i = 0; i < optionList.length; i++) {
  var option = optionList[i];
  option.addEventListener("click", onClickOption);
 }
//------------------

//메시지 리스트에서 제목을 클릭하면 해당 메시지 상세보기 팝업이 열린다.
function viewMsg(msgID){
   	window.open("viewMsg?msgID=" + msgID , "VIEW MESSAGE", "width=550, height=600, top=50%, left=50%");
}
//문의하기 버튼 클릭시 관리자에게 메시지전송
function qna(){
	window.open("sendMsgPopUp?qna=yes","QNA","width=500, height=550, top=50%, left=50%")
}


//url 뒤 파라미터 안보이게하기
$(document).ready(function() {
	history.replaceState({}, null, location.pathname);  
});

});
})(jQuery);