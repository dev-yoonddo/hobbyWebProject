<%@page import="comment.CommentDTO"%>
<%@page import="comment.CommentDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@500&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
::-webkit-scrollbar {
	display: none;
}

section {
	height: auto;
	padding-top: 50px;
}
#community{
	padding: 70px;
}
.select-hobby{
	height: 150px;
	max-height: 500px;
	margin: 30px;
}
.select-hobby.small{
	height: 80px;
	display: flex;
	align-items: center;
	
}

#searchField{
	width: 550px;
	margin: 0 auto;
}
#searchField2{
	width: 400px;
	margin: 0 auto;
}
#searchField2 > #select-sec {
	width: 400px;
}
#searchField2 > #select-sec .select .text {
	font-size: 13pt;
}
.select {
	position: relative;
	width: 500px;
}

.select .option-list {
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	overflow: hidden;
	max-height: 0;
	background-color: white;
	z-index: 99999;
}

.select.active .option-list {
	max-height: none;
}

/* select css */
#select-sec {
	width: 550px;
	height: 55px;
	font-size: 16pt;
	font-weight: bold;
	color: #6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
	display: flex;
}

#select-sec .select {
	box-shadow: 0 0 10px #86A5FF;
	border-radius: 15px;
	padding: 15px;
	cursor: pointer;
}

#select-sec .select .text {
	font-size: 16pt;
	font-weight: bold;
	color: #6e6e6e;
	display: flex;
}

.option {
	display: flex;
}

span {
	margin: 0 auto;
}

#select-sec .select .option-list {
	list-style: none;
	padding: 0;
	border-radius: 15px;
	box-shadow: 0 0 10px #86A5FF;
}

#select-sec .select .option-list .option {
	padding: 15px;
}

#select-sec .select .option-list .option:hover {
	border-radius: 15px;
	background-color: #E0EBFF;
}

/* search btn */
#search-btn {
	border: 0;
	outline: 0;
	width: 70px;
	height: 55px;
	border-radius: 15px;
	border-color: #86A5FF;
	background-color: #E0EBFF;
	margin-left: 15px;
	box-shadow: 0 0 10px #86A5FF;
	cursor: pointer;
}

#sc {
	font-size: 16pt;
	font-weight: bold;
	color: 6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
}

/* board css */
.board-container{
	margin: 0 auto;
}
#search-title{
	display: flex;
}
#animation-title{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20pt;
	font-weight: 300;
	color: #505050;
    display: flex;
    align-items: center;
	position: relative;
    animation: fadeInLeft 2s;
}
#animation-title h4{
	margin-left: 30px;
}
@keyframes fadeInLeft {
    0% {
        opacity: 0;
        transform: translate3d(-100%, 0, 0);
    }
    to {
        opacity: 1;
        transform: translateZ(0);
    }
}
table{
	width: auto;
	min-width: 1000px;
	text-align: center;
	border-collapse: collapse;
}
thead{
	height: 30px;
	font-size: 13pt;
}
tbody{
}
th{
	color: #6e6e6e;
	text-align: center;
	height: 35px;
	border-radius: 30px;
	background-color: #D9E1FC;
	margin-right: 10px;
}
th span{
	font-size: 14pt;
}
.board-head{
	padding: 20px;

}
.board-row{
	border-bottom: solid 1px #E0E0E0;
}

#row-btn-sec{
	width:auto;
	display: flex;
	margin: 0;
	padding: 0;
}
#more-btn{
	width: 100px;
	margin: 0 auto;
	font-size: 15pt;
	font-weight: bold;
	color: #404040;
	cursor: pointer;
}
#more-btn:hover{
	color: #E0E0E0;
}
#click-view{
	justify-content: center;
	align-items: center;
}
#click-view:hover{
	font-weight: 400;
	text-decoration: underline;
	color: #606060;
}
/* 공지 */
#notice-animated{
	width: auto;
	height: 30px;
	padding: 10px;
	border-color: #909090;
	border-top: thin solid black;
	border-bottom: thin solid black;
	margin-bottom: 10px;
	justify-content: center;
	position: relative;
	overflow-x: hidden;
	overflow-y: hidden;
}
#notice{
	width: auto;
	height: auto;
	position: absolute;
	white-space: nowrap;
	will-change: transform;
	animation: marquee 13s linear infinite;
	z-index: 5;
}
#notice-inner{
	height: 30px;
	display: flex;
	font-size: 15pt;
	align-items: center;
	margin: 10px 5px;
}
#notice-option:hover{
	font-weight: bold;
	color:#606060;
}
#notice-option:visited{
	color: purple;
}
/* 공지 애니메이션 */
@keyframes marquee {
  from { transform: translateY(20%); }
  to { transform: translateY(-100%); }
}

@media screen and (max-width:900px) {
	table{
		min-width: 600px;
	}
	th span{
		font-size: 12pt;
	}
	#search-title{
		display: block;
		margin-bottom: 50px;
	}
	#search-title h2{
		margin: 0;
	}
	#search-title h4{
		margin: 0;
		font-size: 16pt;
	}
	td{
		font-size: 12pt;
	}
	#click-view{
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		max-width:200px;
	}
}

@media screen and (max-width:650px) {
	table{
		min-width: 350px;
	}
	th span{
		font-size: 11pt;
	}
	#search-title{
		margin-bottom: 30px;
	}
	#search-title h2{
		font-size: 18pt;
	}
	#search-title h4{
		font-size: 14pt;
	}
	#animation-title{
		max-width: 250px;
		display: inline;
		padding-left: 30px;
	}
	.date{
		display: none;
	}
	td{
		font-size: 12pt;
	}
	.ttt{
		width: 100px;
	}
	#click-view{
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		max-width:100px;
	}
	.btn-blue span{
		font-size: 10pt;
	}
	#searchField{
		width: 400px;
		margin: 0 auto;
	}
	#select-sec {
		width: 400px;
	}
	#select-sec .select .text {
		font-size: 13pt;
	}
}

</style>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID=null;
	int boardID = 0;
	String boardCategory = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	//선택한 카테고리 가져오기
	if(request.getParameter("search") != null || request.getParameter("search") != ""){
		boardCategory = request.getParameter("search");
	}else{
		script.println("error");
		script.close();
	}

	UserDTO user=new UserDAO().getUserVO(userID);
	BoardDAO boardDAO = new BoardDAO();
	CommentDAO cmtDAO = new CommentDAO();
	BoardDTO board = new BoardDAO().getBoardVO(boardID);
	ArrayList<BoardDTO> boardlist = new ArrayList<>();
%>
<header>
	<jsp:include page="/header/header.jsp"/>
</header>
<section>
<div id="community">
	<%
	//처음 접속시엔 boardCategory == null이기 때문에 검색창만 노출
	if(boardCategory == null){
	%>
	<div class="select-hobby">
		<form method="post" id ="searchField" action="community" onsubmit="return searchPage(search)">
			<div id="select-sec">
				<div class="select">
					<div class="text">
						<input type="hidden" name="search" value="">
						<span>함께 하고싶은 취미를 선택하세요 !</span>
						<span><i class="fa-solid fa-chevron-down"></i></span>
					</div>
				<ul class="option-list">
					<li class="option"><input type="hidden" name="search" id="SPORTS" value="SPORTS"><span>SPORTS</span></li>
					<li class="option"><input type="hidden" name="search" id="LEISURE" value="LEISURE"><span>LEISURE</span></li>
					<li class="option"><input type="hidden" name="search" id="MUSIC" value="MUSIC"><span>MUSIC</span></li>
					<li class="option"><input type="hidden" name="search" id="OTHER" value="OTHER"><span>OTHER</span></li>
				</ul>
				</div>
				<div id="submit-btn">
					<button type="submit" id="search-btn"><span id="sc">검색</span></button>
				</div>
			</div>
		</form>
	</div>
	<%
	//특정 카테고리를 검색하면 boardCategory값을 가져오므로 글 리스트 노출
	//파라미터 값이 정상적으로 넘어오지 않았거나 노출할 리스트가 없으면 PrintWriter로 오류값 전송
	}else{
		boardlist = boardDAO.getSearch(boardCategory);

	%>
	<div class="board-container" id="board-list">
		<div id="search-title">
			<div id="animation-title">
			<h2><%=boardCategory%></h2><h4>함께 할 사람들과 이야기 나눠보세요</h4>
			</div>
			<div class="select-hobby small">
				<form method="post" id ="searchField2" action="community" onsubmit="return searchPage(search)">
					<div id="select-sec">
						<div class="select">
							<div class="text">
								<input type="hidden" name="search" value="">
								<span>함께 하고싶은 취미를 선택하세요 !</span>
								<span><i class="fa-solid fa-chevron-down"></i></span>
							</div>
						<ul class="option-list">
							<li class="option"><input type="hidden" name="search" id="SPORTS" value="SPORTS"><span>SPORTS</span></li>
							<li class="option"><input type="hidden" name="search" id="LEISURE" value="LEISURE"><span>LEISURE</span></li>
							<li class="option"><input type="hidden" name="search" id="MUSIC" value="MUSIC"><span>MUSIC</span></li>
							<li class="option"><input type="hidden" name="search" id="OTHER" value="OTHER"><span>OTHER</span></li>
						</ul>
						</div>
						<div id="submit-btn">
							<button type="submit" id="search-btn"><span id="sc">검색</span></button>
						</div>
					</div>
				</form>
			</div>
		</div><br>
		
		<div id="notice-animated">
			<!-- 관리자 공지사항 리스트 -->
			<div id="notice">
			<% 
				ArrayList<BoardDTO> noticelist = boardDAO.getNotice();
				for(BoardDTO notice : noticelist){
			%>
				<div id="notice-inner">
					<div id="notice-option" onclick="location.href='view?boardID=<%= notice.getBoardID() %>'">
					<i class="fa-regular fa-bell"></i>&nbsp;&nbsp;<%= notice.getBoardTitle()%>
					</div>
				</div>
			<%
				}
			%>
			</div>
		</div>
		<!-- 게시글 리스트 -->
		<div class="row">
			<table>
				<thead>
					<tr class="board-head">
						<th class="ttt" style="width: 10%;"><span>조회수</span></th>
						<th class="tt" style="width: 30%;"><span>제목</span></th>
						<th class="ttt" style="width: 10%;"><span>작성자</span></th>
						<th class="ttt" style="width: 10%;"><span>좋아요</span></th>
						<th class="ttt" style="width: 10%;"><span>댓글</span></th>
						<th class="date" style="width: 25%;"><span>작성일</span></th>
					</tr>
				</thead>
				<tbody>
					<%
						for (BoardDTO bd : boardlist) {
					%>
					<tr class="board-row">
						<td><%=bd.getViewCount()%></td>
						<%
							if(bd.getFilename() == null){
						%>
							<td><a id="click-view" href="view?boardID=<%= bd.getBoardID() %>"><%= bd.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<%
							}else{
						%>
							<td><a id="click-view" href="view?boardID=<%= bd.getBoardID() %>"><%= bd.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>&nbsp;&nbsp;<i class="fa-solid fa-paperclip"></i></a></td>
						<%
							}
						%>
						<td><%= bd.getUserID() %></td>
						<td><%=bd.getHeartCount()%></td>
						<%
		                 	ArrayList<CommentDTO> cmtlist = cmtDAO.getList(bd.getBoardID());
	                 	%>
						<td><%= cmtlist.size() %></td>
						<td class="date" ><%= bd.getBoardDate().substring(0 ,11) + bd.getBoardDate().substring(11, 13) + "시" + bd.getBoardDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>	
		<% 
			if( boardlist.size() > 10 ){ //검색된 리스트의 갯수가 10개 이상일때만 더보기 버튼 보이기
		%>
		<br><div id="row-btn-sec">
			<div id="more-btn">
				<a>
				<span>MORE</span>	    
				<i class="fa-solid fa-chevron-down"></i>
				</a>
			</div>
		</div>
		<% 
			}
		%>
		
			<button type="button" class="btn-blue" id="search" onclick="location.href='mainPage'"><span>메인으로</span></button>
		<% 
			if( userID != null ){
		%>
			<button type="button" class="btn-blue" id="write" onclick="location.href='write?category=<%= boardCategory %>'"><span>글쓰기</span></button>
		<% 
			}
		
		}
		%>
	</div>
</div>
</section>

<script>
function searchPage(category){
	//name = search인 요소들 중 0번째 인덱스 값 가져오기
	var select = category[0];
	if(select.value === ''){
		alert('카테고리를 선택하세요.');
		return false;
	}else{
		var data = {
	        search: select
	    };
		$.ajax({
	        type: 'GET',
	        //url: 'https://toogether.me/spotAccess',
	        url: 'community',
	        data: data,
	        success: function (response) {
	        	if (response.includes("error")) {
	        		alert('오류 발생');
	        		return false;
	        	}else{
	        		location.href='community?search=' + select.value;
	        	}
	        },
		     error: function (xhr, status, error) {
		         //console.error('Spot registration error:', error);
		         alert('오류');
		     }
	    });
	}
}
</script>
<script>
//게시글 더보기
$(document).ready(function(){
	$('.board-row').hide();
    $('.board-row').slice(0, 10).show(); // 초기갯수
    $("#more-btn").click(function(e){ // 클릭시 more
        if($('.board-row:hidden').length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막 글입니다."); // 컨텐츠 없을시 alert 창 띄우기 
        }
        e.preventDefault();
        $('.board-row:hidden').slice(0, 5).show('slow'); 
	});
});
//select box 클릭하면 접고 펼치기
function onClickSelect(e) {
	const isActive = e.currentTarget.className.indexOf("active") !== -1;
	if (isActive) {
	  e.currentTarget.className = "select";
	} else {
	  e.currentTarget.className = "select active";
	  //if(document.getElementsByName("selected") != null){
		//  var select = document.getElementsByName("selected");
		//  select.setAttribute("name", "search");
	  //}
	}
}
document.querySelector("#select-sec .select").addEventListener("click", onClickSelect);

//클릭한 값을 박스안에 넣기
function onClickOption(e) {
	const selectedValue = e.currentTarget.innerHTML;
	document.querySelector("#select-sec .text").innerHTML = selectedValue;
	//console.log(e.currentTarget);
	//console.log($('input[name=search]'));
	//e.currentTarget.setAttribute("name","selected");
	//document.getElementsByName("selected").setAttribute("name", "search");
}

var optionList = document.querySelectorAll("#select-sec .option");
for (var i = 0; i < optionList.length; i++) {
	var option = optionList[i];
	option.addEventListener("click", onClickOption);
}
  
//검색버튼 깜빡이기
var speed=500 

function flashit(){ 
	var flash=document.getElementById? document.getElementById("sc") : document.all? document.all.myexample : "" 
	if (flash){ 
		if (flash.style.color.indexOf("rgb(255, 255, 255)")!=-1) 
			flash.style.color="#6e6e6e" 
		else 
			flash.style.color="rgb(255, 255, 255)" 
	}
} 
setInterval("flashit()", speed);
</script>

</body>
</html>