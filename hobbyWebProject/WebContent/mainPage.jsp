<%@page import="group.GroupDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="event.EventDTO"%>
<%@page import="event.EventDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDAO"%>
<%@page import="user.PwEncrypt"%>
<%@page import="com.toogether.session.SqlConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css" />
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
#updateicon {
	margin-top: 15px;
}
</style>
<body>
	<%
		PrintWriter script = response.getWriter();
		String userID = null;
		BoardDAO bdDAO = BoardDAO.getInstance();
		EventDAO eventDAO = EventDAO.getInstance();
		GroupDAO groupDAO = GroupDAO.getInstance();
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		//작성한 게시글이 5개 이상이고 운영중인 그룹이 있을때 이벤트에 응모할 수 있는 팝업창이 뜨도록 한다.
		//이벤트에 응모는 아이디당 한번씩만 가능하다.
		int boardCount = bdDAO.getListByUser(userID).size(); //유저가 작성한 게시글 수 가져오기
		int groupCount = groupDAO.getListActiveByUser(userID).size(); //유저가 생성한 그룹 중 활동중인 그룹 수 가져오기
		int eventCount = eventDAO.getListByUser(userID).size(); //이벤트 응모 기록 가져오기
		if (boardCount >= 5 && groupCount > 0 && eventCount == 0) { //게시글이 5개 이상이고 이벤트 응모 기록이 없으면 팝업창 띄우기
			script.println("<script>");
			script.println("window.open('eventPopUp', 'EVENT', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}
		//유저의 이벤트 정보 가져오기
		//eventWin == 1이면 이벤트에 당첨된것을 의미한다.
		EventDTO eventvo = eventDAO.getEventVO(userID);
		if (eventvo != null && eventvo.getEventWin() == 1 && eventvo.getEventAvailable() != 0) {
			script.println("<script>");
			script.println("window.open('eventWinPopUp', 'EVENT', 'width=500, height=500, top=50%, left=50%')");
			script.println("</script>");
		}
	%>
	<header>
		<!-- header : param 태그를 주석을 넣으면 오류가 생긴다.-->
		<jsp:include page="/header/header.jsp" />
	</header>
	<!-- header -->

	<!-- section -->
	<section>
		<div class="main">
			<div class="main-text">
				<div id="m1">
					<i class="fa-regular fa-lightbulb fa-2x"
						style="padding-bottom: 20px;"></i><br> 취미활동도 같이하고<br>지원금도 받고싶다면?
					<hr id="line">
				</div>
				<%
					if (userID == null) {
				%>
				<div id="m2" onclick="location.href='join'">TOGETHER 회원가입</div>
				<%
					} else {
				%>
				<div id="m2" onclick="location.href='write'">글 작성하기</div>
				<%
					}
				%>
			</div>
			<!-- 위/아래 이동버튼 -->
			<div class="move_btns">
				<div class="moveTop">
					<i class="fa-solid fa-circle-arrow-up fa-2x"></i>
				</div>
				<div class="moveBottom">
					<i class="fa-solid fa-circle-arrow-down fa-2x"></i>
				</div>
			</div>
		</div>

		<!-- 메인 슬라이드 -->
		<div class="container-slide">
			<div id="slide-main">
				<div id="slide-in">
					<div id="content">
						<!--       Slide One -->
						<div class="slide showing">
							<img src="./image/sports.png">
							<div class="details">
								<h2>SPORTS</h2>
								<div class="info-item">
									<h2>함께 하러가기</h2>
								</div>
								<form method="post" action="searchPage">
									<input type="hidden" name="searchField2" value="SPORTS">
									<div class="btn">
										<button type="submit">TOGETHER</button>
									</div>
								</form>
							</div>
						</div>
						<!--       Slide One -->
						<!--       Slide Two -->
						<div class="slide">
							<img src="./image/surfing.png">
							<div class="details">
								<h2>LEISURE SPORTS</h2>
								<div class="info-item">
									<h2>함께 하러가기</h2>
								</div>
								<form method="post" action="searchPage">
									<input type="hidden" name="searchField2" value="LEISURE">
									<div class="btn">
										<button type="submit">TOGETHER</button>
									</div>
								</form>
							</div>
						</div>
						<!--       Slide Two -->
						<!--       Slide Three -->
						<div class="slide">
							<img src="./image/music.png">
							<div class="details">
								<h2>MUSIC</h2>
								<div class="info-item">
									<h2>함께 하러가기</h2>
								</div>
								<form method="post" action="searchPage">
									<input type="hidden" name="searchField2" value="MUSIC">
									<div class="btn">
										<button type="submit">TOGETHER</button>
									</div>
								</form>
							</div>
						</div>
						<!--       Slide Three -->
						<!--       Slide Four -->
						<div class="slide">
							<img src="./image/other.png">
							<div class="details">
								<h2>OTHER</h2>
								<div class="info-item">
									<h2>함께 하러가기</h2>
								</div>
								<form method="post" action="searchPage">
									<input type="hidden" name="searchField2" value="OTHER">
									<div class="btn">
										<button type="submit">TOGETHER</button>
									</div>
								</form>
							</div>
						</div>
						<!--       Slide Four -->
					</div>
					<!--     Swap Btns -->
					<div class="arrowBtn">
						<i class="fa-solid fa-arrow-left"></i>
					</div>
					<div class="arrowBtn">
						<i class="fa-solid fa-arrow-right"></i>
					</div>
					<!--     Swap Btns -->

				</div>
			</div>
		</div>
	
		<div class="container-banner">
			<div id="animatedBackground"></div>
		</div>

	</section>
	<!-- section -->

	<!-- footer -->
	<footer>
		<hr>
		<div class="inform">
			<ul>
				<li>06223 서울특별시 강남구 역삼로1004길 (역삼동, 대박타워) ㈜TOGETHER 대표이사 : 정윤서 |
					사업자 등록번호: 222-22-22222｜통신판매업신고: 강남 1004호</li>
				<li>｜개인정보 보호책임자 : 정윤서 | 문의 : Webmaster@TOGETHER.co.kr |
					Copyright ⓒ TOGETHER. All rights reserved.</li>
				<li>㈜투게더의 사전 서면동의 없이 사이트(PC, 모바일)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로
					전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</liz>
			</ul>
		</div>
	</footer>
	<!-- footer -->
	<script>
		opener.location.reload(); //부모창 리프레쉬
		self.close(); //로그인 후 팝업창이 닫힌다.
	</script>
</body>
</html>