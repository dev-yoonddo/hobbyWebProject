$(document).ready(function(){
	//메뉴 클릭할때마다 보이고 숨기기
	$('#userInfo').show();
	
	//정보 수정
	$('#menu1').on('click', function(){
	    $('#userInfo').show();
		$('#userSet').hide();
		$('#userMsg').hide();
	  });
	//데이터 관리
	$('#menu2').on('click', function(){
	  $('#userSet').show();
	  $('#userInfo').hide();
	  $('#userMsg').hide();
	});
	//메시지 관리
	$('#menu3').on('click', function(){
	  $('#userMsg').show();
	  $('#userInfo').hide();
	  $('#userSet').hide();
	});
	
	//원하는 데이터 목록 보기
	//게시글 목록은 제외하고 모두 숨기기
	$('#cmtData').hide(); $('#groupData').hide(); $('#memberData').hide();
	
	//보기를 클릭한 데이터 외 나머지는 숨기기
	$('#view1').on('click', function(){
		$('#boardData').show();
		$('#cmtData').hide(); $('#groupData').hide(); $('#memberData').hide();
	});
	$('#view2').on('click', function(){
		$('#cmtData').show();
		$('#boardData').hide(); $('#groupData').hide(); $('#memberData').hide();
	});
	$('#view3').on('click', function(){
		$('#groupData').show();
		$('#boardData').hide(); $('#cmtData').hide(); $('#memberData').hide();
	});
	$('#view4').on('click', function(){
		$('#memberData').show();
		$('#boardData').hide(); $('#cmtData').hide(); $('#groupData').hide();
	});
	
	//메시지관리
	$('#sendMsgData').hide();
	$('#view5').on('click', function(){
		$('#msgData').show();
		$('#sendMsgData').hide();
	});
	$('#view6').on('click', function(){
		$('#sendMsgData').show();
		$('#msgData').hide();
	});
	
	//내가 작성한 게시글 더보기
	var viewCount = 5; // 클릭할 때 마다 보여질 갯수
	var lastIndex = viewCount - 1; //보여질 글의 마지막 인덱스
	var rows = $('.showWrite').length; //전체 글 갯수
	$('.showWrite').slice(viewCount).hide(); // 처음 viewCount개의 글을 제외하고 모두 숨기기

	$("#more-btn").click(function(e){ //more-btn을 클릭했을때
	    e.preventDefault();
	    if(rows <= lastIndex + 1){ //만약 전체 글의 수가 lastIndex +1 한 값보다 작거나 같으면
	        alert("마지막 글입니다"); //마지막 글이라는 알림창 띄우기
		    return; //return을 하지않으면 알림창을 띄우고 또 다음으로 실행된다.
	    
	    }
	    $('.showWrite').slice(lastIndex + 1, lastIndex + 1 + viewCount).show('slow'); // 처음 출력한 글의 다음 글들을 보여준다.
	    $('.showWrite').slice(0, lastIndex + 1).hide(); // 0부터 이전의 글들을 모두 숨긴다.
	    lastIndex += viewCount; // 다음 글 출력을 위해 lastIndex에 viewCount를 더해준다.
	    
	});
	 
	//내가 작성한 댓글 더보기 viewCount lastIndex는 이미 위에서 선언함
    var viewCount2 = 5;
	var lastIndex2 = viewCount2 - 1;
	var rows2 = $('.showCmt').length;
	$('.showCmt').slice(viewCount2).hide(); 

	$("#more-btn-2").click(function(e){ 
	    e.preventDefault();
	    if(rows2 <= lastIndex2 + 1){ 
	        alert("마지막 댓글입니다");
	        return;
	    }
	    $('.showCmt').slice(lastIndex2 + 1, lastIndex2 + 1 + viewCount2).show('slow'); 
	    $('.showCmt').slice(0, lastIndex2 + 1).hide();
	    lastIndex2 += viewCount2;
	});
	
	//내가 생성한 그룹 더보기
	var viewCount3 = 5;
	var lastIndex3 = viewCount3 - 1;
	var rows3 = $('.showGroup').length;
	$('.showGroup').slice(viewCount3).hide();

	$("#more-btn-3").click(function(e){ 
	    e.preventDefault();
	    if(rows3 <= lastIndex3 + 1){ 
	        alert("마지막 그룹입니다");
	        return;
	    }
	    $('.showGroup').slice(lastIndex3 + 1, lastIndex3 + 1 + viewCount3).show('slow');
	    $('.showGroup').slice(0, lastIndex3 + 1).hide(); 
	    lastIndex3 += viewCount3;
	});
	
	//내가 가입한 그룹 더보기
	var viewCount4 = 5;
	var lastIndex4 = viewCount4 - 1;
	var rows4 = $('.showMember').length;
	$('.showMember').slice(viewCount4).hide();

	$("#more-btn-4").click(function(e){ 
	    e.preventDefault();
	    if(rows4 <= lastIndex4 + 1){ 
	        alert("마지막 그룹입니다"); 
	        return;
	    }
	    $('.showMember').slice(lastIndex4 + 1, lastIndex4 + 1 + viewCount4).show('slow'); 
	    $('.showMember').slice(0, lastIndex4 + 1).hide();
	    lastIndex4 += viewCount4; 
	});
	
	//받은 메시지 더보기
	var viewCount5 = 5;
	var lastIndex5 = viewCount5 - 1;
	var rows5 = $('.showRcvMsg').length;
	$('.showRcvMsg').slice(viewCount5).hide();

	$("#more-btn-5").click(function(e){ 
	    e.preventDefault();
	    if(rows5 <= lastIndex5 + 1){ 
	        alert("마지막 메시지입니다"); 
	        return;
	    }
	    $('.showRcvMsg').slice(lastIndex5 + 1, lastIndex5 + 1 + viewCount5).show('slow'); 
	    $('.showRcvMsg').slice(0, lastIndex5 + 1).hide();
	    lastIndex5 += viewCount5; 
	});
	
	//보낸 메시지 더보기
	var viewCount6 = 5;
	var lastIndex6 = viewCount6 - 1;
	var rows6 = $('.showSendMsg').length;
	$('.showSendMsg').slice(viewCount6).hide();

	$("#more-btn-6").click(function(e){ 
	    e.preventDefault();
	    if(rows6 <= lastIndex6 + 1){ 
	        alert("마지막 메시지입니다"); 
	        return;
	    }
	    $('.showSendMsg').slice(lastIndex6 + 1, lastIndex6 + 1 + viewCount6).show('slow'); 
	    $('.showSendMsg').slice(0, lastIndex6 + 1).hide();
	    lastIndex6 += viewCount6; 
	});
	
	//그룹 수신 메시지 더보기
	$('.showRcvGrMsg').hide();
    $('.showRcvGrMsg').slice(0, 5).show(); // 초기갯수
    $("#more-btn-msg").click(function(e){ // 클릭시 more
        if($('.showRcvGrMsg:hidden').length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막 글입니다."); // 컨텐츠 없을시 alert 창 띄우기 
        }
        e.preventDefault();
        $('.showRcvGrMsg:hidden').slice(0, 5).show('slow'); // 클릭시 more 갯수 지저정
	});
    
    //이벤트신청 리스트 더보기
    $('.showEventList').hide();
    $('.showEventList').slice(0, 5).show(); // 초기갯수
    $("#more-btn-event").click(function(e){ // 클릭시 more
        if($('.showEventList:hidden').length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막입니다."); // 컨텐츠 없을시 alert 창 띄우기
        }
        e.preventDefault();
        $('.showEventList:hidden').slice(0, 5).show('slow'); // 클릭시 more 갯수 지저정
	});

});