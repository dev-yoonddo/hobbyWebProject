<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="group.GroupDTO" %>
<%@ page import="group.GroupDAO" %>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = yes, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>


</head>
<style>
body{
	height: auto;
}
section{
	padding-top: 100px;
	display: flex;
	justify-content: center;
	align-items: center;
}
#sec-top{
	width: 100%;
	display: flex;
	justify-content: center;
}

#ani-text{
	color: #646464;
	font-size: 35pt;
	font-weight: bold;
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	justify-content: center;
}
#main-text{
	font-weight: bold; 
	font-size: 25pt;
	color: #2E2F49;
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	justify-content: center;
}
.btn-blue{
	width: 250px;
	height: auto;
	float: none;
	display: flex;
	justify-content: center;
	margin: 0 auto;	 
}
.btn-blue span{
	width: 230px;
	height: auto;
	margin: 0 auto;
	color: #ffffff;
	background-color: #2E2F49;
	border: 1px solid #2E2F49;
	border-radius: 200px;
	font-size: 15pt;
	padding: 15px 20px;
}

.btn-blue::before {
	background-color: #2E2F49;
}

.btn-blue span:hover {
	color: #2E2F49;
	background-color: #ffffff
}
#row{
	height: auto;
	margin-top: 100px;
}

#gallery {
	height: auto;
	display: flex;
  	justify-content: center;
}
#gal-inner{
	max-width: 1100px;
	width: auto;
	height: auto;
	padding-top: 100px;
	
}
.group-row{
	display: flex;
}
.group-box {
	border-radius: 10px;
	transition: transform 0.5s ease;
	height: 300px;
	width: 300px;
	background-color: #C9D7FF;
	margin: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.group-box:hover {
	transform: scale(1.2);
}
.group-box:hover > .info-box{
	opacity: 0;
}
.group-box:hover > .group-inner-box {
	opacity: 1;
	transform: scale(1);
}

.group-inner-box {
	width: 300px;
	height: 300px;
	opacity: 0;
	transition: opacity 0.5s ease,
	  transform 0.5s ease;
	position: absolute;
	background-color: #2E2F49;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.info-box{
	width: 230px;
  	height: 230px;
	justify-content: center;
	position: relative;
	font-size: 20pt;
	margin: 30px;
}
div > .info-a{
	display: flex;
	justify-content: center;
	font-size: 15pt; 
	border-radius: 50px; 
	background-color: white; 
	width: 100px;
	height: 40px; 
	margin-top: 10px;
}
div > .info-a > a{
	width:auto; 
	height: auto; 
	display: flex; 
	justify-content: center; 
	align-items: center;
}
#disable > a{
	color: white;
}
.info-b{
	position: absolute;
	bottom: 0;
}
.info-l , .info-p{
	height: 35px;
	font-size: 18pt;
	font-weight: 400;
}
.access-group{
	width: auto;
	height: auto;
	color: white;
	justify-content: center;
	align-items: center;
}
.in-group-btn{
	margin: 0 auto;
}
@media screen and (max-width:650px) {
	#ani-text{
		font-size: 23pt;
	}
	#main-text{
		font-size: 20pt;
	}
	#gallary{
		width: 500px;
	}
	.group-row{
		display: inline;
		justify-content: center;
	}
	.group-box {
		margin: 30px;
	}
	
}
  </style>
</head>

<body>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
//if(userID==null) {
//	response.sendRedirect(request.getContextPath()+"/login");
//}
%>
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<section>
<div>
<div id="sec-top">
	<div>
		<div style="width : auto;">
			<span class="text" id="ani-text"></span><br><br><br>
		</div>
		<div style="width: 600px; margin: 0 auto;">
			<span id="main-text">그룹을 만들거나 참여해보세요</span><br>
			<button type="button" class="btn-blue" id="create-group" onclick="createGroup()" value="그룹생성"><span>그룹 만들기</span></button>	
		</div>
	</div>
</div>
<div id="gallery">
<div id="gal-inner">
		<%
			GroupDAO groupDAO = new GroupDAO();
			ArrayList<GroupDTO> list = groupDAO.getList();
			int counter = 0;
			for (int i = 0; i < list.size(); i++) {	
			//int groupID = list.get(i).getGroupID();
		%>
		<%
		//group을 한개씩 출력할 때 마다 counter++ 해서 3개가 출력될 때 마다 group-row로 감싸도록 한다.
		if (counter % 3 == 0) {
        %>
        <div class="group-row">
        <%
        } counter++;
        %>
		<div class="group-box">
			<div class="info-box">
				<div style="">
				<div class="info-title" id="in-group" style="font-size:30pt; font-weight: bold;">  
	                <a>
	                	<%=list.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
	                </a>
		        </div>
				<% if(list.get(i).getGroupAvailable() == 1){%>
				<div class="info-a">
					<a>활동중</a>
				</div>
				<%}else{ %>
				<div class="info-a" id="disable" style="background-color: black;">
					<a>비활동중</a>
				</div>
				<%} %>
				</div>
				<div class="info-b">
		 			<div class="info-l"><a>Leader  <%= list.get(i).getUserID() %></a></div>
					<%
						//그룹에 가입한 멤버숫자 가져오기
						MemberDAO mbDAO = new MemberDAO();
						ArrayList<MemberDTO> mblist = mbDAO.getList(list.get(i).getGroupID());
						
						//해당 그룹을 만든 유저 정보 가져오기
						GroupDTO groupuser = new GroupDAO().getGroupVO(list.get(i).getGroupID());
						//그룹을 생성한 유저인지 확인하기
						boolean leader = userID.equals(groupuser.getUserID());
						
						//해당 그룹에 유저가 이미 가입했는지 확인
						MemberDTO member = new MemberDAO().getMemberVO(userID, list.get(i).getGroupID());
						//해당 그룹에 유저가 이미 탈퇴했는지 확인
						MemberDTO memberDel = new MemberDAO().getMemberDelVO(userID, list.get(i).getGroupID());
					%>
					<div class="info-p"><a><%= mblist.size() %>명 / <%= list.get(i).getGroupNoP() %>명</a></div>
				</div>
			</div>
  			<div class="group-inner-box">
				<div class="access-group">
				<% if(!userID.equals(list.get(i).getUserID())){%>
					<button type="button" class="btn-blue" id="join-group-btn" value="그룹가입" onclick="joinGroup('<%=list.get(i).getGroupID()%>','<%= list.get(i).getGroupAvailable()%>','<%= mblist.size() %>','<%= list.get(i).getGroupNoP() %>','<%=member%>','<%=memberDel%>')">
					<span>가입하기</span>
					</button>
				<%} %>
					<button type="button" class="btn-blue" id="in-group-btn" value="그룹참가" onclick="showPasswordPrompt('<%=list.get(i).getGroupID()%>', '<%=list.get(i).getGroupPassword()%>','<%= list.get(i).getGroupAvailable()%>','<%=member%>','<%=leader%>')">
					<span>접속하기</span>
					</button>
				</div>
			</div>
		</div>		
		<% 
      if (counter % 3 == 0) {
        %>
        </div>
        
        <%  
      }
    }
    %>
		
</div>		
</div>
</div>	
</section>
<!--  
  <div class="wrapper">
    <section class="main">
      <div class="first-container item">1</div>
      <div class="second-container item">2</div>
      <div class="third-container item">3</div>
    </section>
    <section class="aside">
      <div class="first-sidebar side droppable"></div>
      <div class="second-sidebar side droppable"></div>
      <div class="third-sidebar side droppable"></div>
      <div class="xxx-sidebar side droppable"></div>

    </section>
  </div>
-->
<script>
//텍스트 타이핑
const content = "ALWAYS BETTER TOGETHER";
const text = document.querySelector('#ani-text');
let i = 0;
function typing() {
    if (i < content.length) {
	    let txt = content.charAt(i);
	    text.innerHTML += txt;
	    i++;
    }
}
	setInterval(typing, 150)
</script>
<script>
//그룹 만들기 버튼 클릭시 그룹 팝업을 띄운다.
function createGroup(){
  	window.open("groupPopUp" , "CREATE", "width=450, height=500, top=50%, left=50%") ;
}

//가입하기 버튼을 클릭하면 id,available값과 현재 멤버 수, 가입 가능 멤버 수, 유저 가입 여부를 받는다.
function joinGroup(groupID, groupAvailable, mbNum, grNum, member,memberDel) {
	//활동중
    if(groupAvailable == 1){
        var joinGroup = confirm("가입 하시겠습니까?");
        if (joinGroup) {
        	if(member != "null"){
        		if(memberDel != "null"){
        			alert("탈퇴한 회원은 재가입이 불가능합니다.");
        		}else{
        		alert("이미 가입한 그룹입니다.");
        		}
        	}else if(mbNum == grNum){
        		alert("정원이 다 찼습니다.");
        	}else{
        	//팝업창을 열때 groupID값을 넘겨준다.
          	window.open("memberJoinPopUp?groupID=" + groupID , "Join", "width=450, height=500, top=50%, left=50%") ;
        	}
        }
        else {

        }
	//비활동중
    }else{
    	alert("비활동 중인 그룹입니다.");
    }
}
</script>
<script>

//접속하기 버튼을 클릭하면 id,password,available value, member, leader를 받는다
function showPasswordPrompt(grID, grPassword, grAvailable, member, leader) {
    var inputPassword = "";
    var count = 0;
    var searchPW = false;
 	 //그룹 활동중
    if(grAvailable == 1){
		//그룹 생성자이면 비밀번호 입력 없이 접속
		if(leader == "true"){
			location.href = "groupView?groupID=" + grID;
		}else{
		//그룹 생성자가 아니면
	    	//member에 데이터가 없으면 (userID, groupID가 일치하는 데이터가 없으면) 가입하지 않은 유저
	    	if(member == "null"){
	    		alert("가입 후 접속해주세요");
	    	//member에 데이터가 있으면
	    	}else{
	    		//비밀번호가 일치하지 않으면 입력창 무한반복
			    while (inputPassword != grPassword) {
			    	count++;
			        inputPassword = prompt("비밀번호를 입력하세요");
			        if(inputPassword == null){ //null은 취소버튼을 눌렀을 때를 의미한다. 아무것도 입력하지 않고 확인을 누르면 ""이다.
			        	break;
			        }
			        if(count == 5){ //비밀번호가 5회 오류이면 비밀번호 찾기 창 띄우기
		    			searchPW = confirm("비밀번호 5회 오류입니다. 비밀번호 찾기를 하시겠습니까?");
		    			if(searchPW){ //확인 클릭시 비밀번호 찾기 팝업
		    	          	window.open("findPwPopUp" , "findPassword", "width=450, height=500, top=50%, left=50%") ;
		    			}else{ //취소
		    				break;
		    			}
			        }
			    }
	    		//비밀번호가 일치하면 접속
			    if (inputPassword == grPassword) {
			        location.href = "groupView?groupID=" + grID;
			    }
	    	}
		}
	//그룹 비활동중
    }else{
    	alert("비활동 중인 그룹입니다.");
    }
    
    /* 다른 while
    while(true) {
        inputPassword = prompt("Enter group password:");
	    if (inputPassword == grPassword) {
	        location.href = "groupView.jsp?groupID=" + grID;
	        break;
	    }
    }
    */
}
</script>
<script>
opener.location.reload(); //부모창 리프레쉬
self.close();
</script>
</body>

</html>