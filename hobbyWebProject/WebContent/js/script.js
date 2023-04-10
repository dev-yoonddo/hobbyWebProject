
//navbar togglebuttton 눌렀을 때 메뉴 펼치고 접기
const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_menu');
const icons = document.querySelector('.navbar_login');

toggleBtn.addEventListener('click', () =>{
	menu.classList.toggle('active');
	icons.classList.toggle('active');

});

//navbar toggle버튼 클릭했을 때 상단으로 이동하지 않고 현재 스크롤 위치 유지하기
window.addEventListener("scroll", (event) => {
    let scrollY = this.scrollY;
    let scrollX = this.scrollX;
    function toggleAct() {
		window.scrollTo({scrollY, scrollX, behavior: ''});
	}
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

const $topBtn = document.querySelector(".moveTop");

//버튼 클릭 시 맨 위로 이동
$topBtn.onclick = () => {
window.scrollTo({ top: 0, behavior: "smooth" });  
}

const $bottomBtn = document.querySelector(".moveBottom");

//버튼 클릭 시 페이지 하단으로 이동
$bottomBtn.onclick = () => {
window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
};

//password check
function passwordCheck(obj) {
//	alert('passwordCheck()');
	
//	입력한 비밀번호가 8자 이상 12자 이하인가 검사한다.
	var len = obj.userPassword.value.trim().length;
	if (len < 8 || len > 12) {
		alert('비밀번호는 8자 이상 12자 이하로 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}
	
//	영문자, 숫자, 특수문자가 각각 1개 이상 입력되었나 검사한다.
	var alphaCount = 0;
	var numberCount = 0;
	var etcCount = 0;
//	입력된 비밀번호의 문자 개수만큼 반복하며 영문자, 숫자, 특수문자의 개수를 센다.
	var pw = obj.userPassword.value.trim();
	for (var i = 0; i < len; i++) {
		if (pw.charAt(i) >= 'a' && pw.charAt(i) <= 'z' || pw.charAt(i) >= 'A' && pw.charAt(i) <= 'Z') {
			alphaCount++;
		} else if (pw.charAt(i) >= '0' && pw.charAt(i) <= '9') {
			numberCount++;
		} else {
			etcCount++;
		}
	}
//	alert('영문자: ' + alphaCount + "개\n숫자: " + numberCount + "개\n특수문자: " + etcCount);
	if (alphaCount == 0 || numberCount == 0 || etcCount == 0) {
		alert('영문자, 숫자, 특수문자는 각각 1개 이상 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}
	return true;
}

function passwordCheck2() {
	var userPassword = $('#userPassword').val();
	var userPassword1 = $('#userPassword1').val();
	if (userPassword != userPassword1) {
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	} else {
		$('#passwordCheckMessage').html('');
	}
}