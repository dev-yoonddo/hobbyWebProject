<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.mail.*"%>
<%@page import="user.Gmail"%>
<%@page import="java.util.Properties"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="user.PwEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userBirth" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userEmail" />
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
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>
<style>
body{
	height: auto;
}
section{
	padding-top: 200px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.btn-blue {
	width: 150px;
}
</style>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		boolean emailSent = false;
		Object emailSentFlag = session.getAttribute("emailSentFlag");

		//처음 창을 열었을 때 emailSentFlag == null이기 때문에 emailSentFlag = true가 저장되고
		//emailSent는 그대로 false이기 때문에 메일이 전송된다.
		//하지만 새로고침시 emailSendFlag != null 이기 때문에 emailSent = true로 변경돼 메일이 전송되지 않는다.
		if (emailSentFlag != null && (boolean) emailSentFlag) {
		    emailSent = true;
		} else {
		    // Set the flag in the session to prevent resending on refresh
		    session.setAttribute("emailSentFlag", true);
		}
		boolean emailChecked = userDAO.getUserEmailChecked(userID);
		if(!emailSent){
			if(userID == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인이 필요합니다')");
				script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
				script.println("</script>");
			}else{
				if(emailChecked == true){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 인증이 된 회원입니다')");
					script.println("location.href='mainPage");
					script.println("</script>");
				}else{
					String id = "check";
					String host = "https://toogether.me/";
					String from = "o0o7o2o0@gmail.com";
					String to = userDAO.getUserEmail(userID);
					String subject = "회원가입을 위한 이메일 인증입니다.";
					String content = "다음 링크에 접속해 이메일 인증을 하세요" +
					"<a href='" + host + "emailCheckAction?code=" + PwEncrypt.encoding(to) + "'>이메일 인증하기</a>";
						
					Properties p = new Properties();
					p.put("mail.smtp.user", from);
					p.put("mail.smtp.host", "smtp.gmail.com");
					p.put("mail.smtp.port", "465");
					p.put("mail.smtp.starttls.enable", "true");
					p.put("mail.smtp.starttls.required", "true");
					p.put("mail.transport.protocol", "smtp");
					p.put("mail.smtp.ssl.enable", "false");
					p.put("mail.smtp.ssl.protocols", "TLSv1.2");
					p.put("mail.smtp.auth", "true");
					p.put("mail.smtp.debug", "true");
					p.put("mail.debug", "true");
					p.put("mail.smtp.socketFactory.port", "465");
					p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					p.put("mail.smtp.socketFactory.fallback", "false");

						//Authenticator auth = new Gmail();
						Session ses = Session.getInstance(p, new Authenticator(){
							protected PasswordAuthentication getPasswordAuthentication(){
								//계속 메일 전송시 오류가 발생했지만 계정을 새로 생성한 뒤에 정상적으로 실행됨
								return new PasswordAuthentication("we.are.together.2023.03@gmail.com","lnwkwnvvxwhippqh");
							}
						});
						ses.setDebug(true);
						MimeMessage msg = new MimeMessage(ses);
						msg.setSubject(subject);
						Address fromAddr = new InternetAddress(from);
						msg.setFrom(fromAddr);
						Address toAddr = new InternetAddress(to);
						msg.addRecipient(Message.RecipientType.TO, toAddr);
						msg.setContent(content, "text/html;charset=UTF8");
						Transport.send(msg);
					
				}
			}
			
		//userDAO.emailSuccessEnd(); //이메일이 한번 전송되면 count + 1을 해서 새로고침해도 이메일이 전송되지 않도록 한다.
		}
		
	%>

<header id="header">
	<jsp:include page="/header/header.jsp"/>
</header>
<section>
	<div id="sendEmail">
		이메일 주소 인증 메일이 발송되었습니다.<br>해당 이메일에 접속해 인증해주세요.
	</div>
	<button type="button" id="success" class="btn-blue" value="인증 완료" onclick="successEmail('<%=emailChecked%>')">
		<span>인증 완료</span>
	</button>

</section>
<script>
function reload(){
	window.location.reload();
}
//emailSendAction 버튼 클릭
function successEmail(sc){
	if(sc == "true"){
		location.href="userUpdate";
	}else{
		alert("이메일 인증이 되지 않았습니다.");
		return false;
	}
}

//30초에 한번씩 페이지 새로고침
setInterval(reload, 30000);
</script>

</body>
</html>