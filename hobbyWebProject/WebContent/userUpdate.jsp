<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="group.GroupDAO" %>
<%@ page import="group.GroupDTO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="heart.HeartDAO" %>
<%@ page import="heart.HeartDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script type="text/javascript" src="js/script.js"></script>

</head>
<style>
section{
	height: 1000px;
}
.menu-bar{
width: auto;
height: auto;
top: 150px;
font-size: 15pt;
}
#menu1{
width: 200px;
  height: 50px;
left: -150px;
  top: 150px;
  background-color: #E0EBFF;
  transition: left 1s;
  position: fixed;
display: flex;
 justify-content: center;
 align-items: center;
 cursor: pointer;
}
#menu2{
	width: 200px;
  height: 50px;
left: -150px;
  top: 210px;
  background-color: #E0EBFF;
  transition: left 1s; 
  position: fixed;
  display: flex;
 justify-content: center;
  align-items: center;
  cursor: pointer;
 
}
#menu1:hover , #menu2:hover{
 left: 0;
  transition: left 1s;
}

#menu1 > ul , #menu2 > ul{
position: relative;
  float: right;
  list-style-type: none;
  display: flex;
align-items: center;
}

#menu1 > li , #menu2 > li{
width: auto;
height: auto;
margin: 0 auto;
float: right;
}
.i{
font-size: 20pt;
margin-left: 20px;
margin-top: 5px;

}
#more-btn{
cursor: pointer;
}
td{
table-layout: fixed;
height: 20px;
border-bottom: solid 1px #C0C0C0;
text-align: left;
}
#click-view:hover{
text-decoration: underline;
}
.btn-blue{
	width: 45px;
	height: 20px;
	font-size: 13pt;
	margin: 0;
	padding: 0;
	margin-right: 50px;
	margin-top: 12px; 
	float: left;
}
.btn-blue span{
	height: 15px;
	float: center;
	padding: 5px;
}
h3{
	width: 150px;
	float: left;
}
.userDataBoard{
	min-height: 45px;
	margin-bottom: 20px;
}
.view-head{
	height: 20px;
	border-bottom: solid 2px #C0C0C0;
}

table{
font-size: 10pt; 
color: black; 
width: 450px; 
text-align: left; 
}
tr{
	align-items: center;
}

#more-btn ,#more-btn-2, #more-btn-3, #more-btn-4{
	float: right;
	margin-right: 20px;
	font-size: 11pt;
	font-weight: bold;
}

/* select box */
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
}

.select.active .option-list {
  max-height: none;
  border: solid 3px #E0EBFF;
}
#select-sec {
	width: 300px;
	height: 45px;
	font-size: 11pt;
	font-weight: bold;
	color: #6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
	display: flex;
}
#select-sec .select {
border-style: solid;
	border-color: #E0EBFF;
	color: #6e6e6e;
  border-radius: 15px;
  padding: 10px;
  cursor: pointer;
}

#select-sec .select .text {
font-size: 12pt;
font-weight: bold;
color: #6e6e6e;
display: flex;
}
.option{
display: flex;
}
span{
margin: 0 auto;
}

#select-sec .select .option-list {
  list-style: none;
  padding: 0;
  border-radius: 15px;
}
#select-sec .select .option-list .option {
  padding: 15px;
}
#select-sec .select .option-list .option:hover {
border-radius: 15px;
background-color: #E0EBFF;
}
#dl-btn{
	border: 0;
	outline: 0;
	width: 50px;
	height: 45px;
	border-radius: 15px;
	border-color: #86A5FF;
	background-color: #E0EBFF;
	margin-left: 15px;
	cursor: pointer;
}
#dl{
	font-size: 12pt;
	font-weight: bold;
	color: 6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
}
.none-list{
	text-align: center; 
	padding: 10px; 
}
#delete-sec{
	height: 10%;
	bottom: 0;
	position: absolute;
}
</style>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
		script.println("</script>");
	}
	
	//int userAccess = Integer.parseInt(request.getParameter("userAccess"));
	 //하나의 그룹 정보 가져오기
	UserDTO user=new UserDAO().getUserVO(userID);
%>
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" class ="menu">COMMUNITY</a></li>
				<% 
					if(userID == null){
				%>
				<li><a id="go-group-1" class="menu">GROUP</a></li>
				<%
					} else { 
				%>
				<li><a id="go-group-2" class="menu" onclick="location.href='groupPage.jsp'">GROUP</a></li>
				<%
					}
				%>
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
	<!-- 사이드바 -->
	<div class="menu-bar">
		<div id="menu1">
		<ul>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;정보수정</li>
			<li class="i"><i class="fa-solid fa-angles-right"></i></li>
		</ul>
		</div>
		<div id="menu2">
		<ul>
			<li>데이터관리</li>
			<li class="i"><i class="fa-solid fa-angles-right"></i></li>
		</ul>
		</div>
	</div>
	
	<!-- 정보 수정하기 -->
	<div id="userInfo">
	 	<div>
	        <h2>정보 수정하기<h2>
	        <form method="post" action="userUpdateAction.jsp" id="user-update" onsubmit="return passwordCheck(this)">
			<input type="text" value=<%=user.getUserID()%> name="userID" id="userID" maxlength="20">
			<input type="text" value=<%=user.getUserName()%> name="userName" id="userName"maxlength="20">
			<input type="text" value=<%=user.getUserBirth()%> name="userBirth" id="userBirth" maxlength="20">
			<input type="text" value=<%=user.getUserPhone()%> name="userPhone" id="userPhone" maxlength="20">
			<input type="password" name="userPassword" id="userPassword" maxlength="20" placeholder="비밀번호 입력" onkeyup="passwordCheck2()">
	        <input type="password" name="userPassword1" id="userPassword1" placeholder="비밀번호 확인" onkeyup="passwordCheck2()">
	            <div id="check">
					<h5 id="passwordCheckMessage"></h5>
				</div>
	        <input type="submit" value="update">
	        </form>
	        <button type="button" id="user-delete" onclick="if(confirm('정말 탈퇴 하시겠습니까?')){location.href='userDeleteAction.jsp'}">회원 탈퇴하기</button>
	    </div>
	</div>
	
	<!-- 데이터 관리하기 -->
	<div id="userSet" hidden="">
		<div>
			<h2>데이터 관리하기</h2>
			<%
			BoardDAO boardDAO = new BoardDAO();
			ArrayList<BoardDTO> list = boardDAO.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 작성한 글 목록 -->
				<tr class="view-head">
					<td><h3>글 (<%= list.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view1"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="boardData">
					<table>
						<thead>
							<tr class="board-head">
								<th style="width: 20%;"><span>카테고리</span></th>
								<th style="width: 37%;"><span>제목</span></th>
								<th style="width: 23%;"><span>작성일</span></th>
								<th style="width: 10%;"><span>좋아요</span></th>
								<th style="width: 10%;"><span>댓글</span></th>
							</tr>
						</thead>
						<% if (list.size() == 0) { %>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">작성한 글이 없습니다.</td>
							</tr>
						</tbody>
						<% }else{ %>
						<tbody>
							<%
								for (int i = 0; i < list.size(); i++) {
								//댓글 갯수 가져오기
			                 	CommentDAO cmtDAO = new CommentDAO();
			                 	ArrayList<CommentDTO> cmtlist = cmtDAO.getList(list.get(i).getBoardID());//밑에 댓글리스트와는 다른 결과를 가져오는 메서드
								//list와 cmtlist혼동주의
							%>
							<tr class="showWrite" style="height: 20px;">
								<td><%=list.get(i).getBoardCategory()%></td>
								<td><a id="click-view" href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<td><%= list.get(i).getBoardDate().substring(0 ,11) + "<br>" + list.get(i).getBoardDate().substring(11, 13) + "시" + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
								<td><%=list.get(i).getHeartCount()%></td>
								<td><%= cmtlist.size() %></td>
							</tr>
							<%
								}
							%>
						</tbody>
						<%
							}
						%>
					</table><br>
					<% if (list.size() != 0) { %>
					<div id="more-btn">MORE</div>
					<%} %>
				</div>
			</div>
			
			<%
			CommentDAO cmtDAO = new CommentDAO();
			ArrayList<CommentDTO> cmtlist2 = cmtDAO.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 작성한 댓글 목록 -->
				<tr class="view-head">
					<td><h3>댓글 (<%= cmtlist2.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view2"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="cmtData">
					<table style="font-size: 10pt; color: black; width: 450px; text-align: left;">
						<thead>
							<tr class="board-head">
								<th style="width: 60%;"><span>댓글</span></th>
								<th style="width: 40%;"><span>작성일</span></th>
							</tr>
						</thead>
						<% if (cmtlist2.size() == 0) { %>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">작성한 댓글이 없습니다.</td>
							</tr>
						</tbody>
						<% }else{ %>
						<tbody>
							<%
								for (int i = 0; i < cmtlist2.size(); i++) {
							%>
							<tr class="showCmt" style="height: 20px;">
								<td><a id="click-view" href="view.jsp?boardID=<%= cmtlist2.get(i).getBoardID() %>"><%= cmtlist2.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<td><%= cmtlist2.get(i).getCmtDate().substring(0 ,11) + cmtlist2.get(i).getCmtDate().substring(11, 13) + "시" + cmtlist2.get(i).getCmtDate().substring(14, 16) + "분" %></td>
							</tr>
							<%
								}
							%>
						</tbody>
						<%
							}
						%>
					</table><br>
					<% if (cmtlist2.size() != 0) { %>
					<div id="more-btn-2">MORE</div>
					<%} %>
				</div>
			</div>
			
			<%
			GroupDAO groupDAO = new GroupDAO();
			ArrayList<GroupDTO> grouplist = groupDAO.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 만든 그룹 목록 -->
				<tr class="view-head">
					<td><h3>만든 그룹 (<%= grouplist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view3"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="groupData">
					<table style="font-size: 10pt; color: black; width: 450px; text-align: left;">
						<thead>
							<tr class="board-head">
								<th style="width: 50%;"><span>그룹</span></th>
								<th style="width: 20%;"><span>비밀번호</span></th>
								<th style="width: 15%;"><span>활동</span></th>
								<th style="width: 15%;"><span>인원</span></th>
							</tr>
						</thead>
						<% if (grouplist.size() == 0) { %>
						<tbody>
							<tr>
								<td colspan="4" class="none-list">생성한 그룹이 없습니다.</td>
							</tr>
						</tbody>
						<% }else{ %>
						<tbody>
							<%			
								for (int i = 0; i < grouplist.size(); i++) {										
							%>
							<tr class="showGroup" style="height: 20px;">
								<td><a id="click-view" href="groupView.jsp?groupID=<%= grouplist.get(i).getGroupID() %>"><%= grouplist.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<td><%= grouplist.get(i).getGroupPassword() %></td>
								<%if(grouplist.get(i).getGroupAvailable() == 0){ %>
								<td>NO</td>
								<%}else{ %>
								<td>YES</td>
								<%} %>
								<td><%= grouplist.get(i).getGroupNoP() %></td>
							</tr>
							<%	
								}
							%>
						</tbody>
					<% } %>
					</table><br>
					<% if (grouplist.size() != 0) { %>
					<div id="more-btn-3">MORE</div>
					<%} %>
				</div>
			</div>
			
			<%
			MemberDAO memberDAO = new MemberDAO();
			ArrayList<MemberDTO> mblist = memberDAO.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 가입한 그룹 목록 -->
				<tr class="view-head">
					<td><h3>가입한 그룹 (<%= mblist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view4"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="memberData">
					<table style="font-size: 10pt; color: black; width: 450px; text-align: left;">
						<thead>
							<tr class="board-head">
								<th style="width: 20%;"><span>이름</span></th>
								<th style="width: 50%;"><span>가입인사</span></th>
								<th style="width: 20%;"><span>가입일</span></th>
								<th style="width: 10%;"><span>활동</span></th>
							</tr>
						</thead>
						<% if (mblist.size() == 0) { %>
						<tbody>
							<tr>
								<td colspan="4" class="none-list">가입한 그룹이 없습니다.</td>
							</tr>
						</tbody>
						<% }else{ %>
						<tbody>
							<%								
								for (int i = 0; i < mblist.size(); i++) {										
							%>
							<tr class="showMember" style="height: 20px;">
								<td><a id="click-view" href="groupView.jsp?groupID=<%= mblist.get(i).getGroupID() %>"><%= mblist.get(i).getMemberID().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<td><%= mblist.get(i).getMbContent() %></td>
								<td><%= mblist.get(i).getMbDate().substring(0 ,11) + mblist.get(i).getMbDate().substring(11, 13) + "시" + mblist.get(i).getMbDate().substring(14, 16) + "분" %></td>
								<%
									//mblist의 groupID와 같은 groupID의 정보를 가져온 후 groupAvailable == 0 이면 해당 그룹이 비활동중임을 표시한다.
									GroupDTO group = new GroupDAO().getGroupVO(mblist.get(i).getGroupID());
									if(group.getGroupAvailable() == 0){
								%>
								<td>NO</td>
								<%
									}else{
								%>
								<td>YES</td>
								<%		
									}
								%>
							</tr>
							<%		
								}
							%>
						</tbody>
						<%		
							}
						%>
					</table><br>
					<% if (mblist.size() != 0) { %>
					<div id="more-btn-4">MORE</div>
					<%} %>
				</div>
			</div>
		</div>
		<div id="delete-sec">
		<!-- 데이터 관리에 정보 삭제를 위한 select box -->
		<div class="select-hobby">
		<form method="post" id ="deleteField" action="userSetDelete.jsp">
			<div id="select-sec">
				<div class="select">
					<div class="text">
						<input type="hidden" name="deleteField">
						<span>삭제할 데이터 선택</span>
						<span><i class="fa-solid fa-chevron-down"></i></span>
					</div>
				<ul class="option-list">
					<li class="option"><input type="hidden" id="boards" name="deleteField" value="board"><span>게시글</span></li>
					<li class="option"><input type="hidden" id="comments" name="deleteField" value="cmt"><span>댓글</span></li>
					<li class="option"><input type="hidden" id="groups" name="deleteField" value="group"><span>생성그룹</span></li>
					<li class="option"><input type="hidden" id="members" name="deleteField" value="mb"><span>가입그룹</span></li>
				</ul>
				</div>
				<div id="submit-btn">
					<button type="submit" id="dl-btn"><span id="dl">삭제</span></button>
				</div>
			</div>
		</form>
		</div>
	</div>
	</div>
</section>
<script>
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
</script>
<script>
$(document).ready(function(){
	//메뉴 클릭할때마다 보이고 숨기기
	$('#userInfo').show();

	$('#menu1').on('click', function(){
	    $('#userInfo').show();
		    $('#userSet').hide();
	  });
	$('#menu2').on('click', function(){
	  $('#userInfo').hide();
	   $('#userSet').show();
	});
	
	//원하는 데이터 목록 보기
	//게시글 목록은 무조건 보이기
	$('#boardData').show(); $('#cmtData').hide(); $('#groupData').hide(); $('#memberData').hide();
	
	//나머지는 리스트 결과가 없을때 텍스트를 표시하기 위해 show를 해준다.
	
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
});
</script>

</body>
</html>