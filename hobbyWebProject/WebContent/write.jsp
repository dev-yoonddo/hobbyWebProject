
<%@page import="location.LocationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="location.LocationDAO"%>
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
.category-sel{
	display: flex;
	position: relative;
	
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
#file{
	display: flex;
	width: 65%;
	border-radius: 50px;
	background-color: #CCE5FF;
	padding: 10px 25px;
	align-items: center;
}
#file > input{
	font-size: 11pt;
}
#file > #txt{
	width: 70px;
}
#filename{
/*파일이름이 길면 ...으로 생략*/
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
	max-width:300px;
}
#fileupload{
	width: 10px;
	visibility: hidden;
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
#btn{
	width: 35%;
}
/*스팟초대 버튼*/
#spot-sel{
	width: 50%;
	display: flex;
	position: absolute;
	left: 220px;
}
#invite-spot-open{
	width: 100px;
	height: 40px;
}
#invite-spot-close{
	width: 100px;
	height: 40px;
	display: none;
}
#invite-spot-open span , #invite-spot-close span{
	font-size: 10pt;
}
#spot-popup{
	width: 240px;
	max-height: 200px;
	overflow-y: auto;
	font-size: 9pt;
	flex-direction:column-reverse;
	z-index:55;
	left: 20px;
	position: relative;
	background-color: #DBE2F7;
	border-radius: 10px;
	padding: 5px;
	 
}
.spot-row >td{
	border-bottom: solid 1px #C0C0C0;
}
#result-td{
	max-height: 200px;
}
#result{
	width: 100%;
	max-height: 200px;
	padding: 3px;
	display: flex;
	flex-wrap: wrap;
}
.sel-result{
	max-width: 150px;
	max-height: 20px;
	padding: 5px 8px;
	background-color: #DBE2F7;
	border-radius: 50px;
	margin: 5px;
}
@media screen and (max-width:900px) {
	.board-container , .write-table , form, textarea, table, tbody, tr, th, td{
		max-width: 650px;
	}
	#filename{
		max-width:200px;
		
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
		padding-top: 10px;
	}
	#file{
		width: 330px;
	}
	#filename{
		max-width:150px;
	}
	#click{
		width: 80px;
	}
	#btn{
		width: 350px;
		float:right;
		margin-top: 10px;
	}
	select{
		width: 150px;
		height: 40px;
		margin-bottom: 10px;
		text-align: center;
		font-size: 15pt;
		font-weight: 500;
		color: #B3C1EE;
	
	}
	#spot-sel{
		width: 200px;
		display: inline-block;
		position: absolute;
		left: 160px;
	}
	#spot-popup{
		width: 200px;
		position: relative;
	}
	#tagbox{
		
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
ArrayList<LocationDTO> list = LocationDAO.getInstance().getLocationVOByUserID(userID);
ArrayList<String> taglist = new ArrayList<>();
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
			<form method="post" action="writeAction" enctype="multipart/form-data">
				<div class="category-sel">
					<select name="boardCategory">
						<option value="0">CATEGORY</option>
						<option value="SPORTS" >SPORTS</option>
						<option value="LEISURE" >LEISURE</option>
						<option value="MUSIC" >MUSIC</option>
						<option value="OTHER" >OTHER</option>
					</select>
					<div class="form-check" style="display: flex; height: 40px; align-items: center;">
						<!-- <input type="checkbox" hidden="hidden" name="notice" value="NULL" checked="checked"> -->
					<!-- 관리자 계정으로 공지사항 체크박스 체크시 value값을 NOTICE로 넘긴다. -->
					<% 
						if(userID.equals("manager")){
					%>
						<input class="form-check-input" type="checkbox" name="notice" value="NOTICE" id="flexCheckDefault">
						<label class="form-check-label" for="flexCheckDefault">
						  공지사항
						</label>
					<%
						}
					%>
					</div>
					<div id="spot-sel">
						<button type="button" id="invite-spot-open" class="btn-blue" value="초대하기" onclick="inviteSpot('open')">
							<span>스팟 초대</span>
						</button>
						<button type="button" id="invite-spot-close" class="btn-blue" value="초대하기" onclick="inviteSpot('close')">
							<span>닫기</span>
						</button>
						<div id="spot-popup" hidden="">
						<div>
							<table>
								<thead>
									<tr class="spot-head">
										<th class="ttt" style="width: 42%;"><span>스팟</span></th>
										<th class="tt" style="width: 45;"><span>주소</span></th>
										<th class="ttt" style="width: 13%;"><span>인원</span></th>
									</tr>
								</thead>
								<% if(list.size() == 0){%>
								<tbody>
									<tr>
										<td colspan="3" class="none-list">생성한 스팟이 없습니다.</td>
									</tr>
								</tbody>
								<%}else{ %>
								<tbody>
								<% 
									for(LocationDTO i : list){
								%>
									<tr class="spot-row">
										<td><input type="checkbox" id="tagbox" name="tag" onclick="getCheckboxValue()" value="<%=i.getSpotName()%>"><%=i.getSpotName()%></td>
										<td><%=i.getAddress()%></td>
										<td><%=i.getCrewCount()%>명</td>
									</tr>
								<%} %>
								</tbody>
								<%} %>
							</table>
						</div>
						</div>
					</div>
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
							<td><textarea placeholder="내용을 입력하세요" name="boardContent" maxlength="2048" style="height: 350px; "></textarea></td>
						</tr>
						<tr>
						<td id="result-td">
							<div id="result"></div>
						</td>
						</tr>
					</tbody>
				</table>
				<div id="write-bottom">
					<div id="file">
						<span id="txt">파일첨부 :</span>&nbsp;&nbsp;
						<label for="fileupload" id="click" class="btn-blue">click !</label>&nbsp;&nbsp;
						<div id="filename"></div>
						<input type="file" id="fileupload" name="fileupload" onchange="filename(this)" >
					</div>
					<div id="btn">
						<button type="submit" class="btn-blue" value="글쓰기" onclick="submitTag()">
						<span>작성하기</span>
						</button>
					</div>
				</div>
			</form>		
		</div>
	</div>
</section>
<script>
/*//체크박스 한가지만 선택되도록 하기
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
});*/
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

function filename(input){
	var file = input.files[0];	//선택된 파일 가져오기
    //미리 만들어 놓은 div에 text(파일 이름) 추가
    var name = document.getElementById('filename');
    name.textContent = file.name;
}

function inviteSpot(value){
	console.log(value);
	if(value === 'open'){
		document.getElementById('spot-popup').style.display = 'block';
		document.getElementById('invite-spot-open').style.display = 'none';
		document.getElementById('invite-spot-close').style.display = 'block';
	}else{
		document.getElementById('spot-popup').style.display = 'none';
		document.getElementById('invite-spot-open').style.display = 'block';
		document.getElementById('invite-spot-close').style.display = 'none';

	}
}
let valuesArray = [];

//선택한 스팟 값 가져오기
function getCheckboxValue(){
	  // 선택된 목록 가져오기
	  const query = 'input[name="tag"]:checked';
	  const selectedEls = document.querySelectorAll(query);

	  const resultName = 'result';
	  
//	  if(valuesArray.length % 4 === 0){
//		  line++;
//		  const newline = document.createElement('div');
//		  resultName = 'result'+line;
//		  newline.setAttribute('id', resultName);
//	  }
	  document.getElementById(resultName).innerHTML = '';
	  selectedEls.forEach((el) => {
		    const div = document.createElement('div');
		    div.classList.add('sel-result');
		    div.setAttribute('name', 'sel-tag');
		    div.textContent = el.value;
		    document.getElementById(resultName).appendChild(div);
			valuesArray.push(el.value);
	});
	    updateValuesArray();
	    console.log(valuesArray.length);
		  console.log(valuesArray);
}
function updateValuesArray() {
    valuesArray = []; // Clear the valuesArray
    const selectedCheckboxes = document.querySelectorAll('input[name="tag"]:checked');
    selectedCheckboxes.forEach((checkbox) => {
        valuesArray.push(checkbox.value); // Add value to the array
    });
}
function storeValues() {
	const elements = document.querySelectorAll('.sel-result');
	elements.forEach((element) => {
	  const value = element.textContent.trim();
	  valuesArray.push(value);
	});
}
function submitTag(){
	document.getElementById('tag').innerHTML = valuesArray;
}
</script>
	<!-- 부트스트랩 참조 영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>