<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/pagenation.js"></script>
</head>
<style>
section{
padding-top: 100px;
height: 700px;
display: flex;
}
.board-container{
margin: 0 auto;
}
table{
width: 800px;
}
thead{
height: 30px;
}
.btn-black{
	float: right;
}
.btn-black span{
	padding: 5px;
	margin: 0;
	height: 35px;
}
.td{
	border-right-style: solid;
	border-right-width: 0.3mm;
	border-bottom: none;
	border-color: #;
}

.btn-black {
  position: relative;
  display: inline-block;
  width: 100px; height: 50px;
  background-color: transparent;
  border: none; 
  cursor: pointer;
  margin: 0;
 
}
.btn-black span {         
  position: relative;
  display: inline-block;
  font-size: 12pt;
  font-weight: bold;
  font-family: 'Nanum Gothic Coding', monospace;
  letter-spacing: 2px;
  width: 100%;
  padding: 10px;
  transition: 0.5s;
  
  color: #ffffff;
  background-color: #000000;
  border: 1px solid #000000;
}

.btn-black::before {
  background-color: #000000;
}

.btn-black span:hover {
  color: #000000;
  background-color: #ffffff
}

.paginate {margin-top: 7px;}
.paginate a.viewMore {display: block;cursor: pointer;text-align: center;padding: 12px;color: #3c63e0;}
.paginate a.viewMore span {font-size: 14px;}
.paginate a.viewMore span:after {display: inline-block;content:"";width: 11px;height:10px;margin: 0px 0 0 5px;vertical-align: middle;background:url(../images/common/common_sfix_icon.png) no-repeat -350px 0;}
.paginate a.viewMore.open span:after {display: inline-block;content:"";width: 11px;height:10px;margin: 0px 0 0 5px;vertical-align: middle;background:url(../images/common/common_sfix_icon.png) no-repeat -400px 0;}

.paginate.num {margin-top: 7px;text-align: center;}
.paginate.num > a {display:inline-block;vertical-align:middle;overflow:hidden;width: 37px;height: 36px;font-size:0;text-indent:-120%;color:transparent;background: url("../images/common/common_sfix_icon.png");border: 1px solid #c8c8c8;}
.paginate.num > a.first {background-position:-100px -350px;}
.paginate.num > a.prev {background-position: -236px -188px;margin-right: -4px;border-right: none;}
.paginate.num > a.next {background-position: -285px -188px;margin-left: -4px;border-left: none;}
.paginate.num > a.last {background-position:-250px -350px;}
.paginate.num > a.prev.inactive {background-position: -336px -188px;pointer-events: none;}
.paginate.num > a.next.inactive {background-position: -385px -188px;pointer-events: none;}

.paginate.num ol {display:inline-block;vertical-align:middle;}
.paginate.num ol:after {display:block;content:"";clear:both;}
.paginate.num ol li {float:left;margin-left: -1px;border-top: 1px solid #c8c8c8;border-bottom: 1px solid #c8c8c8;border-left: 1px solid #e7e7e7;border-right: 1px solid #e7e7e7;width: 37px;height: 36px;}
.paginate.num ol li:first-child {margin-left:0;}
.paginate.num ol li a {display:block;width: 100%;height: 100%;line-height: 33px;font-size: 15px;text-align: center;}
.paginate.num ol li a:hover {text-decoration: none;}
.paginate.num ol li.curpage {color: #ffffff;border: 1px solid #303030;background: #555555;}
.paginate.num ol li.curpage a {color: #ffffff;}
.paginate.num ol li.curpage + li {border-left: 1px solid #303030;}
.paginate.num ol li:hover {color: #ffffff;border: 1px solid #303030;background: #555555;}
.paginate.num ol li:hover + li {border-left: 1px solid #303030;}
.paginate.num ol li:hover a {color: #ffffff;}
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
		String category = request.getParameter("searchField2");
		%>
		<h4 style="font-weight: bold; color: #646464;"><%= category %></h4><br>
		
		<div class="row">
			<table style="text-align: center; border: 3px solid #ffffff; ">
				<thead>
					<tr>
						<th style="background-color: #464646; text-align: center; width: 10%;">카테고리</th>
						<th style="background-color: #464646; text-align: center; width: 30%;">제목</th>
						<th style="background-color: #464646; text-align: center; width: 10%;">작성자</th>
						<th style="background-color: #464646; text-align: center; width: 30%;">작성일</th>
						<th style="background-color: #464646; text-align: center; width: 10%;">조회수</th>
						<th style="background-color: #464646; text-align: center; width: 10%;">좋아요</th>
					</tr>
				</thead>
				<tbody>
					<% //customerPage의 객체 이름과 같아야한다.
						ArrayList<BoardVO> list = boardDAO.getSearch(request.getParameter("searchField"),
								request.getParameter("searchField2"));
						if (list.size() == 0) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('검색결과가 없습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="background-color: #ffffff"><%= list.get(i).getBoardCategory() %></td>
						<td><a href="
						view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
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
		<div>
		    <nav>
		        <ul class="paginate" id="paginate"></ul>
		    </nav>
		</div>
		<%
			if(pageNumber != 1) {
		%>
			<button type="button" id="prev" class="btn-black" onclick="location.href='searchPage.jsp?pageNumber=<%=pageNumber - 1%>'"><span>&lt;</span></button>
			
		<% 
			} if(boardDAO.nextPage(pageNumber + 1)){ 
		%>
			<button type="button" id="next" class="btn-black" onclick="location.href='searchPage.jsp?pageNumber=<%=pageNumber + 1%>'"><span>&gt;</span></button>
						
		<%
			}
		%>	
	
		<% 
			if( userID != null ){
		%>
			<button type="button" class="btn-black" id="search" onclick="location.href='community.jsp'"><span>검색</span></button>
			<button type="button" class="btn-black" id="write" onclick="location.href='write.jsp'"><span>글쓰기</span></button>
		<% 
			}
		%>
	</div>
</section>
</body>
</html>