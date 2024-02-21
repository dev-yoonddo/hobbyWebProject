<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@page import="message.MessageDTO"%>
<%@page import="message.MessageDAO"%>
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
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/member.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/userdata.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</head>
<style>
header{
	top: 0;
}
section{
	top: 0;
	height: auto;
	margin-bottom: 200px;
}
.menu-bar{
	width: auto;
	height: auto;
	top: 150px;
	font-size: 15pt;
}
.sidemenu{
	width: 200px;
  	height: 50px;
	left: -150px;
	background-color: #E0EBFF;
	transition: left 1s;
	position: fixed;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	z-index: 500;
}
#menu1{
	top: 150px;
}
#menu2{
  	top: 210px;
}
#menu3{
  	top: 270px;
}
#menu1:hover , #menu2:hover, #menu3:hover{
 	left: 0;
  	transition: left 1s;
}

#menu1 > ul , #menu2 > ul, #menu3 > ul{
	position: relative;
  	float: right;
  	list-style-type: none;
  	display: flex;
	align-items: center;
}

#menu1 > li , #menu2 > li, #menu3 > li{
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
#click-view{
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
	max-width:100px;
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
.data-tb{
	font-size: 10pt; 
	color: black; 
	width: 450px; 
	text-align: left;
}
#more-btn ,#more-btn-2, #more-btn-3, #more-btn-4, #more-btn-5, #more-btn-6{
	float: right;
	margin-right: 20px;
	font-size: 11pt;
	font-weight: bold;
}

/* select box */
.select , .select1{
	position: relative;
	width: 500px;
}
.select .option-list , .select1 .option-list1{
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	overflow: hidden;
	max-height: 0;
	background-color: white;
}

.select.active .option-list , .select1.active .option-list1{
	max-height: none;
	border: solid 3px #E0EBFF;
}
#select-sec , #select-sec1{
	width: 300px;
	height: 45px;
	font-size: 11pt;
	font-weight: bold;
	color: #6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
	display: flex;
}
#select-sec .select , #select-sec1 .select1{
	border-style: solid;
	border-color: #E0EBFF;
	color: #6e6e6e;
	border-radius: 15px;
	padding: 10px;
	cursor: pointer;
}

#select-sec .select .text , #select-sec1 .select1 .text1{
	font-size: 12pt;
	font-weight: bold;
	color: #6e6e6e;
	display: flex;
}
.option , .option1{
	display: flex;
}
span{
	margin: 0 auto;
}

#select-sec .select .option-list , #select-sec1 .select1 .option-list1 {
  	list-style: none;
 	 padding: 0;
  	border-radius: 15px;
}
#select-sec .select .option-list .option , #select-sec1 .select1 .option-list1 .option1{
  	padding: 15px;
}
#select-sec .select .option-list .option:hover , #select-sec1 .select1 .option-list1 .option1:hover{
	border-radius: 15px;
	background-color: #E0EBFF;
}
#dl-btn, #dl-btn2{
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
#delete-sec , #delete-sec1{
	height: 10%;
	bottom: 0;
	position: absolute;
}

#event{
	width: 70px;
	height: 70px;
	float: right;
	position: fixed;
	right: 50px;
	z-index: 500;
	text-align: center;
	font-weight: bold;
	display: flex;
	padding: 5px;
	margin: 0 auto;
	align-items: center;
	justify-content: center;
	border-radius: 100%;
	background-color: #4646CD;
	color: white;
}

/*화면 축소 시*/
@media screen and (max-width:650px) {
	#userInfo{
		width: 400px;
		padding: 20px;
	}
	#userSet{
		width: 400px;
		padding: 20px;
	
	}
	#userMsg{
		width: 400px;
		padding: 20px;
	}
	table , .data-tb{
		width: 350px;
	}
	.sidemenu{
		height: 35px;
	}
	#menu1{
		top: 80px;
	}
	#menu2{
	  	top: 120px;
	}
	#menu3{
		top: 160px;
	}
 
}
</style>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
		script.println("</script>");
	}
	UserDAO user = UserDAO.getInstance();
	BoardDAO board = BoardDAO.getInstance();
	CommentDAO cmt = CommentDAO.getInstance();
	MessageDAO msg = MessageDAO.getInstance();
	GroupDAO group = GroupDAO.getInstance();
	MemberDAO member = MemberDAO.getInstance();
	
	ArrayList<UserDTO>mailList = user.getEmailList(); //모든 유저 이메일 리스트 가져오기
	 //하나의 유저 정보 가져오기
	UserDTO vo = user.getUserVO(userID);
	if(vo.isUserEmailChecked() == false){
		script.println("<script>");
		script.println("alert('이메일 인증이 필요합니다.')");
		script.println("location.href='emailSendAction'");
		script.println("</script>");
	}
%>

<header>
<div id="header" class="de-active"> <!-- userUpdate페이지는 header의 구성이 다르기 때문에 따로 작성한다. -->
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community" class ="menu">COMMUNITY</a></li>
				<% 
					if(userID == null){
				%>
				<li><a id="go-group-1" class="menu">GROUP</a></li>
				<li><a id="go-spot-1" class ="menu">SPOT</a></li>
				<%
					} else { 
				%>
				<li><a id="go-group-2" class="menu" onclick="location.href='groupPage'">GROUP</a></li>
				<li><a id="go-spot-2" class ="menu" onclick="location.href='spot'">SPOT</a></li>
				<%
					}
				%>
			</ul>
		</nav>
			<ul class="navbar_login" >
				<%
					if(userID == null){
				%>	
				<li><a href="login">LOGIN</a></li>
				<li><a href="join">JOIN</a></li>
				<%
					}else{
				%>				
				<li><a onclick="qna()" style="font-size: 15pt; cursor: pointer;"><i class="fa-solid fa-circle-question" style=""></i></a></li>
				<li><a href="logout">LOGOUT</a></li>
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
		<div id="menu1" class="sidemenu">
			<ul>
				<li>&nbsp;&nbsp;&nbsp;&nbsp;정보수정</li>
				<li class="i"><i class="fa-solid fa-angles-right"></i></li>
			</ul>
		</div>
		<div id="menu2" class="sidemenu">
			<ul>
				<li>데이터관리</li>
				<li class="i"><i class="fa-solid fa-angles-right"></i></li>
			</ul>
		</div>
		<div id="menu3" class="sidemenu">
			<ul>
				<li>메시지관리</li>
				<li class="i"><i class="fa-solid fa-angles-right"></i></li>
			</ul>
		</div>
	</div>
	<!-- 정보 수정하기 -->
	<div id="userInfo">
	 	<div>
	        <h2>정보 수정하기</h2>
	        <form method="post" action="userUpdateAction.jsp" id="user-update" onsubmit="return userDataCheck(this)">
			<input type="text" value=<%=vo.getUserID()%> name="userID" id="userID" maxlength="20" disabled="disabled">
			<input type="text" value=<%=vo.getUserName()%> name="userName" id="userName"maxlength="20">
			<input type="text" value=<%=vo.getUserEmail()%> name="userEmail" id="userEmail"maxlength="20" onkeyup="emailCheck('<%=mailList%>')">
			<input type="text" value=<%=vo.getUserBirth()%> name="userBirth" id="userBirth" maxlength="20" >
			<input type="text" value=<%=vo.getUserPhone()%> name="userPhone" id="userPhone" maxlength="20">
			<input type="password" name="userPassword" id="userPassword" maxlength="20" placeholder="비밀번호 입력" onkeyup="passwordCheck2()">
	        <input type="password" name="userPassword1" id="userPassword1" placeholder="비밀번호 확인" onkeyup="passwordCheck2()">
	            <div id="check">
					<h5 id="checkMessage"></h5>
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
				BoardDAO boardDAO = BoardDAO.getInstance();
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
								<th style="width: 35%;"><span>제목</span></th>
								<th style="width: 23%;"><span>작성일</span></th>
								<th style="width: 12%;"><span>좋아요</span></th>
								<th style="width: 10%;"><span>댓글</span></th>
							</tr>
						</thead>
						<!-- 작성한 글이 0개이면 -->
						<%
							if (list.size() == 0) {
						%>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">작성한 글이 없습니다.</td>
							</tr>
						</tbody>
						
						<!-- 작성한 글이 1개 이상이면 -->
						<% 
							}else{ 
						%>
						<tbody>
							<%
								for (int i = 0; i < list.size(); i++) {
								//댓글 갯수 가져오기
			                 	ArrayList<CommentDTO> cmtlist = cmt.getList(list.get(i).getBoardID());//밑에 댓글리스트와는 다른 결과를 가져오는 메서드
								//list와 cmtlist 혼동 주의
							%>
							<tr class="showWrite" style="height: 20px;">
								<td><%=list.get(i).getBoardCategory()%></td>
								<td><a id="click-view" href="view?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
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
					<!-- 글 갯수가 1 이상이면 MORE 버튼 보이기 -->
					<% 
						if (list.size() != 0) { 
					%>
					<div id="more-btn">MORE</div>
					<%
						}
					%>
				</div>
			</div>
			
			<%
				ArrayList<CommentDTO> cmtlist2 = cmt.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 작성한 댓글 목록 -->
				<tr class="view-head">
					<td><h3>댓글 (<%= cmtlist2.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view2"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="cmtData">
					<table class="data-tb">
						<thead>
							<tr class="board-head">
								<th style="width: 60%;"><span>댓글</span></th>
								<th style="width: 40%;"><span>작성일</span></th>
							</tr>
						</thead>
						<!-- 작성한 댓글이 0개이면 -->
						<% 
							if (cmtlist2.size() == 0) { 
						%>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">작성한 댓글이 없습니다.</td>
							</tr>
						</tbody>
						
						<!-- 작성한 댓글이 1개 이상이면 -->
						<% 
							}else{ 
						%>
						<tbody>
							<%
								for (int i = 0; i < cmtlist2.size(); i++) {
							%>
							<tr class="showCmt" style="height: 20px;">
								<td><a id="click-view" href="view?boardID=<%= cmtlist2.get(i).getBoardID() %>"><%= cmtlist2.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
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
					<%
						if (cmtlist2.size() != 0) { 
					%>
						<div id="more-btn-2">MORE</div>
					<%
						} 
					%>
				</div>
			</div>
			
			<%
				ArrayList<GroupDTO> grouplist = group.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 만든 그룹 목록 -->
				<tr class="view-head">
					<td><h3>만든 그룹 (<%= grouplist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view3"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="groupData">
					<table class="data-tb">
						<thead>
							<tr class="board-head">
								<th style="width: 50%;"><span>그룹</span></th>
								<th style="width: 20%;"><span>비밀번호</span></th>
								<th style="width: 15%;"><span>활동</span></th>
								<th style="width: 15%;"><span>인원</span></th>
							</tr>
						</thead>
						
						<!-- 생성한 그룹이 0개이면 -->
						<% 
							if (grouplist.size() == 0) { 
						%>
						<tbody>
							<tr>
								<td colspan="4" class="none-list">생성한 그룹이 없습니다.</td>
							</tr>
						</tbody>						
						<!-- 생성한 그룹이 1개 이상이면 -->
						<% 
							}else{ 
						%>
						<tbody>
							<%			
								for (int i = 0; i < grouplist.size(); i++) {										
							%>
							<tr class="showGroup" style="height: 20px;">
								<td><a id="click-view" href="groupView?groupID=<%= grouplist.get(i).getGroupID() %>"><%= grouplist.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<td><%= grouplist.get(i).getGroupPassword() %></td>
								<!-- 그룹이 비활동중이면 -->
								<%
									if(grouplist.get(i).getGroupAvailable() == 0){ 
								%>
									<td>NO</td>
								<!-- 그룹이 활동중이면 -->
								<%
									}else{ 
								%>
									<td>YES</td>
								<%	} %>
								<td><%= grouplist.get(i).getGroupNoP() %></td>
							</tr>
							<%	
								}
							%>
						</tbody>
					<% 	
						}
					%>
					</table><br>
					<% 
						if (grouplist.size() != 0) { 
					%>
						<div id="more-btn-3">MORE</div>
					<%	} %>
				</div>
			</div>
			
			<%
				ArrayList<MemberDTO> mblist = member.getListByUser(userID);
			%>
			<div class="userDataBoard">
			<!-- 내가 가입한 그룹 목록 -->
				<tr class="view-head">
					<td><h3>가입한 그룹 (<%= mblist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view4"><span>보기</span></button></td>	
				</tr>
				<div class="userData" id="memberData">
					<table class="data-tb">
						<thead>
							<tr class="board-head">
								<th style="width: 35%;"><span>그룹</span></th>
								<th style="width: 20%;"><span>아이디</span></th>
								<th style="width: 35%;"><span>가입일</span></th>
								<th style="width: 10%;"><span>활동</span></th>
							</tr>
						</thead>
						<!-- 가입한 그룹이 0개이면 -->
						<% 
							if (mblist.size() == 0) { 
						%>
						<tbody>
							<tr>
								<td colspan="4" class="none-list">가입한 그룹이 없습니다.</td>
							</tr>
						</tbody>
						<!-- 가입한 그룹이 1개 이상이면 -->
						<% 
							}else{ 
						%>
						<tbody>
							<%								
								for (int i = 0; i < mblist.size(); i++) {
									//비밀번호 검사를 위해 필요한 정보 가져오기 (그룹번호,그룹비밀번호,그룹활동여부)
									int groupID = mblist.get(i).getGroupID();
									String groupPW = group.getGroupVO(groupID).getGroupPassword();
									int groupAvl = group.getGroupVO(groupID).getGroupAvailable();
									//가입한 그룹이름 가져오기
									String groupName = group.getGroupVO(groupID).getGroupName();
							%>
							<tr class="showMember" style="height: 20px;">
								<td><a id="click-view" onclick="showPasswordPrompt('<%=groupID%>', '<%=groupPW%>','<%=groupAvl%>')"><%= groupName%></a></td>
								<td><%= mblist.get(i).getMemberID()%></td>
								<td><%= mblist.get(i).getMbDate().substring(0 ,11) + mblist.get(i).getMbDate().substring(11, 13) + "시" + mblist.get(i).getMbDate().substring(14, 16) + "분" %></td>
								<%
									//mblist의 groupID와 같은 groupID의 정보를 가져온 후 groupAvailable == 0 이면 해당 그룹이 비활동중임을 표시한다.
									GroupDTO groupVO = group.getGroupVO(mblist.get(i).getGroupID());
									if(groupVO.getGroupAvailable() == 0){
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
					<% 
						if (mblist.size() != 0) { 
					%>
					<div id="more-btn-4">MORE</div>
					<%	} %>
				</div>
			</div>
		</div>
		<!-- 데이터 리스트 출력 끝 -->
		
		<!-- 원하는 데이터 삭제하기  -->
		<div id="delete-sec">
			<div class="select-hobby">
			<form method="post" id ="deleteField" action="userSetDeleteAction.jsp">
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
	<!-- 데이터 관리하기 끝 -->
		
	<!-- 메시지 관리하기 -->
	<%
		//받은 메시지 리스트
		ArrayList<MessageDTO> msglist = msg.getMessageList(userID);
	%>
	<div id="userMsg" hidden="">
		<div>
			<div style="display: flex;">
				<h2>메시지 관리하기</h2>&nbsp;&nbsp;<h4 style="color: #C0C0C0; padding-top: 10px;">30일간 보관됩니다</h4>
			</div>
			<!-- 받은 메시지 목록 -->
			<div class="userDataBoard">
				<tr class="view-head">
					<td><h3>받은 메시지 (<%= msglist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view5"><span>보기</span></button></td>
				</tr>
				<div class="userData" id="msgData">
					<table>
						<thead>
							<tr class="board-head">
								<th style="width: 23%;"><span>그룹</span></th>
								<th style="width: 16%;"><span>보낸 사람</span></th>
								<th style="width: 29%;"><span>제목</span></th>
								<th style="width: 10%;"><span>확인</span></th>
								<th style="width: 20%;"><span>날짜</span></th>
							</tr>
						</thead>
						<!-- 받은 메시지가 0개이면 -->
						<% 
							if (msglist.size() == 0) {
						%>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">받은 메시지가 없습니다.</td>
							</tr>
						</tbody>
						<!-- 받은 메시지가 1개 이상이면 -->
						<% 
							}else{
						%>
						<tbody>
							<%	String groupName = null;
								for (int i = 0; i < msglist.size(); i++) {
									// MsgVO()에서 groupID를 구한 뒤 각 메시지를 보낸 그룹이름을 구한다.
									int groupID = msg.getMsgVO(msglist.get(i).getMsgID()).getGroupID();
									//groupID = 0이면 문의하기, 0 이상이면 메시지 보내기
									if(groupID > 0){
										groupName = group.getGroupVO(groupID).getGroupName();
									}else{
										groupName = "문의하기";
									}
							%>
							<tr class="showRcvMsg" style="height: 20px;">
								<td><%=groupName%></td>
								<td><%=msglist.get(i).getUserID()%></td>
								<td><a id="click-view" onclick="viewMsg('<%= msglist.get(i).getMsgID()%>')"><%= msglist.get(i).getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<!-- msgCheck == 0이면 안읽음, 1이면 읽음 표시하기 -->
								<% 
									if(msglist.get(i).getMsgCheck() == 0){
								%>
								<td>NO</td>						
								<% 
									}else{
								%>
								<td>YES</td>						
								<% 
									}
								%>
								<td><%=msglist.get(i).getMsgDate().substring(0 ,11) + msglist.get(i).getMsgDate().substring(11, 13) + "시" + msglist.get(i).getMsgDate().substring(14, 16) + "분"%></td>
							</tr>
							<%
								}
							%>
						</tbody>
						<%
							}
						%>
					</table><br>
					<!-- 메시지 갯수가 1 이상이면 MORE 버튼 보이기 -->
					<%
						if (msglist.size() != 0) {
					%>
					<div id="more-btn-5">MORE</div>
					<%	} %>
				</div>
			</div>
			<%
			//보낸 메시지 리스트
			ArrayList<MessageDTO> sendmsglist = msg.getSendMessageList(userID);
			%>
			<!-- 보낸 메시지 목록 -->
			<div class="userDataBoard">
				<tr class="view-head">
					<td><h3>보낸 메시지 (<%= sendmsglist.size() %>)개</h3></td>
					<td><button type="button" class="btn-blue" id="view6"><span>보기</span></button></td>
				</tr>
				<div class="userData" id="sendMsgData">
					<table>
						<thead>
							<tr class="board-head">
								<th style="width: 23%;"><span>그룹</span></th>
								<th style="width: 16%;"><span>받은 사람</span></th>
								<th style="width: 29%;"><span>제목</span></th>
								<th style="width: 10%;"><span>확인</span></th>
								<th style="width: 20%;"><span>날짜</span></th>
							</tr>
						</thead>
						<!-- 보낸 메시지가 0개이면 -->
						<% 
							if (sendmsglist.size() == 0) {
						%>
						<tbody>
							<tr>
								<td colspan="5" class="none-list">보낸 메시지가 없습니다.</td>
							</tr>
						</tbody>
						
						<!-- 보낸 메시지가 1개 이상이면 -->
						<% 
							}else{
						%>
						<tbody>
							<%
								String groupName = null;
								for (int i = 0; i < sendmsglist.size(); i++) {
									// MsgVO()에서 groupID를 구한 뒤 각 메시지를 보낸 그룹이름을 구한다.
									int groupID = msg.getMsgVO(sendmsglist.get(i).getMsgID()).getGroupID();
									//groupID = 0이면 문의하기, 0 이상이면 메시지 보내기
									if(groupID > 0){
										groupName = group.getGroupVO(groupID).getGroupName();
									}else{
										groupName = "문의하기";
									}
							%>
							<tr class="showSendMsg" style="height: 20px;">
								<td><%=groupName%></td>
								<td><%=sendmsglist.get(i).getToUserID()%></td>
								<td><a id="click-view" onclick="viewMsg('<%= sendmsglist.get(i).getMsgID()%>')"><%= sendmsglist.get(i).getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
								<!-- msgCheck == 0이면 안읽음, 1이면 읽음 표시하기 -->
								<% 
									if(sendmsglist.get(i).getMsgCheck() == 0){
								%>
									<td>NO</td>						
								<% 
									}else{
								%>
									<td>YES</td>						
								<% } %>
								<td><%=sendmsglist.get(i).getMsgDate().substring(0 ,11) + sendmsglist.get(i).getMsgDate().substring(11, 13) + "시" + sendmsglist.get(i).getMsgDate().substring(14, 16) + "분"%></td>
							</tr>
							<%
								}
							%>
						</tbody>
						<%
							}
						%>
					</table><br>
					<!-- 글 갯수가 1 이상이면 MORE 버튼 보이기 -->
					<% if (sendmsglist.size() != 0) { %>
					<div id="more-btn-6">MORE</div>
					<%} %>
				</div>
			</div>
		</div>
		
		<!-- 원하는 데이터 삭제하기  -->
		<div id="delete-sec1">
			<div class="select-msg">
			<form method="post" id ="deleteField2" action="userMsgDeleteAction.jsp">
				<div id="select-sec1">
					<div class="select1">
						<div class="text1">
							<input type="hidden" name="deleteField2">
							<span>삭제할 메시지 선택</span>
							<span><i class="fa-solid fa-chevron-down"></i></span>
						</div>
						<ul class="option-list1">
							<li class="option1" onclick="getCount('<%=msglist.size()%>')"><input type="hidden" id="rcvs" name="deleteField2" value="rcvMsg"><span>받은메시지</span></li>
							<li class="option1" onclick="getCount('<%=sendmsglist.size()%>')"><input type="hidden" id="sends" name="deleteField2" value="sendMsg"><span>보낸메시지</span></li>
							<li class="option1" onclick="getCount('<%=msglist.size() + sendmsglist.size()%>')"><input type="hidden" id="all" name="deleteField2" value="allMsg"><span>전체</span></li>
						</ul>
					</div>
					<div id="submit-btn">
						<button type="submit" id="dl-btn2"><span id="dl">삭제</span></button>
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>
	<% if(userID.equals("manager")){ %>
			<div id="event" onclick="viewEvent()"><div>이벤트 관리 CLICK</div></div>
	<%}%>
</section>
<script>
/*check email
window.addEventListener('DOMContentLoaded', function emailChecked(result){
	if(result == false){
		var emailck = confirm('이메일 인증이 필요합니다. 인증 메일을 발송 하시겠습니까?');
		if(emailck == true){
			location.href = "emailSendAction.jsp";
		}else{
			break;
		}
	}
});*/
</script>

<script>

//데이터 삭제 select box
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
 
//메시지 삭제 select box
//메시지를 삭제할 목록을 클릭했을때 삭제할 데이터가 없으면 알림창을 띄운다.

function onClickSelect2(e) {
	  const isActive2 = e.currentTarget.className.indexOf("active") !== -1;
	  if (isActive2) {
	    e.currentTarget.className = "select1";
	  } else {
	    e.currentTarget.className = "select1 active";
	  }
	}
	
	document.querySelector("#select-sec1 .select1").addEventListener("click", onClickSelect2);
function onClickOption2(e) {
	const selectedValue2 = e.currentTarget.innerHTML;
	document.querySelector("#select-sec1 .text1").innerHTML = selectedValue2;
}
function getCount(count){
	if(count >= 1){
		var optionList2 = document.querySelectorAll("#select-sec1 .option1");
		for (var i = 0; i < optionList2.length; i++) {
			var option2 = optionList2[i];
			option2.addEventListener("click", onClickOption2);
		}
	}
	else{
		alert("삭제할 메시지가 없습니다.");
	}
}
</script>
<script>
//그룹이름을 클릭하면 id,password,available value, member, leader를 받는다
function showPasswordPrompt(grID, grPW, grAvl) {
    var inputPassword = "";
    //그룹 활동중이면
    if(grAvl == 1){
   		//비밀번호가 일치하지 않으면 입력창 무한반복
	    while (inputPassword != grPW) {
	        inputPassword = prompt("비밀번호를 입력하세요");
	        if(inputPassword == null){ //null은 취소버튼을 눌렀을 때를 의미한다. 아무것도 입력하지 않고 확인을 누르면 ""이다.
	        	break;
	        }
	    }
   		//비밀번호가 일치하면 접속
	    if (inputPassword == grPW) {
	        location.href = "groupView?groupID=" + grID;
	    }
	//그룹 비활동중
    }else{
    	alert("비활동 중인 그룹입니다.");
    }

}

//메시지 리스트에서 제목을 클릭하면 해당 메시지 상세보기 팝업이 열린다.
function viewMsg(msgID){
   	window.open("viewMsg?msgID=" + msgID , "VIEW MESSAGE", "width=550, height=600, top=50%, left=50%");
}
//이벤트 응모 현황 관리 (manager 권한)
function viewEvent(){
	window.open("eventRafflePopUp","EVENT","width=500, height=550, top=50%, left=50%")
}
//문의하기 버튼 클릭시 메시지 전송 팝업에 qna=y 전달
function qna(){
	window.open("sendMsgPopUp?qna=y","QNA","width=500, height=550, top=50%, left=50%")
}
</script>
<script type="text/javascript" src="js/checkPW.js"></script>
</body>
</html>