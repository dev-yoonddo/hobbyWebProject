<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@500&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>


<style>

.select {
  position: relative;
  width: 400px;
}


.select .option-list {
  position: absolute;
  top: 100%;
  left: 0;
  width: 100%;
  overflow: hidden;
  max-height: 0;
}

.select.active .option-list {
  max-height: none;
}

/* 테마 적용하기 */
#select-sec {
	width: 450px;
	height: 50px;
	font-size: 13pt;
	font-weight: bold;
	color: #6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
	display: flex;
}
#select-sec .select {
  box-shadow: 0 0 10px #86A5FF;
  border-radius: 15px;
  padding: 15px;
  cursor: pointer;
}

#select-sec .select .text {
font-size: 13pt;
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
  box-shadow: 0 0 10px #86A5FF;
}
#select-sec .select .option-list .option {
  padding: 15px;
}
#select-sec .select .option-list .option:hover {
border-radius: 15px;
background-color: #E0EBFF;
}
button{
	border: 0;
	outline: 0;
	width: 60px;
	height: 50px;
	border-radius: 15px;
	border-color: #86A5FF;
	background-color: #E0EBFF;
	margin-left: 10px;
	box-shadow: 0 0 10px #86A5FF;
	cursor: pointer;
}
#sc{
	font-size: 13pt;
	font-weight: bold;
	color: 6e6e6e;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

<body>
	<form method="post" id ="searchField2" name="searchField2" action="searchPage.jsp">
	<div id="select-sec">
	  <div class="select">
	    <div class="text">
	    <input type="hidden" name="searchField2">
	    <span>함께 하고싶은 취미를 선택하세요 !</span>
	    </div>
	    <ul class="option-list">
	      <li class="option"><input type="hidden" name="searchField2" id="SPORTS" value="SPORTS"><span>SPORTS</span></li>
	      <li class="option"><input type="hidden" name="searchField2" id="LEISURE" value="LEISURE"><span>LEISURE</span></li>
	      <li class="option"><input type="hidden" name="searchField2" id="ART&MUSIC" value="ART&MUSIC"><span>ART & MUSIC</span></li>
	      <li class="option"><input type="hidden" name="searchField2" id="OTHER" value="OTHER"><span>OTHER</span></li>
	    </ul>
	  </div>
	  <div id="submit-btn">
	  <button type="submit"><span id="sc">검색</span></button>
	  </div>
	</div>
  </form>

<script>
var speed=500 

function flashit(){ 
	var flash=document.getElementById? document.getElementById("sc") : document.all? document.all.myexample : "" 
	if (flash){ 
		if (flash.style.color.indexOf("rgb(255, 255, 255)")!=-1) 
			flash.style.color="#6e6e6e" 
		else 
			flash.style.color="rgb(255, 255, 255)" 
	}
} 
setInterval("flashit()", speed);

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
</body>
</html>