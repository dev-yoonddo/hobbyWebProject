<%@page import="chat.ChatDAO"%>
<%@page import="chat.ChatDTO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp" %>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
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
body{
	height: auto;
}
section{
	height: auto;
	padding-top: 100px;
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
#group-title{
	width: 100%;
	height: 100px;
	display: flex;
	align-items: center;
}
#title-text{
	font-size: 25pt;
	width: 730px;
}
#group-main{
	width: 1000px;
	height: auto;
}
#groupInfo{
	height: auto;
	max-height: 300px;
	margin-bottom: 5px;
}
#join-list-animated{
	width: 350px;
	max-width: 450px;
	height: 30px;
	position: relative;
	overflow-x: hidden;
	overflow-y: hidden;
}
#join-list{
	max-width: auto;
	height: auto;
	position: absolute;
	white-space: nowrap;
	will-change: transform;
	animation: marquee 6s linear infinite;
}
.join-list-inner{
	height: 20px;
	padding: 3px;
}
/* 가입리스트 애니메이션 */
@keyframes marquee {
  from { transform: translateY(20%); }
  to { transform: translateY(-100%); }
}
.btn-blue{
	width: 100px;
	height: 50px;
} 
#btn-msg{
	width: 120px;
}
#title-btn{
	display: flex;
	float: right;
}
#write-notice{
	display: none;
	width: 30%;
	max-height: 200px;
	float: right;
}
#text-notice{
	width: 290px;
	height: 80px;
	font-size: 12pt;
	resize: none;
	padding: 5px;
	margin-top: 5px;
}

.group-bottom{
	width: 100%;
	height: auto;
	min-height: 100px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 50px;
}
#chat{
	width: 400px;
	height: auto;
	min-height: 100px;
	margin-bottom: 10px;
}
#chat-head{
	border-radius: 20px; 
	color: black; 
	border-bottom-left-radius:0; 
	border-bottom-right-radius: 0; 
	background-color: #D6E0FC; 
	padding: 15px;
	position: relative;
}
#chat-content{
	height: auto; 
	border-width: 1px; 
	border-color: #D6E0FC; 
	border-radius: 20px; 
	border-style: solid; 
	border-top-left-radius: 0; 
	border-top-right-radius: 0; 
	background-color: white; 
	padding: 10px; 
	margin-top: 10px;
}
#chatSend{
	width: 500px;
	height: 40px;
	background-color: white;
	color: #2E2F49;
	padding: 10px;
	display: flex;
}
#chatView{
	width: 800px;
	min-height: 50px;
	max-height: 500px;
	align-items: center;
	overflow-y: auto;
	display:flex;
	flex-direction:column-reverse;
}
#chatList{
	width: 700px;
	height: auto;
}
#chatText{
	width: 400px;
	height: 40px;
	display: flex;
	border-style: solid;
	border-radius: 20px;
	border-width: 3px;
	border-color: #B8D7FF;
	margin: 0;
	padding: 8px;
	font-size: 12pt;
	resize: none;
}
#large{
	position: absolute;
	right:20px;
}
#small{
	position: absolute;
	right:20px;
	display: none;
}
#info{
	display: flex; 
	width: 100%; 
	min-height: 30px;
	max-height: 200px;
}
#info-list{
	min-width: 70%; 
	max-width: 100%;
	height: 30px; 
	display: flex; 
	align-items: center;
}
.list-text{
	margin-right: 20px;
}
#notice-btn{
	width: 40%; 
	text-align: right;
	float: right;
	align-items: center;
}
#notice{
	height: auto;
	font-size: 20pt; 
	font-weight: bold;
	display: flex;
	margin: 0 auto;
	padding: 10px;
	padding-bottom: 50px; 
}
#notice-box{
	font-size: 17pt; 
	border-radius: 20px; 
	padding: 10px; 
	background-color: #DCDCDC; 
	width: 650px;
	display: flex;
	justify-content: center;
}
#detail{
	width: 100%;
	height: auto;
	margin-top: 20px;
	display: inline-table;
	align-items: center;
}
@media screen and (max-width:850px) {

	#title-text{
		font-size: 17pt;
	}
	#info-list{
		min-width: 50%;
		max-width: 100%;
		max-height: 60px;
	}
	#info-list-1{
		width: 150px;
		margin-right: 20px;
	}
	.list-text{
		margin-right: 0;
	}
	#join-list-animated{
		margin-top: 5px;
	}
	#notice-btn{
		width: 50%;
	}
	#write-notice{
		width: 50%;
	}
	#text-notice{
		width: 250px;
		height: 70px;
		font-size: 10pt;
	}
	.group-bottom{
		width: 650px;
	}
	#notice{
		font-size: 20pt;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	#notice-box{
		width: 450px;
	}
	#group-main{
		width: 650px;
	}
	#title-btn{
	}
	#chatList{
		width: 550px;
		height: auto;
	}
}
@media screen and (max-width:650px) {
	#group-title{
		height: 120px;
	}
	#title-text{
		width: 200px;
		font-size: 16pt;
	}
	#group-main{
		width: 400px;
	}
	#title-btn{
		width: 200px;
	}
	.group-bottom{
		width: 400px;
		margin-bottom: 20px;
	}
	.btn-blue{
		width: 60px;
		margin: 0;
	}
	.btn-blue span{
		width: 60px;
		font-size: 8pt;
		margin: 0;
	}
	#btn-msg{
		width: 70px;
		margin-right: 30px;
	}
	#btn-msg > span{
		width: 70px;
	}
	#write-notice{
		width: 250px;
		margin-top: 10px;
	}
	#info{
		display: inline;
	}
	#notice{
		width: 360px;
		font-size: 15pt;
		padding-top: 10px;
		padding-bottom: 20px;
		display: inline-table;
		
	}
	#notice-box{
		font-size: 12pt;
		width: 380px;
	}
	#text-notice{
		width: 230px;
		height: 50px;
		font-size: 10pt;
	}
	#info-list-1{
		width: 150px;
	}
	#join-list-animated{
		width: 250px;
	}
	.join-list-inner{
		text-align: right;
		float: right;
	}
	#ntc-cpl{
		margin-right: 30px;
	}
	#chatView{
		width: 400px;
	}
	#chatList{
		width: 370px;
		height: auto;
	}
	#chat{
		width: 270px;
		font-size: 10pt;
	}
	#chatSend{
		width: 400px;
		justify-content: center;
	}
	#chatText{
		width: 200px;
		font-size: 10pt;
	}
	#submit{
		width: 90px;
	}
	#large{
		display: none;
	}
	#small{
		display: inline-block;
		padding-bottom: 20px;
	}
	#info{
		display: inline;
		margin-bottom: 0;
	}
	#insert-notice{
		width: 100%; text-align: right; padding-top: 10px;
	}
	#detail{
		margin-top: 10px;
	}

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
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
//유효하지 않은 그룹일때
if(groupID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('해당 그룹이 존재하지 않습니다.')");
	script.println("location.href = 'groupPage'");
	script.println("</script>");
}
//groupPage에서 이미 가입,접속에 대한 처리를 했지만 실행 도중 자동 로그아웃과같은 상황을 대비해 view 페이지에도 코드를 작성했다.
//int userAccess = Integer.parseInt(request.getParameter("userAccess"));
MemberDAO mbDAO = new MemberDAO();
ChatDAO chatDAO = new ChatDAO();
GroupDTO group = new GroupDAO().getGroupVO(groupID); //하나의 그룹 정보 가져오기
MemberDTO member = new MemberDAO().getMemberVO(userID, groupID); //현재 로그인하고 groupID에 가입한 member 정보 가져오기
ChatDTO chat = new ChatDAO().getChatVO(groupID);

if(group.getGroupAvailable() == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비활동중인 그룹입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
boolean leader = userID.equals(group.getUserID());
//그룹을 만든 userID가 아닐때 (그룹을 만든 userID는 접속가능)
	if(!leader){
		//접속하는 userID의 데이터가 member에 없으면
		if( member == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('가입하지 않은 회원입니다.')");
		script.println("location.href = 'groupPage'");
		script.println("</script>");
		}
		//데이터는 있지만 available값이 0이면
		if( member.getMbAvailable() == 0){ //탈퇴한 회원이기때문에 접속 불가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('탈퇴한 회원입니다.')");
		script.println("location.href = 'groupPage'");
		script.println("</script>");
		}
	}


ArrayList<MemberDTO> mblist = mbDAO.getList(groupID); //해당 그룹의 멤버리스트 가져오기
ArrayList<ChatDTO> chatlist = chatDAO.getChatList(groupID); //해당 그룹의 채팅리스트 가져오기
int chatsize = chatlist.size();
%>

<!-- header -->
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<!-- header -->
<section>
	<div id="group-main">
		<!-- 그룹보기 페이지 상단 -->
		<div id="groupInfo">
			<div id="group-title">
				<div id="title-text">
				<span><%= group.getGroupName() %> 에서 함께 취미를 즐겨보세요 </span>
				</div>
				
				<div id="title-btn">
					<!-- 그룹을 만든 userID일때는 메세지확인, 그룹삭제 버튼 생성 -->
					<% if(leader){ %>
						<button type="button" class="btn-blue" id="btn-msg" onclick="viewMsgList('<%= group.getGroupID()%>')"><span>메세지확인</span></button>
						<button type="button" class="btn-blue" id="btn-del" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='groupDeleteAction.jsp?groupID=<%=groupID%>'}"><span>그룹삭제</span></button>
					
					<!-- 그룹에 가입한 userID일때는 메세지전송, 그룹탈퇴 버튼 생성하고 정보 넘기기 -->
					<%}else{ %>
						<button type="button" class="btn-blue" id="btn-msg" onclick="sendMSG('<%= group.getGroupID()%>')"><span>메세지전송</span></button>							
						<button type="button" class="btn-blue" id="btn-out" onclick="if(confirm('탈퇴 후 재가입이 불가합니다.\n정말로 탈퇴하시겠습니까?')){location.href='memberDeleteAction.jsp?groupID=<%=groupID%>&memberID=<%=member.getMemberID()%>'}"><span>그룹탈퇴</span></button>
					<%} %>
				</div>
			</div>
			<hr style="width: 100%; height: 2px; background-color: black;"><br>
			<div id="info">
				<div id="info-list">
					<div id="info-list-1">
						<span class="list-text">Member : <%= mblist.size() %>명</span><span class="list-text">Leader : <%= group.getUserID() %></span>
					</div>
					<div id="join-list-animated">
						<div id="join-list">
						<%
							for(int i=0; i<mblist.size(); i++){
						%>
							<div class="join-list-inner">
								<span><%= mblist.get(i).getMemberID() %>님이 가입했습니다</span>
							</div>
						<%	} %>
						</div>
					</div>
				</div>
				<%
					if(leader){
				%>
						<div id="notice-btn" >
				<%
						//등록된 공지사항이 없으면 등록하기, 있으면 변경하기로 출력
						if(group.getGroupNotice() == null){
				%>
							<div id="insert-notice" onclick="ntcAction()">공지사항 등록하기</div>
				<% 		}else{ %>
							<div id="insert-notice" onclick="ntcAction()">공지사항 변경하기</div>
				<%		}%>
				
						</div>
				<%
					}
				%>
				<!-- 리더는 공지사항 입력/변경 가능 -->	
				<div id="write-notice">
					<textarea id="text-notice" placeholder="공지 내용을 입력하세요" maxlength="100"></textarea>
		       		<button type="button" class="btn-blue" id="ntc-cpl" onclick="noticeAction()"><span>완료</span></button>
			   </div><br><br>
			</div>
		</div>
		<!-- 그룹보기 페이지 상단 끝-->
		
		<!-- 그룹보기 페이지 하단 -->
		<div id="detail">
			<div class="group-bottom" style="margin: 0;">
				<div id="notice">
					<div style="display: flex;"><i class="fa-regular fa-bell"></i>&nbsp;그룹 공지&nbsp;&nbsp;&nbsp;</div>
					<div id="notice-box">
					<% //공지사항이 not null 인데 ""빈 문자열이면 공지없음, 아니면 공지를 출력한다.
						if(group.getGroupNotice() != null){ 
							if(group.getGroupNotice().equals("")){
					%>
								<span>등록된 공지가 없어요</span>
					<%
							}else{ 
					%>
								<span><%=group.getGroupNotice()%></span>
					<%
							}
						}else{ //공지사항이  null이면 공지없음을 출력한다.
					%>
							<span>등록된 공지가 없어요</span>
					<%
						}
					%>
					</div>
				</div>
			</div>
			<div class="group-bottom">
				<div id="chatView">
				<% if(chatlist.size() == 0){ %>
					<h3> 멤버들과 대화를 시작해보세요 !</h3>
				<%}else{ %>
					<%
						for(int i = 0; i < chatlist.size(); i++){
					        MemberDTO mbID = mbDAO.getMemberVO(chatlist.get(i).getUserID(), chatlist.get(i).getGroupID());
					%>
							<div id="chatList">
								<%
									boolean userChat = chatlist.get(i).getUserID().equals(userID);
									if(!userChat){
								%>
								<div id="chat" style="float: right;">
								<%}else{ %>
								<div id="chat" style="float: left;">
								<%} %>
									<div id="chat-head">
									<%if(group.getUserID().equals(chatlist.get(i).getUserID())){ %>
										<span style="font-weight: bold;">리더</span>
									<%}else{%>
										<% if(mbID.getMbAvailable() == 0 || chatlist.get(i).getChatAvailable() == 0){ //탈퇴한 회원이거나 그룹탈퇴한 회원이면%>
											<span>탈퇴한 회원</span>										
										
										<%}else{ %>
											<span><%= mbID.getMemberID()%></span>
										<%}
									}%>
										<span id="large" ><%= chatlist.get(i).getChatDate().substring(0,11)+chatlist.get(i).getChatDate().substring(11,13)+"시"+chatlist.get(i).getChatDate().substring(14,16)+"분" %></span>
										<!-- 화면이 작아지면 시간은 뺀다 -->
										<span id="small" ><%= chatlist.get(i).getChatDate().substring(0,11)%></span>
									</div>
									
									<div id="chat-content">
									<%if(mbID != null && mbID.getMbAvailable() == 0 || chatlist.get(i).getChatAvailable() == 0){ //리더가 아니고 (mbID != null) 회원탈퇴 또는 그룹탈퇴했으면 삭제된 메시지로 출력%>
										<span>삭제된 메시지입니다.</span>
									<%}else{ //리더이거나 (mbID == null) 회원탈퇴, 그룹탈퇴 하지 않은 멤버의 메시지 출력%>
										<%= chatlist.get(i).getChatContent() %>
									<%} %>
									</div>
								<%if(!userChat){%>
								</div>
								<%}else{ %>
								</div>
								<%} %>
							</div>
					<%
						}
					}
					%>
				</div>
			</div>

			<!-- 채팅 전송 -->
			<div class="group-bottom">
				<div id="chatSend">
			        <textarea id="chatText" placeholder="채팅 내용을 입력하세요" maxlength="300"></textarea>
			        <div id="chat-btn">
				        <button type="button" class="btn-blue" id="submit"><span>전송</span></button>
					</div>
			    </div>
		    </div>
		</div>
		<!-- 그룹보기 페이지 하단 끝 -->
	</div>
	
</section>
<script>
var userID = "<%=userID%>";
var groupID = "<%=groupID%>";

//메시지확인을 클릭하면 메시지 리스트 팝업을 띄운다.
function viewMsgList(groupID){
   	window.open("viewMsgListPopUp?groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
}
//메시지전송을 클릭하면 그룹이름과 그룹생성자(메시지수신자) 정보를 받는다.
function sendMSG(groupID) {
   	//팝업창을 열때 groupID값을 넘겨준다.
   	window.open("sendMsgPopUp?groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
}

//공지사항 등록하기를 클릭하면 텍스트박스 노출
function ntcAction(){
	document.getElementById('write-notice').style.display = 'block';
	document.getElementById('text-notice').style.display = 'block';
	document.getElementById('insert-notice').style.display = 'none';
	document.getElementById('notice-btn').style.display = 'none';
}
</script>

<script>
//채팅입력 후 엔터키 클릭
$('#chatText').on('keydown', function(e) {
    var keyCode = e.which;
    if (keyCode === 13) { // Enter Key
        registChat($('#chatText').val(), userID, groupID);
    }
});
//채팅입력 후 전송버튼 클릭
$('#submit').on('click', function(e) {
    e.preventDefault();
	registChat($('#chatText').val() , userID, groupID);
});

//채팅 전송이 완료되면 chat-view 부분만 새로고침해 채팅을 불러온다.
function reloadChat(){
	$('#chatView').load(location.href+' #chatView');
}

//공지사항 내용 입력 후 확인버튼 클릭 -> 한 번만 공지사항 등록이 되고 두 번째부터 실행되지 않는 오류 발생
/*$('#ntc-cpl').on('click', function(e) {
    e.preventDefault();
	noticeAction($('#text-notice').val() , groupID);
});*/

//공지사항 등록이 완료되면 공지, 채팅 부분 새로고침
function reloadNotice(){
	$('#info').load(location.href+' #info');
	$('#notice').load(location.href+' #notice');
}

//공지사항 입력 및 변경
function noticeAction(){
	var value = $('#text-notice').val(); //입력한 텍스트 가져오기
	
	if(groupID == null || groupID == 0){
		alert('그룹 오류입니다.');
	}
	else if(userID == null){
		alert('로그인이 필요합니다.');
		window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	}else{
		
		var data = {
	            content: value,
	            groupID: groupID
	    };
	    $.ajax({
	        type: 'POST',
	        //url: 'https://toogether.me/chatSendAction',
	        url: 'noticeAction',
	        data: data,
	        success: function (response) {
	        	if(response.includes("group error")){
	        		alert('그룹 오류');
	        	}else if(response.includes("none")){
	        		alert('내용을 입력하세요');
	        	}else if(response.includes("database error")){
	        		alert('데이터베이스 오류');
	       		}else{
	             //console.log('Spot registration successful:', response);
	             //alert('완료');
	            	reloadNotice();
	       		}
	        },
	        error: function (xhr, status, error) {
	            //console.error('Spot registration error:', error);
	            alert('채팅 오류');
	        }
	    });
	}
}
/*setInterval(function () {
	$('#chatView').load(location.href+' #chatView');
}, 1000);*/
var chatsize1;
var chatsize2 = <%=chatsize%>; //초기 chatlist 크기를 가져온다.

setInterval(function () { //1초마다 데이터베이스에서 해당그룹의 채팅 리스트 크기를 가져온다.
	var data1 = {
      groupID: groupID
   };
    $.ajax({
        type: 'GET',
        //url: 'https://toogether.me/getLatestChatMessage',
        url: 'getNewChatMessage',
        data: data1,
        success: function (size) {
           	chatsize1 = size; //get으로 가져온 해당 그룹의 chatlist 크기를 저장      	
           	if(chatsize1 != chatsize2){ //처음 chatlist 크기와 가져온 크기가 다르면
           		reloadChat(); //chatView 부분 새로고침 후
           		chatsize2 = chatsize1; //리스트 사이즈를 동일하게 수정
            	//console.log(chatsize1);
            	//console.log(chatsize2);
           	}else{ //리스트 사이즈가 같으면 새로고침 하지 않는다.
            	//console.log(chatsize1==chatsize2);
           	}
        },
        error: function (xhr, status, error) {
            console.error('Error fetching latest chat message:', error);
        }
    });
}, 1000); 

//마지막 유저 이름을 가져와서 본인이 아닌 사용자가 마지막으로 채팅을 입력했을때만
//새로고침하는 이 방법은 채팅창의 윗부분을 볼 때 새로고침되는 오류가 생겨 사용하기 어렵다.
/*setInterval(function () {
	   var data1 = {
		  userID: userID,
	      groupID: groupID
	   };
	    $.ajax({
	        type: 'GET',
	        //url: 'https://toogether.me/getLatestChatMessage',
	        url: 'getLatestChatMessage',
	        data: data1,
	        success: function (latestMessage) {
	            if(latestMessage.includes("no user")){
	            	console.log("데이터베이스 오류");
	            	//alert('로그인이 필요합니다');
	            	//window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	            }else if(latestMessage.includes("empty")){
	            	console.log('채팅 데이터가 없습니다');
	            }else if(latestMessage.includes("mismatch")) {
	            	//console.log("불일치");
	            	//1초마다 채팅리스트 데이터에 마지막으로 채팅을 전송한 유저와 로그인 유저가 일치하는지
	            	//구해서 불일치하면 채팅창을 새로고침한다.
	                reloadChat();
	            }else{
	            	//console.log("마지막 채팅전송 유저 일치");
	            }
	        },
	        error: function (xhr, status, error) {
	            console.error('Error fetching latest chat message:', error);
	        }
	    });
	}, 1000);*/
	
	
function registChat(value, userID, groupID){
	if(groupID == null || groupID == 0){
		alert('그룹 오류입니다.');
	}
	else if(userID == null){
		alert('로그인이 필요합니다.');
		window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	}else{
		
	var data2 = {
           content: value,
           userID: userID,
           groupID: groupID
       };
       $.ajax({
           type: 'POST',
           //url: 'https://toogether.me/chatSendAction',
           url: 'chatSendAction',
           data: data2,
           success: function (response) {
           	if(response.includes("null userID")){
           		alert('로그인을 해주세요');
           		window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
           	}else if(response.includes("Information Error")){
           		alert('정보 오류');
           	}else if(response.includes("none")){
           		alert('채팅을 입력하세요');
           	}else if(response.includes("Database Error")){
           		alert('데이터베이스 오류');
          		}else{
                //console.log('Spot registration successful:', response);
                //alert('완료');
               	reloadChat();
              	//채팅 입력창을 비운다.
            	$('#chatText').val('');
                //console.log(data);
          		}
           },
           error: function (xhr, status, error) {
               //console.error('Spot registration error:', error);
               alert('채팅 오류');
           }
       });
	}
	
}

</script>
<script>
opener.location.reload(); //부모창 리프레쉬
self.close(); // 팝업 창 닫기
</script>
</body>
</html>