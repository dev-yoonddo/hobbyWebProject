<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="schedule.ScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="location.LocationDTO"%>
<%@page import="location.LocationDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="crew.CrewDTO"%>
<%@page import="crew.CrewDAO"%>
<%@page import="calendar.MyCalendar"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>SPOT CREW</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/calendar.css">
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
	padding-top: 70px;
	height: 900px;
	display: flex;
	justify-content: center;
}
.spot-container{
	width: auto;
	margin: 0 auto;
}
#spot-title{
	height: 70px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20pt;
	font-weight: 400;
	color: #505050;
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    animation: fadeInLeft 2s;
}
#spot-title h4 {
	margin-left: 30px;
}
@keyframes fadeInLeft {
    0% {
        opacity: 0;
        transform: translate3d(-100%, 0, 0);
    }
    to {
        opacity: 1;
        transform: translateZ(0);
    }
}
#btn-next{
	align-items: center;
}
#btn-next span{
	width: 70px;
	height: 25px;
	padding: 5px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 12pt;
}
#wrapBtns{
	width: 400px;
	display: flex;
}
#putSked, #checkSked{
	width: 200px;
	height: 35px;
}
#putSked > span , #checkSked > span{
	color: #2E2F49;
	background-color: #ffffff;
	border: 1px solid #ffffff;
}
#putSked::before , #checkSked::before{
	background-color: #ffffff;
}
#putSked > span:hover , #checkSked > span:hover{
	color: #ffffff;
	background-color: #2E2F49;
	border: 1px solid #2E2F49;
}
.btn-blue{
	float: none;
	display: flex;
	justify-content: center;
	margin: 0 auto;	 
}
.btn-blue span{
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
	background-color: #ffffff;
}
</style>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID = null;
	String spotName = null;
	String accessSpotName = null;
	int skedMonth = 0;
	int Tabledata = 0;
	CrewDAO crewDAO = new CrewDAO();
	LocationDAO locDAO = new LocationDAO();
	ScheduleDAO skedDAO = new ScheduleDAO();
	
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(request.getParameter("spotname") != null){
		spotName = request.getParameter("spotname");
	}
	if(request.getParameter("spot") != null){
		accessSpotName = request.getParameter("spot");
	}
	
	//해당 스팟 생성자 구하기
	LocationDTO leader = new LocationDAO().getLocationVO(spotName);
	//크루 테이블에 정보가 저장되었는지 확인
	CrewDTO crew = new CrewDAO().getCheckRegist(userID, spotName);
	//저장된 스케줄 리스트 가져오기
	ArrayList<ScheduleDTO> list = skedDAO.getScheduleListBySpot(spotName);
	//Map<String , String> scheduleDates = new HashMap<>();
	
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
		script.println("</script>");

		script.print("null");
        script.flush();
        script.close();
	}else if(accessSpotName == null && spotName != null){ //가입했는지 검사 (spotname 파라미터만 존재)
		if(!userID.equals(leader.getUserID()) && crew == null){ //스팟 생성자도 아니고 참여한 유저도 아니면
			script.print("regist error"); //접속 불가
	        script.flush();
	        script.close();
		}else{
			script.print("access successfully");
	        script.flush();
	        script.close();
		}
	}else{
			Calendar calendar = Calendar.getInstance();
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH) + 1;
				try {
					year = Integer.parseInt(request.getParameter("year"));
					month = Integer.parseInt(request.getParameter("month"));
					if (month >= 13) {
						year++;
						month = 1;
					} else if (month <= 0) {
						year--;
						month = 12;
					}
					
				} catch (NumberFormatException e) {
					
				}
			skedMonth = month;

%>
<!-- header -->
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<!-- header -->

<section>
	<div id="spot-container">
		<div id="spot-title">
			<h3><%=accessSpotName%></h3><h4>크루들과 함께 일정을 계획해보세요</h4>
		</div>
		
		<table width="700" align="center" border="1">
			<tr>
				<th>
					<button type="button" id="btn-next" class="btn-blue" onclick="location.href='?spot=<%=accessSpotName%>&year=<%=year%>&month=<%=month - 1%>'"><span><%=month - 1%>월</span></button>
				</th>
				<th id="title" colspan="5">
					<%=year%>년 <%=month%>월
				</th>
				<th>
					<button type="button" id="btn-next" class="btn-blue" onclick="location.href='?spot=<%=accessSpotName%>&year=<%=year%>&month=<%=month + 1%>'"><span><%=month + 1%>월</span></button>
				</th>
			</tr>
			
			<tr>
				<td id="sunday">일</td>
				<td class="etcday">월</td>
				<td class="etcday">화</td>
				<td class="etcday">수</td>
				<td class="etcday">목</td>
				<td class="etcday">금</td>
				<td id="saturday">토</td>
			</tr>
		
			<tr>
		<%
			int week = MyCalendar.weekDay(year, month, 1);
			int start = 0;
			int value = 0;
			if (month == 1) {
				start = 31 - week;
			} else {
				start = MyCalendar.lastDay(year, month - 1) - week;		// 2 ~ 12월
			}
			
			//1일이 첫번째 일요일부터 시작하지 않으면 전 월의 날짜를 출력한다.
			for (int i = 0; i < week; i++) {
				value = (month == 1 ? 12 : month - 1);
				if (i == 0) {
					out.println("<td class='beforesun'>" + value + "/" + ++start + "</td>");
				} else {
					out.println("<td class='before'>" + value + "/" + ++start + "</td>");
				}
			}
		
			for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
				ArrayList<ScheduleDTO> list2 = skedDAO.getScheduleListByTime(accessSpotName, month, i);
				Tabledata = list2.size();
				boolean flag = false;
				String icon = "";
			    /*
				String dateKey = month + "-" + i; // 데이터를 '월-일'로 저장했을 때 사용
			    boolean hasSchedule = false;
				for(int a=0; a < list.size(); a++){
			        if (list.get(a).getSkedMonth() == month && list.get(a).getSkedDay() == i) {
			            hasSchedule = true;
			            icon = "<img src='/image/bell-solid.png' alt='bell'>";
			        }
				}
			    */
			    //해당 스팟의 스케줄 데이터 중 일치하는 값이 있으면 아이콘을 넣어준다.
				if(list2.size() > 0){
		            icon = "<img src='./image/bell-small.png' class='bell'>"; // Add the icon for the date
				}
			    //어린이날 대체공휴일 계산
				int child = 0;
				if (MyCalendar.weekDay(year, 5, 5) == 7) {
					flag = true;
					child = 7;
				} else if (MyCalendar.weekDay(year, 5, 5) == 0) {
					flag = true;
					child = 6;
				}
				if (month == 1 && i == 1) {
					//out.println("<td class='holiday' value='"+ i +"' onclick='printValue(this)'>" + i + "<span>신정</span><br>"+ icon +"</td>");
					//똑같은 코드를 적지않고 MyCalendar 클래스에 값을 넘겨줘 코드를 간단하게 만든다.
					//공휴일이면 notHoli == null로 넘겨주고 공휴일이 아니면 holi == null로 넘겨준다.
					out.println(MyCalendar.printDay(i, "신정", null, icon));
				} else if (month == 3 && i == 1) {
					out.println(MyCalendar.printDay(i, "삼일절", null, icon));
				} else if (month == 5 && i == 1) {
					out.println(MyCalendar.printDay(i, "근로자의날", null, icon));
				} else if (month == 5 && i == 5) {
					out.println(MyCalendar.printDay(i, "어린이날", null, icon));
				} else if (month == 6 && i == 6) {
					out.println(MyCalendar.printDay(i, "현충일", null, icon));
				} else if (month == 8 && i == 15) {
					out.println(MyCalendar.printDay(i, "광복절", null, icon));
				} else if (month == 10 && i == 3) {
					out.println(MyCalendar.printDay(i, "개천절", null, icon));
				} else if (month == 10 && i == 9) {
					out.println(MyCalendar.printDay(i, "한글날", null, icon));
				} else if (month == 12 && i == 25) {
					out.println(MyCalendar.printDay(i, "크리스마스", null, icon));
				} else if (flag && month == 5 && i == child) {
					out.println(MyCalendar.printDay(i, "어린이날<br>대체공휴일", null, icon));
				} else {
					switch (MyCalendar.weekDay(year, month, i)) {
						case 0:
							out.println(MyCalendar.printDay(i, null, "sun", icon));
							break;
						case 6:
							out.println(MyCalendar.printDay(i, null, "sat", icon));
							break;
						default:
							out.println(MyCalendar.printDay(i, null, "etc", icon));
					}
				}
		
				if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
					out.println("</tr><tr>");
				}
				
			    //--------
			}
		
			if (month == 12) {
				week = MyCalendar.weekDay(year + 1, 1, 1);
			} else {
				week = MyCalendar.weekDay(year, month + 1, 1);
			}
			
			//마지막날짜가 맨 마지막 토요일로 끝나지 않으면 다음달의 날짜를 출력한다.
			if (week != 0) {
				start = 0;
				for (int i = week; i <= 6; i++) {
					if (i == 6) {
						out.println("<td class='aftersat'><span class='after-txt'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</span></td>");
					} else {
						out.println("<td class='after'><span class='after-txt'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</span></td>");
					}
				}
			}
			
		%>
			</tr>
		
			<tr>
				<td colspan="7" id="select-month">
					<form action="?spot=<%=accessSpotName %>" method="post" style="display: flex; justify-content: center;">
						<div class="select">
							<!-- 올해 달력만 출력 -->
							<select class="select" disabled="disabled" name="year">
							<%	/*int nowYear = calendar.get(Calendar.YEAR);
								for (int i = nowYear; i <= nowYear+5; i++) { //현재부터 5년후의 달력만 보여준다. (년도 범위 선택 가능)
									if (i == year) {//달력의 년과 일치하는 옵션을 선택되도록 한다.
										out.println("<option selected='selected'>" + i + "</option>");
									} else {
										out.println("<option>" + i + "</option>");
									}
								}*/
							%>
								<option selected="selected"><%= year %></option>
							</select>&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;
						</div>
						
						<div class="select">
							<select class="select" name="month">
							<%
								for (int i = 1; i <= 12; i++) {
									if (i == month) { //달력의 달과 일치하는 옵션을 선택되도록 한다.
										out.println("<option selected='selected'>" + i + "</option>");
									} else {
										out.println("<option>" + i + "</option>");
									}
								}
							%>
							</select>&nbsp;&nbsp;월&nbsp;&nbsp;
						</div>
						<div class="select">
							<button class="btn-blue" type="submit" id="btn-next"><span>보기</span></button>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<div id="" class="clickWrap" style="display: none;">
		<div id="wrapInner">
			<div id="wrapBtns">
				<button type="button" class="btn-blue" id="putSked"><span>스케줄 등록</span></button>
				<button type="button" class="btn-blue" id="checkSked"><span>스케줄 확인</span></button>
			</div>
		</div>
	</div>
</section>

<% 
}
%>

<script>

/*지점에서 상세보기 버튼을 클릭했을 때 정보를 보여주는 팝업창 띄우기
var target = document.querySelectorAll('.openInfo');
var btnPopClose = document.querySelectorAll('.pop_wrap .btn-black');
var targetID;

// 팝업 열기
for(var i = 0; i < target.length; i++){
  target[i].addEventListener('click', function(){
	  console.log(i);
   // console.log(target[i].value);
	  //var id = target[i].value;
	  //document.getElementById(id).style.display = 'block';
    document.querySelector('.clickWrap').style.display = 'block'
  });
}*/

function printValue(e) { //클릭한 날짜를 받아 팝업창에 전달
	document.querySelector('.clickWrap').style.display = 'block';
	
	var put = document.getElementById('putSked');
	var check = document.getElementById('checkSked');
	var wrap = document.querySelector('.clickWrap');
	
	//스케줄 등록하기 클릭
	put.addEventListener('click', function(){	
		var spot = "<%=accessSpotName%>";
		var month = "<%=skedMonth%>";
		var value = e.getAttribute('value');
		var a = "a";
	
		console.log('Clicked value: ' + value);
	
		var data = {
	        spot: spot,
	        month: month,
	        day: value,
	    };
	    $.ajax({
	        type: 'POST',
	        //url: 'https://toogether.me/spotAccess',
	        url: 'scheduleRegistPopUp',
	        data: data,
	        success: function (response) {
	        	if (response.includes("null")) {
	        		alert("로그인 후 다시 시도해주세요.");
	     			window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	        	}else if(response.includes("info error")){
	        		alert('정보 오류');
	        	}else{
					window.open('scheduleRegistPopUp?spot='+spot+'&month='+month+'&day='+value+'&a='+a, 'SCHEDULE', 'width=450, height=500, top=50%, left=50%');
	        	}
	        },
	     error: function (xhr, status, error) {
	         //console.error('Spot registration error:', error);
	         alert('오류');
	     }
	    });
	});
	
	//스케줄 확인하기 클릭
	check.addEventListener('click', function(){
		alert('시스템 준비중입니다');
	}
	//팝업을 클릭하면 팝업 없애기
	wrap.addEventListener('click', function(){
		wrap.style.display = 'none';
	})
	
}
</script>
</body>
</html>