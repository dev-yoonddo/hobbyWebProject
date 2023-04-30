<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script type="text/javascript" src="js/script.js"></script>

</head>
<style>
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
 margin: 0 auto;
align-items: center;
}

#menu1 > li , #menu2 > li{
width: auto;
height: auto;
margin: 0 auto;
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
.userData{

}
.btn-blue{
	width: 45px;
	height: 25px;
	font-size: 13pt;
	margin: 0;
	padding: 0;
}
.btn-blue span{
	height: 15px;
	float: center;
}
h3{
	width: 60%;
	margin: 0;
	float: left;
}
.userDataBoard{
	min-height: 40px;
	margin-bottom: 30px;
	padding-top: 30px;
}
.view-head{
	height: 30px;
	align-items: center;
}
.view-btn{
	width: 40%;
	height: 30px;
	float: center;
	top: 0;
}
td{
	max-height: 30px;
}
ul{
list-style: none;
height: 30px;
text-decoration: none;
display: flex;
}
</style>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
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
	<div class="menu-bar">
		<div id="menu1">
		<ul>
			<li>정보 수정하기</li>
			<li class="i"><i class="fa-solid fa-angles-right"></i></li>
		</ul>
		</div>
		<div id="menu2">
		<ul>
			<li>데이터 관리하기</li>
			<li class="i"><i class="fa-solid fa-angles-right"></i></li>
		</ul>
		</div>
	</div>
	
<div id="userInfo">
 	<div>
        <h2>정보 수정하기<h2>
        <form method="post" action="userUpdateAction.jsp" id="user-update" onsubmit="return passwordCheck(this)">
		<input type="text" value=<%=user.getUserID()%> name="userID" id="userID" maxlength="20">
		<input type="text" value=<%=user.getUserName()%> name="userName" id="userName"maxlength="20">
		<input type="text" value=<%=user.getUserBirth()%> name="userBirth" id="userBirth" maxlength="20">
		<input type="text" value=<%=user.getUserPhone()%> name="userPhone" id="userPhone" maxlength="20">
		<input type="password" value=<%=user.getUserPassword()%> name="userPassword" id="userPassword" maxlength="20" onkeyup="passwordCheck2()">
        <input type="password" name="userPassword1" id="userPassword1" placeholder="비밀번호 확인" onkeyup="passwordCheck2()">
            <div id="check">
				<h5 id="passwordCheckMessage"></h5>
			</div>
        <input type="submit" value="update">
        </form>
        <button type="button" id="user-delete" onclick="if(confirm('정말 탈퇴 하시겠습니까?')){location.href='userDeleteAction.jsp'}">회원 탈퇴하기</button>
    </div>
</div>
<div id="userSet">
	<div style="width: 500px; height: 800px;">
		<h2>데이터 관리하기</h2>
		<%
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<BoardDTO> list = boardDAO.getListByUser(userID);
		%>
		<div class="userDataBoard">
			<tr class="view-head">
				<td><h3>글 (<%= list.size() %>)개</h3></td>
				<td><button type="button" class="btn-blue" id="view1" style="float: left;"><span>보기</span></button></td>	
			</tr>
		<div class="userData" id="boardData">
			<table style="font-size: 10pt; color: black; width: 450px; text-align: left;">
				<thead>
					<tr class="board-head">
						<th style="width: 20%;"><span>카테고리</span></th>
						<th style="width: 37%;"><span>제목</span></th>
						<th style="width: 23%;"><span>작성일</span></th>
						<th style="width: 10%;"><span>좋아요</span></th>
						<th style="width: 10%;"><span>댓글</span></th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
						//댓글 갯수 가져오기
	                 	CommentDAO cmtDAO = new CommentDAO();
	                 	ArrayList<CommentDTO> cmtlist = cmtDAO.getList(list.get(i).getBoardID());//밑에 댓글리스트와는 다른 결과를 가져오는 메서드
	                 	
						if (list.size() == 0) {
					%>
						<tr>
						<td>작성한 글이 없습니다.</td>
						</tr>
					<%
						}
						if(list.get(i).getBoardAvailable()==1){ //삭제하지 않은 글 (DAO에서 미리 해도 되지만 삭제한 글이 필요할 수 있어서 여기서 조건을 건다.)
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
						}
						
					%>
				</tbody>
			</table>
		<div id="more-btn">MORE</div>
		</div>
		</div>
		
		<%
		CommentDAO cmtDAO = new CommentDAO();
		ArrayList<CommentDTO> cmtlist = cmtDAO.getListByUser(userID);
		%>
		<div class="userDataBoard">
		<h4>댓글 (<%= cmtlist.size() %>)개</h4>
		<div class="userData" id="cmtData">
			<table style="font-size: 10pt; color: black; width: 450px; text-align: left;">
				<thead>
					<tr class="board-head">
						<th style="width: 60%;"><span>댓글</span></th>
						<th style="width: 40%;"><span>작성일</span></th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < cmtlist.size(); i++) {

						if (cmtlist.size() == 0) {
					%>
						<tr>
						<td>작성한 댓글이 없습니다.</td>
						</tr>
					<%
						}
					%>
					<tr class="showCmt" style="height: 20px;">
						<td><a id="click-view" href="view.jsp?boardID=<%= cmtlist.get(i).getBoardID() %>"><%= cmtlist.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%= cmtlist.get(i).getCmtDate().substring(0 ,11) + list.get(i).getBoardDate().substring(11, 13) + "시" + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						
						}
						
					%>
				</tbody>
			</table>
		<div id="more-btn-2">MORE</div>
		</div>
			<div class="view-btn">
				<button type="button" class="btn-blue" id="view2"><span>보기</span></button>	
			</div>
		</div>
		
		<%
		GroupDAO groupDAO = new GroupDAO();
		ArrayList<GroupDTO> grouplist = groupDAO.getListByUser(userID);
		%>
		<div class="userDataBoard">
		<h4>만든 그룹 (<%= grouplist.size() %>)개</h4>
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
				<tbody>
					<%
						
						for (int i = 0; i < grouplist.size(); i++) {
						if (grouplist.size() == 0) {
								
					%>
						<tr>
						<td>생성한 그룹이 없습니다.</td>
						</tr>
					<%
							}
					%>
					<tr class="showGroup" style="height: 20px;">
						<td><a id="click-view" href="groupView.jsp?groupID=<%= grouplist.get(i).getGroupID() %>"><%= grouplist.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%= grouplist.get(i).getGroupPassword() %></td>
						<td><%= grouplist.get(i).getGroupAvailable() %></td>
						<td><%= grouplist.get(i).getGroupNoP() %></td>
					</tr>
					<%
							
						}
						
					%>
				</tbody>
			</table>
		<div id="more-btn-3">MORE</div>
		</div>
			<div class="view-btn">
				<button type="button" class="btn-blue" id="view3"><span>보기</span></button>	
			</div>
		</div>
		
		<%
		MemberDAO memberDAO = new MemberDAO();
		ArrayList<MemberDTO> mblist = memberDAO.getListByUser(userID);
		%>
		<div class="userDataBoard">
		<h4>가입한 그룹 (<%= mblist.size() %>)개</h4>
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
				<tbody>
					<%
						
						for (int i = 0; i < mblist.size(); i++) {
						if (mblist.size() == 0) {
								
					%>
						<tr>
						<td>가입한 그룹이 없습니다.</td>
						</tr>
					<%
						}
					%>
					<tr class="showMember" style="height: 20px;">
						<td><a id="click-view" href="groupView.jsp?groupID=<%= mblist.get(i).getGroupID() %>"><%= mblist.get(i).getMemberID().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%= mblist.get(i).getMbContent() %></td>
						<td><%= mblist.get(i).getMbDate().substring(0 ,11) + list.get(i).getBoardDate().substring(11, 13) + "시" + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
						<td><%= mblist.get(i).getMbAvailable() %></td>
					</tr>
					<%
							
						}
					%>
				</tbody>
			</table>
		<div id="more-btn-4">MORE</div>
		</div>
			<div class="view-btn">
				<button type="button" class="btn-blue" id="view4"><span>보기</span></button>	
			</div>
		</div>
		
	</div>
</div>
</section>
<script>
$(document).ready(function(){
	//메뉴 클릭할때마다 보이고 숨기기
	$('#userInfo').show();
	$('#userSet').hide();

	$('#menu1').on('click', function(){
	    $('#userInfo').show();
		    $('#userSet').hide();
	  });
	$('#menu2').on('click', function(){
	  $('#userInfo').hide();
	   $('#userSet').show();
	});
	
	//원하는 항목 보기
	$('#boardData').hide(); $('#cmtData').hide(); $('#groupData').hide(); $('#memberData').hide();
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
    var hiddenRows = $('.showWrite:hidden'); //숨겨져있는 글의 갯수
	$('.showWrite').slice(viewCount).hide(); // 처음 viewCount개의 글을 제외하고 모두 숨기기

	$("#more-btn").click(function(e){ //more-btn을 클릭했을때
	    e.preventDefault();
	    if($('.showWrite').length <= lastIndex){ //만약 전체 글의 갯수보다 lastIndex가 크거나 같다면
	        alert("마지막 글입니다"); //알림창 띄우기
	        return; //return을 하지않으면 알림창을 띄우고 또 다음으로 실행된다.
	    }
	    $('.showWrite').slice(lastIndex + 1, lastIndex + 1 + viewCount).show('slow'); // 처음 출력한 글의 다음 글들을 보여준다.
	    $('.showWrite').slice(0, lastIndex + 1).hide(); // 0부터 이전의 글들을 모두 숨긴다.
	    lastIndex += viewCount; // 다음 글 출력을 위해 lastIndex에 viewCount를 더해준다
	});
	 
	//내가 작성한 댓글 더보기 viewCount lastIndex는 이미 위에서 선언함
    var viewCount2 = 5;
	var lastIndex2 = viewCount2 - 1;
	var hiddenRows2 = $('.showCmt:hidden');
	$('.showCmt').slice(viewCount2).hide(); 

	$("#more-btn-2").click(function(e){ 
	    e.preventDefault();
	    if($('.showCmt').length <= lastIndex2){ 
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
    var hiddenRows3 = $('.showGroup:hidden');
	$('.showGroup').slice(viewCount3).hide();

	$("#more-btn-3").click(function(e){ 
	    e.preventDefault();
	    if($('.showGroup').length <= lastIndex3){ 
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
    var hiddenRows4 = $('.showMember:hidden'); 
	$('.showMember').slice(viewCount4).hide();

	$("#more-btn-4").click(function(e){ 
	    e.preventDefault();
	    if($('.showMember').length <= lastIndex4){ 
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