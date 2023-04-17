<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserVO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/board.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/pagenation.js"></script>
</head>
<style>
section{
padding-top: 150px;
padding-bottom: 150px;
height: auto;
display: flex;

}
.board-container{
margin: 0 auto;
}
#search-title{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20pt;
	font-weight: 400;
	color: #505050;
    display: flex;
    align-items: center;
	position: relative;
    animation: fadeInLeft 2s;
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
width: 1000px;
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
height: 50px;
}
th > span{
padding: 5px 20px;
border-radius: 20px;
background-color: #CCE5FF;
}
tr{
border-bottom: solid 1px #E0E0E0;
}
.btn-black{
	position: relative;
	display: inline-block;
	width: 120px;
	height: 80px;
	background-color: transparent;
	border: none; 
	cursor: pointer;
	margin: 10px;
	float: right;
}

.btn-black span {         
  position: relative;
  display: inline-block;
  font-size: 12pt;
  font-weight: bold;
  letter-spacing: 2px;
  border-radius: 20px;
  width: 100%;
  padding: 10px;
  transition: 0.5s; 
  color: #ffffff;
  background-color: #7D95E5;
  border: 1px solid #7D95E5;
  font-family: 'Nanum Gothic Coding', monospace;
}
.btn-black #search, #write{
font-family: 'Nanum Gothic Coding', monospace;
}
.btn-black::before {
  background-color: #7D95E5;
}

.btn-black span:hover {
  color: #7D95E5;
  background-color: #ffffff
}
#row-btn-sec{
	width:auto;
	display: flex;
	margin: 0;
	padding: 0;
}
#more-btn{
	margin: 0 auto;
	font-size: 15pt;
	font-weight: bold;
	color: #7D95E5;
}
</style>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	int pageNumber = 1; //기본 페이지
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	int boardID = 0;
	if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	BoardVO board = new BoardDAO().getBoardVO(boardID);
	
	%>
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" id ="menu">COMMUNITY</a></li>
				<li><a href="qnaPage.jsp" id="menu">Q & A</a></li>
			</ul>
		</nav>
			<ul class="navbar_login" >
				<%
					if(userID == null){
				%>	
				<li><a href="login.jsp">LOGIN</a></li>
				<li><a href="join.jsp">JOIN</a></li>
				<%
					}else{
				%>
				<li><a href="userUpdate.jsp"><i class="fa-solid fa-gear"></i></a></li>
				<li><a href="logout.jsp">LOGOUT</a></li>
				<%
					}
				%>
			</ul>
			<a onclick="toggleAct()" class="navbar_toggleBtn">
				<i class="fa-solid fa-bars"></i>
			</a>
	</nav>
</div>
</header>
<section>
	<div class="board-container">
		<% 
		BoardDAO boardDAO = new BoardDAO();
		//카테고리를 검색했을 때 테이블 상단에 선택한 카테고리를 출력
		String search = request.getParameter("searchField2");	
		%>
		<div id="search-title">
		<h2><%= search %></h2>&nbsp;&nbsp;<h4>함께 할 사람들과 이야기 나눠보세요</h4>
		</div><br>
		<div class="row">
			<table>
				<thead>
					<tr>
						<th style="width: 15%;"><span>카테고리</span></th>
						<th style="width: 30%;"><span>제목</span></th>
						<th style="width: 10%;"><span>작성자</span></th>
						<th style="width: 25%;"><span>작성일</span></th>
						<th style="width: 10%;"><span>조회수</span></th>
						<th style="width: 10%;"><span>좋아요</span></th>
					</tr>
				</thead>
				<tbody>
					<% //customerPage의 객체 이름과 같아야한다.
						ArrayList<BoardVO> list = boardDAO.getSearch(search);
						if(search == ""){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('옵션을 선택해주세요')");
							script.println("history.back()");
							script.println("</script>");
						}
						for (int i = 0; i < list.size(); i++) {
						if (list.size() == 0) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('검색결과가 없습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					%>
				
					<tr class="board-row">
						<td><%= list.get(i).getBoardCategory() %></td>
						<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBoardDate().substring(0 ,11) + list.get(i).getBoardDate().substring(11, 13) + "시" + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
						<td><%=list.get(i).getViewCount()%></td>
						<td><%=list.get(i).getHeartCount()%></td>
					</tr>
					
					<%
						}
					%>
				</tbody>
			</table>
		</div>	
		<% 
			if( list.size() > 10 ){ //검색된 리스트의 갯수가 10개 이상일때만 더보기 버튼 보이기
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
		
		<% 
			if( userID != null ){
		%>
			<button type="button" class="btn-black" id="search" onclick="location.href='community.jsp'"><span>돌아가기</span></button>
			<button type="button" class="btn-black" id="write" onclick="location.href='write.jsp'"><span>글쓰기</span></button>
		<% 
			}
		%>
	</div>
</section>
<footer>
<hr>
<div class="inform">
		<ul>
     		<li>06223 서울특별시 강남구 역삼로1004길 (역삼동, 대박타워) ㈜TOGETHER 대표이사 : 정윤서 | 사업자 등록번호: 222-22-22222｜통신판매업신고: 강남 1004호</li>
     		<li>｜개인정보 보호책임자 : 정윤서 | 문의 : Webmaster@TOGETHER.co.kr | Copyright ⓒ TOGETHER. All rights reserved.</li>
     		<li>㈜투게더의 사전 서면동의 없이 사이트(PC, 모바일)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</liz>
   		</ul>
</div>
</footer>
<script>
$(document).ready(function(){
	$('.board-row').hide();
    $('.board-row').slice(0, 10).show(); // 초기갯수
    $("#more-btn").click(function(e){ // 클릭시 more
        if($('.board-row:hidden').length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막 글입니다."); // 컨텐츠 없을시 alert 창 띄우기 
        }
        e.preventDefault();
        $('.board-row:hidden').slice(0, 5).show('slow'); // 클릭시 more 갯수 지저정
	});
    
});

</script>
</body>
</html>