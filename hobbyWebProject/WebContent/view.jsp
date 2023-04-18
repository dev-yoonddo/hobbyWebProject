<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentVO"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/board.css?after">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>

</head>
<Style>
section{
	height: auto;
	display: flex;
	margin: 0;
	padding: 0;
	padding-top: 100px;
	margin-bottom: 150px;
	font-family: 'Nanum Gothic', monospace;
	font-weight: 500;
}
.board-container{
	width: 1000px;
	margin: 0 auto;
}
.inquiry{
padding-bottom: 100px;
}
#view-table{
width: 1000px;
height: 500px;
border-collapse: collapse;
border: 1px solid #C0C0C0;
font-size: 12pt;
}

thead{

}
.td{
text-align: center;
font-size: 13pt;
}
.td span{
	
padding: 10px 20px;
border-radius: 20px;
background-color: #CCE5FF;
}
#view-title{
font-weight: bold;
font-size: 25pt;
color: #646464;
font-family: 'Noto Sans KR', sans-serif;
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

#tb-top{
	display: flex;
}
#tb-top-1{
	width: 50%;
	height: 40px;
	padding: 0;
	margin: 0;
	display: flex;
	float: left;
}
#tb-top-2{
	width: 50%;
	height: 40px;
	padding-bottom: 20px;
	margin: 0;
	float: right;
}
#user-item{
	margin: 0;
	padding: 10px;
	justify-content: center;	
}
#count-item{
	height: auto;
	margin: 0;
	border-radius: 20px;
	background-color: #E0E0E0;
	padding: 8px 50px;
	float: right;
}
#count-item span{
	color: #282557;
	font-size:17pt;
	width: 50px;
	height: 30px;
	margin-right: 10px; 
}

.btn-blue{
	position: relative;
	display: inline-block;
	width: 90px;
	height: 70px;
	background-color: transparent;
	border: none; 
	cursor: pointer;
	margin: 10px;
	float: right;
}

.btn-blue span {         
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

.btn-blue::before {
  background-color: #7D95E5;
}

.btn-blue span:hover {
  color: #7D95E5;
  background-color: #ffffff
}
#cmt-btn{
	width: 40px;
	height: 20px;
	padding: 0;
	margin: 0px 15px;
}
#cmt-btn span{
	font-size: 10pt;
	padding: 6px;
	color: #ffffff;
	  background-color: #323232;
	  border: 1px solid #323232;
}
#cmt-btn::before {
  background-color: #323232;
}

#cmt-btn span:hover {
  color: #323232;
  background-color: #ffffff
}
</style>
<body>
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
int cmtID = 0;
if(request.getParameter("cmtID")!=null)
	cmtID = Integer.parseInt(request.getParameter("cmtID"));
//boardID 가져오기
int boardID = 0;
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}

//글이 유효하다면 1이상의 숫자가 반환되기 때문에 boardID == 0일때  글이 유효하지 않다는 알림창 띄우기
if(boardID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href = 'customerPage.jsp'");
	script.println("</script>");
}

BoardVO board = new BoardDAO().getBoardVO(boardID);
CommentVO comment = new CommentDAO().getCommentVO(cmtID);
%>

<!-- header -->
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
<!-- header -->

<!-- section -->
<section>
	<div class="board-container">
		<div class="inquiry">
			<div class="row"><br>
				<a id="view-title"><%= board.getBoardCategory() %></a><br><br>
				
				<div id="tb-top">
				<div id="tb-top-1">
					<div id="user-item">
					<span>작성자 <%= board.getUserID() %></span>
					<span>&nbsp;&nbsp;|&nbsp;&nbsp; <%= board.getBoardDate().substring(0 ,11) + board.getBoardDate().substring(11, 13) + "시" + board.getBoardDate().substring(14, 16) + "분" %></span>
					</div>
				</div>
				
				<div id="tb-top-2">
					<div id="count-item">
					<span><i id="heart1" class="fa-regular fa-heart"></i><i id="heart2" class="fa-solid fa-heart"></i>&nbsp;<%= board.getHeartCount() %></span>&nbsp;&nbsp;
					<span><i class="fa-solid fa-eye"></i>&nbsp;<%= board.getViewCount()+1 %></span>
					</div>
				</div>
				</div>
				
				<table id="view-table">
					<tbody>
						<tr height="25%" style="border-bottom: 1px solid #C0C0C0;">
							<td class="td" style="width:20%;"><span>제목</span></td>
							<td><%= board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr height="75%" valign="top">
							<td class="td" style="padding-top: 50px;"><span>내용</span></td>
							<!-- 특수문자 처리 -->
							<td style="padding-top: 50px;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<!-- <tr>
							<td class="td"><span>조회수</span></td>
							<td colspan="2"><%= board.getViewCount()+1 %></td>
						</tr>
						<tr>
							<td class="td"><span>하트</span></td>
							<td colspan="2"><%= board.getHeartCount() %></td>
						</tr> -->
					</tbody>
				</table>
				
			</div><br>
			
			<button type="button" class="btn-blue" onclick="history.back()"><span>목록</span></button>
			<% 
				if(userID != null){
			%>
				<button type="button" class="btn-blue" id="cmt-write-btn" onclick="cmtAction()"><span>댓글쓰기</span></button>
			<%
				if(userID != null && userID.equals("admin")){
			%>
				<button type="button" class="btn-blue" id="cmt-write-btn" onclick="cmtAction()"><span>댓글쓰기</span></button>
			<%
				}
				}
			%>
			<%
				if(userID == (board.getUserID())){
			%>
				<button type="button" class="btn-blue" onclick="location.href='update.jsp?boardID=<%= boardID%>'"><span>수정</span></button>
				<button type="button" class="btn-blue" id="btn-del" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='deleteAction.jsp?boardID=<%= boardID%>'}"><span>삭제</span></button>
			<% 
				}
			%>
			</div>
			
			
			<div class="cmt-view" style="height: auto;">
	         	<div class="row" style="width: 600px; height: auto;">
	                 <%
	                   CommentDAO cmtDAO = new CommentDAO();
	                   ArrayList<CommentVO> list = cmtDAO.getList(boardID);
                  	 %>
	         		<h5 style="font-size: 15pt; color: #646464; float: left;">댓글 (<%= list.size() %>)<br></h5><hr style="width: 1000px;"><br>
                    <%
	                   for(int i=0; i<list.size(); i++){
	                %>
	                <div class="cmt-list" style="width: 600px; height: 110px;">
	                	<div style="display: flex;">
		               	<div class="cmt-icon" style="justify-content: center; padding: 10px;">
		               	<i style="font-size: 30pt;"class="fa-regular fa-face-smile"></i>
		               	</div>
		               	<table class="cmt-table" style="width: 600px;">
		               		<tr style="height: 30px; table-layout:fixed; ">
		               			<td align="left" style="width:30%;"><%= list.get(i).getUserID() %></td>
		               			<td align="right" style="width:70%;"><%= list.get(i).getCmtDate().substring(0,11)+list.get(i).getCmtDate().substring(11,13)+"시"+list.get(i).getCmtDate().substring(14,16)+"분" %></td>
		               		</tr>
		               		<tr style="height: auto; font-weight: 550;">
		               			<td colspan="2"><%= list.get(i).getCmtContent() %></td>
		               		</tr>		               		
			           	</table>
			           	</div>
            			<%
            				if(userID != null && userID.equals(list.get(i).getUserID()) || userID == ("admin")){
            			%>
            			<button type="button" class="btn-blue" id="cmt-btn" onclick="if(confirm('답글을 삭제하시겠습니까?')){location.href='commentDeleteAction.jsp?boardID=<%= boardID%>&cmtID=<%=list.get(i).getCmtID() %>'}"><span>삭제</span></button>
            			<%
            				}
            			%>
		           		</div>
	                  <%
	                     }
	                  %>
	         	</div>  
	      	</div>
	      	<!-- 답변쓰기 버튼을 눌렀을 때만 답변쓰기 섹션이 나타나도록 설정 -->
			<div id="cmt-write" style="display: none; padding-top: 70px; width: 600px;"> 
		      <div class="cmt-row">
		          <form method="post" action="commentAction.jsp?boardID=<%= boardID %>">
			          <table class="cmt-table" style="height: 100px; border-style: none;">
			             <tbody>
			                <tr>
			                   <td><input type="text" placeholder="댓글을 입력하세요" name="cmtContent" maxlength="60" style="width: 600px; height: 150px; font-size: 12pt;"></td>
			                </tr>
			             </tbody>
			          </table>
			      <button type="submit" class="btn-blue" id="cmt-cpl"><span>완료</span></button>
			      </form>
		      </div>
		   </div>
			
   </div>
</section>
<!-- section -->

<!-- footer -->
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
<!-- footer -->
<script>
$(document).ready(function(){
	$("#heart2").hide();
	
    $("#heart1").click(function(){ // 클릭시 more
    	$("#heart1").hide();
    	$("#heart2").show();
    	if($("#heart2").click(function(){
    		$("#heart2").hide();
    		$("#heart1").show();
    	}));
	});
    
});
function cmtAction(){
	document.getElementById('cmt-write').style.display = 'block';
	document.getElementById('cmt-write-btn').style.display = 'none';

}
</script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
</body>
</html>