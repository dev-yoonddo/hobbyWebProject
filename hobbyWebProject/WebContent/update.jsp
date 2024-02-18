<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
</head>
<style>
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
.write-table{
	width: 1000px;
}
#view-table{
	width: 1000px;
	height: 500px;
	border-collapse: collapse;
	border: 1px solid #C0C0C0;
	font-size: 12pt;
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

textarea{
	width: 1000px;
	font-size: 13pt;
	font-family: 'Nanum Gothic', monospace;
	border: none;
	resize: none;
	padding: 10px;
}
.btn-blue{
	position: relative;
	display: inline-block;
	width: 90px;
	height: 50px;
	background-color: transparent;
	border: none; 
	cursor: pointer;
	margin: 0;
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
#write-bottom{
	display: flex;
	height: 50px;
	padding: 20px;
}
#file , #file2{
	display: flex;
	width: 70%;
	border-radius: 50px;
	background-color: #CCE5FF;
	padding: 15px 25px;
	align-items: center;
}
#btn{
	width: 30%;
}
#file, #file2 > span{
	color: #606060;
}
#file, #file2 > input{
	font-size: 11pt;
}
#beforeFile{
	width: 35%;
	/*파일이름이 길면 ...으로 생략*/
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
	max-width:220px;
}
#afterFile{
	display: flex;
	align-items: center;
	width: 65%;
}
#fileupload{
	width: 10px;
	visibility: hidden;
}
#filename{
	/*파일이름이 길면 ...으로 생략*/
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
	max-width:300px;
}
#click{
	height: 25px;
	background-color: #7D95E5;
	color: white;
	border-radius: 5px;
	display: flex;
	align-items: center;
	justify-content: center;
}
@media screen and (max-width:900px) {
	.board-container , .write-table , form, textarea, table, tbody, tr, th, td{
		max-width: 700px;
	}
	#write-bottom{
		padding: 15px;
	}
	#file{
		width: 83%;
		padding: 15px;
	}
	#beforeFile{
		width: 35%;
	}
	#afterFile{
		display: flex;
		width: 65%;	
	}
	#afterFile > #filename{
		max-width: 150px;
	}
	#click{
		width: 80px;
	}
	#btn{
		width: 17%;
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
	#write-bottom{
		display: inline;
	}
	#file{
		display: block;
		width: 330px;
	}
	#file2{
		display: flex;
		width: 330px;
	}
	#beforeFile{
		width: 330px;
	}
	#afterFile{
		width: 330px;
		margin: 0;
		margin-top: 5px;
	}
	#filename{
		max-width: 150px;
	}
	#click{
		width: 70px;
	}
	#btn{
		width: 350px;
		float:right;
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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
		script.println("</script>");
	}
	//boardID 가져오기
	int boardID = 0;
	if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO board = boardDAO.getBoardVO(boardID);
%>
<!-- header -->
<header id="header">
	<jsp:include page="/header/header.jsp"/>
</header>
<!-- header -->
<!-- section -->
<section>	
	<div class="board-container">
		<h3 style="font-weight: bold; color: #646464;"><%= userID %>님 안녕하세요</h3><br>
			<div class="right-row">
				<form method="post" action="updateAction" enctype="multipart/form-data">
					<div class="category-sel">
					<input type="text" name="boardID" value="<%=boardID%>" hidden="hidden"/>
					<select name="boardCategory">
						<% if(board.getBoardCategory().equals("NOTICE")){ //공지사항 수정시 카테고리 변경 불가 %>
						<option value="NOTICE">NOTICE</option>
						<%}else{ %>
						<option value="0">CATEGORY</option>
						<option value="SPORTS" >SPORTS</option>
						<option value="LEISURE" >LEISURE</option>
						<option value="MUSIC" >MUSIC</option>
						<option value="OTHER" >OTHER</option>
						<%} %>
					</select>
					</div>
					<table class="write-table" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr translate="yes">
								<th style="background-color: #DBE2F7; text-align: center; color: #464646; height: 40px;">글 수정</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><textarea placeholder="제목을 입력하세요" name="boardTitle" maxlength="50"><%= board.getBoardTitle() %></textarea></td>
							</tr>
							<tr>
								<td><textarea placeholder="내용을 입력하세요" name="boardContent" maxlength="2048" style="height: 350px;"><%= board.getBoardContent() %></textarea></td>
							</tr>
						</tbody>
					</table>
					<div id="write-bottom">
					<%
					if(board.getFilename() != null){ %>
						<div id="file">
							<span id="beforeFile">기존 파일 : <%=board.getFilename()%></span>
							<span id="afterFile">┃ 파일첨부 :&nbsp;&nbsp;
								<label for="fileupload" id="click" class="btn-blue">click !</label>&nbsp;&nbsp;
								<div id="filename"></div>
								<input type="file" id="fileupload" name="fileupload" onchange="filename(this)" >
							</span>
						</div>
					<%}else{ %>
						<div id="file2">파일첨부 :&nbsp;&nbsp;
							<label for="fileupload" id="click" class="btn-blue">click !</label>&nbsp;&nbsp;
							<div id="filename"></div>
							<input type="file" id="fileupload" name="fileupload" onchange="filename(this)" >
						</div>
					<%} %>
						<div id="btn"><button type="submit" class="btn-blue" value="글쓰기"><span>수정하기</span></button></div>
					</div>
				</form>
			</div>
		</div>
	</section>
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
//글을 작성할 때 선택했던 카테고리가 수정할 때 선택되어있도록 한다.
let boardCategory = '<%= board.getBoardCategory() %>';

let selectBox = document.getElementsByName('boardCategory')[0];

for (let i = 0; i < selectBox.options.length; i++) {
  if (selectBox.options[i].value === boardCategory) {
    selectBox.options[i].setAttribute('selected', 'selected');
    break;
  }
}

function filename(input){
	var file = input.files[0];	//선택된 파일 가져오기

    //미리 만들어 놓은 div에 text(파일 이름) 추가
    var name = document.getElementById('filename');
    name.textContent = file.name;
}
</script>
</body>
</html>