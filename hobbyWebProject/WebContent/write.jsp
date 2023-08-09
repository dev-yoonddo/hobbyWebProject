
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>

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
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
</head>
<style>
section{
	height: 700px;
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
.write-table{
	width: 1000px;
}
select{
width: 200px;
height: 40px;
margin-bottom: 10px;
text-align: center;
font-size: 15pt;
font-weight: 500;
color: #B3C1EE;

}
option{
color: #B3C1EE;
height: 40px;
}
textarea{
width: 1000px;
font-size: 13pt;
font-family: 'Nanum Gothic', monospace;
border: none;
resize: none;
padding: 10px;
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

@media screen and (max-width:900px) {
	.board-container , .write-table , form, textarea, table, tbody, tr, th, td{
		max-width: 650px;
	}
}

@media screen and (max-width:650px) {
	.board-container , .write-table , form, textarea, table, tbody, tr, th, td{
		max-width: 350px;
	}
	thead{
		display: none;
	}
	textarea{
		padding: 0;
		float: left;
	}
	td{
		padding: 10px;
	}
	.btn-blue{
		width: 100px;
	}
}
</style>
<body>
		
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
} //로그인 확인 후 id값 얻어오기
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
//searchPage에서 글쓰기 버튼을 눌렀을 때 전달받는 카테고리 값 가져오기
String bdcategory = request.getParameter("category");
%>
<!-- header start-->
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
	<!-- header end-->
	
<section>

	<div class="board-container">
	<h3 style="font-weight: bold; color: #646464;"><%= userID %>님 안녕하세요</h3><br>
		<div class="right-row">
			<form method="post" action="writeAction.jsp" >
				<div class="category-sel" style="display: flex;">
				<select name="boardCategory">
					<option value="0">CATEGORY</option>
					<option value="SPORTS" >SPORTS</option>
					<option value="LEISURE" >LEISURE</option>
					<option value="MUSIC" >MUSIC</option>
					<option value="OTHER" >OTHER</option>
				</select>
				<!-- 관리자 계정으로 공지사항 체크박스 체크시 notice를 값으로 넘긴다. -->
				<% if(userID.equals("manager")){%>
				<div class="form-check" style="display: flex; height: 40px; align-items: center;">
					<input type="checkbox" hidden="hidden" name="notice" value="NULL" checked="checked">
					<input class="form-check-input" type="checkbox" name="notice" value="NOTICE" id="flexCheckDefault">
					<label class="form-check-label" for="flexCheckDefault">
					  공지사항
					</label>
				</div>
				<%} %>
				</div>
				<table class="write-table" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr translate="yes">
							<th style="background-color: #DBE2F7; text-align: center; color: #464646; height: 40px;">글 작성</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><textarea placeholder="제목을 입력하세요" name="boardTitle" maxlength="50"></textarea></td>
						</tr>
						<tr>
							<td><textarea placeholder="내용을 입력하세요" name="boardContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<button type="submit" class="btn-blue" value="글쓰기"><span>작성하기</span></button>
			</form>		
		</div>
	</div>
</section>
<script>
//체크박스 한가지만 선택되도록 하기
$(document).on('click', "input[type='checkbox']", function(){
    if(this.checked) {
        const checkboxes = $("input[type='checkbox']");
        for(let i = 0; i < checkboxes.length; i++){
            checkboxes[i].checked = false;
        }
        this.checked = true;
    } else {
        this.checked = false;
    }
});
</script>

<script>
//글쓰기 버튼을 클릭했던 페이지의 카테고리가 글 작성시 선택되어있도록 한다.
let bdcategory = '<%= bdcategory %>';

let selectBox = document.getElementsByName('boardCategory')[0];

for (let i = 0; i < selectBox.options.length; i++) {
  if ((selectBox.options[i].value) === bdcategory) {
    selectBox.options[i].setAttribute('selected', 'selected');
    break;
  }
}
</script>
	<!-- 부트스트랩 참조 영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>