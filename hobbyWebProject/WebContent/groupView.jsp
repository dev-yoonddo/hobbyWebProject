<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GROUP VIEW</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
section{
	height: 800px;
	padding-top: 150px;
	padding-left: 100px;
	padding-right: 100px;
	display: flex;
	justify-content: center;
}	
h2{
	font-family: 'Bruno Ace', cursive;
	font-weight: bold;
	font-size: 20pt;
	color: #2E2F49;
}
#group-main{
	width: 1000px;
	height: auto;
}
#group-info{
	height: 300px;
}
.btn-blue{
	width: 100px;
	height: 50px;
} 
#btn-msg{
	width: 120px;
}
</style>
<body>
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
//groupID 가져오기
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
}

if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
//유효하지 않은 그룹일때
if(groupID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('해당 그룹이 존재하지 않습니다.')");
	script.println("location.href = 'groupPage.jsp'");
	script.println("</script>");
}
//groupPage에서 이미 가입,접속에 대한 처리를 했지만 실행 도중 자동 로그아웃과같은 상황을 대비해 view 페이지에도 코드를 작성했다.
//int userAccess = Integer.parseInt(request.getParameter("userAccess"));
MemberDAO mbDAO = new MemberDAO();
GroupDTO group = new GroupDAO().getGroupVO(groupID); //하나의 그룹 정보 가져오기
MemberDTO member = new MemberDAO().getMemberVO(userID, groupID); //현재 로그인하고 groupID에 가입한 member 정보 가져오기

if(group.getGroupAvailable() == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비활동중인 그룹입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
//그룹을 만든 userID가 아닐때 (그룹을 만든 userID는 접속가능)
	if(!userID.equals(group.getUserID())){
		//접속하는 userID의 데이터가 member에 없으면
		if( member == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('가입하지 않은 회원입니다.')");
		script.println("location.href = 'groupPage.jsp'");
		script.println("</script>");
		}
		//데이터는 있지만 available값이 0이면
		if( member.getMbAvailable() == 0){ //탈퇴한 회원이기때문에 접속 불가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('탈퇴한 회원입니다.')");
		script.println("location.href = 'groupPage.jsp'");
		script.println("</script>");
		}
	}


ArrayList<MemberDTO> mblist = mbDAO.getList(groupID); //해당 그룹의 멤버리스트 가져오기
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
				<li><a href="community.jsp" class ="menu">COMMUNITY</a></li>
				<li><a class="menu" onclick="location.href='groupPage.jsp'">GROUP</a></li>
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
<section>

	<div id="group-main">
		<div id="group-info">
			<div id="group-title" style="width: 100%; height: 100px; display: flex; align-items: center;">
				<div id="title-text" style="width: 8500px; font-size: 25pt;">
				<span><%= group.getGroupName() %> 에서 함께 취미를 즐겨보세요 </span>
				</div>
				
				<div id="del-btn" style="display: flex;">
					<!-- 그룹을 만든 userID일때는 메세지확인, 그룹삭제 버튼 생성 -->
					<% if(userID.equals(group.getUserID())){ %>
						<button type="button" class="btn-blue" id="btn-msg" onclick="viewMsgList('<%= group.getGroupID()%>')"><span>메세지확인</span></button>
						<button type="button" class="btn-blue" id="btn-del" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='groupDeleteAction.jsp?groupID=<%=groupID%>'}"><span>그룹삭제</span></button>
					
					<!-- 그룹에 가입한 userID일때는 메세지전송, 그룹탈퇴 버튼 생성하고 정보 넘기기 -->
					<%}else{ %>
						<button type="button" class="btn-blue" id="btn-msg" onclick="sendMSG('<%= group.getGroupID()%>')"><span>메세지전송</span></button>							
						<button type="button" class="btn-blue" id="btn-del" onclick="if(confirm('탈퇴 후 재가입이 불가합니다.\n정말로 탈퇴하시겠습니까?')){location.href='memberDeleteAction.jsp?groupID=<%=groupID%>&memberID=<%=member.getMemberID()%>'}"><span>그룹탈퇴</span></button>
					<%} %>
				</div>
			</div>
			<hr style="width: 100%; height: 2px; background-color: black;"><br>
			Member : <%= mblist.size() %>명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Leader : <%= group.getUserID() %>
		</div>
	
		<div id="member-list" style="width: 500px; height: auto;">
		<%
			for(int i=0; i<mblist.size(); i++){
		%>
		<div id="member" style=" background-color: white; color: #2E2F49; padding: 10px; position: relative;">
			<div id="user-name">
				<div style="border-radius: 20px; color: black; border-bottom-left-radius:0; border-bottom-right-radius: 0; background-color: #D6E0FC; padding: 11px;">
				<span><%= mblist.get(i).getMemberID() %>님이 가입했습니다</span>
				<span style="position: absolute; right:20px;"><%= mblist.get(i).getMbDate().substring(0,11)+mblist.get(i).getMbDate().substring(11,13)+"시"+mblist.get(i).getMbDate().substring(14,16)+"분" %></span>
				</div>
				<div id="user-content" style="height: auto; border-width: 1px; border-color: #D6E0FC; border-radius: 20px; border-style: solid; border-top-left-radius: 0; border-top-right-radius: 0; background-color: white; padding: 10px; margin-top: 10px;">
				<%= mblist.get(i).getMbContent() %>
				</div>
			</div>
		</div><br>
		<%
			}
		%>
		</div>
	</div>
</section>
<script>
//메시지확인을 클릭하면 메시지 리스트 팝업을 띄운다.
function viewMsgList(groupID){
   	window.open("viewMsgListPopUp.jsp?groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
}
//메시지전송을 클릭하면 그룹이름과 그룹생성자(메시지수신자) 정보를 받는다.
function sendMSG(groupID) {
   	//팝업창을 열때 groupID값을 넘겨준다.
   	window.open("sendMsgPopUp.jsp?groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
}
</script>
<script>
opener.location.reload(); //부모창 리프레쉬
self.close(); // 팝업 창 닫기
</script>
</body>
</html>