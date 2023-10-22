<%@page import="group.GroupDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="member.MemberDTO" scope="page" />
<jsp:setProperty name="member" property="memberID" />
<jsp:setProperty name="member" property="mbContent" />
<jsp:setProperty name="member" property="mbAvailable" />
<!DOCTYPE html>
<html>
<body>
	<%
		PrintWriter script = response.getWriter();
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
			script.println("</script>");
		}else{
			int groupID = 0; 
		 	if (request.getParameter("groupID") != null){
		 		groupID = Integer.parseInt(request.getParameter("groupID"));
		 	}
		 	if (groupID == 0){
		 		script.println("<script>");
		 		script.println("alert('유효하지 않은 그룹입니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
			if(member.getMemberID() == null || member.getMbContent() == null) {
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			GroupDAO groupDAO = new GroupDAO();
			MemberDAO memberDAO = new MemberDAO();
			//가입시 비밀번호 알려주기위해 해당 그룹의 비밀번호를 가져온다.
			String pw = groupDAO.getGroupVO(groupID).getGroupPassword();
			//해당group을 만든 userID와 가입하려는 userID가 같으면 가입할 수 없도록 한다.
			if(userID.equals(groupDAO.getGroupVO(groupID).getUserID())){
				script.println("<script>");
				script.println("alert('유효한 가입 대상이 아닙니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				//groupID에 해당되는 member의 수가 groupNoP(정원)보다 같거나 크면 정원이 다 찼다는 알림을 띄운다.
				//ArrayList<MemberDTO> mblist = memberDAO.getList(groupID);
				//if(mblist.size() >= groupDAO.getGroupVO(groupID).getGroupNoP()){
				//	PrintWriter script = response.getWriter();
				//	script.println("<script>");
				//	script.println("alert('정원이 다 찼습니다.')");
				//	script.println("history.back()");
				//	script.println("</script>");	
				//}else{
					//memberDAO에 userID와 groupID가 둘다 일치하는 데이터가 있으면 해당그룹에 이미 가입 되어있는것
					if(memberDAO.getMemberVO(userID, groupID) != null){
						//데이터가 있지만 available값이 0이면 탈퇴한 회원
						if(memberDAO.getMemberVO(userID, groupID).getMbAvailable() == 0){
							script.println("<script>");
							script.println("alert('탈퇴한 회원은 재가입이 불가능합니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
						//else if(memberDAO.getMemberVO(userID, groupID).getMbAvailable() == 1){
						//0이 아니면 이미 가입되어있는 회원
						//PrintWriter script = response.getWriter();
						//script.println("<script>");
						//script.println("alert('이미 가입 되어있습니다.')");
						//script.println("history.back()");
						//script.println("</script>");
						//}
					}else{
						int result = memberDAO.join(member.getMemberID(), groupID, userID, member.getMbContent());
						if(result == -1){ //데이터베이스 오류
							script.println("<script>");
							script.println("alert('이미 사용중인 ID입니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
						else {
							script.println("<script>");
							script.println("alert('가입이 완료되었습니다. 비밀번호는" + pw + "입니다')");
							script.println("location.href = 'groupPage'");
							script.println("</script>");
						}
					}
				}
			}
//		}
		
	%>
</body>
</html>