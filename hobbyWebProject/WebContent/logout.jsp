<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<body>
<%
session.invalidate(); // 세션 초기화
%>
<script>
location.href='mainPage';
</script>
</body>
</html>