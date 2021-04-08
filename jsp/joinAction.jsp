<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<!-- SQL에 한글을 위한 작업 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.userDTO" scope="page" /> <!-- userDTO user = new userDTO(); -->
<jsp:setProperty name="user" property="userID" /> <!-- user.setName("userID"); -->
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="name" />
<jsp:setProperty name="user" property="gender" />
<jsp:setProperty name="user" property="email" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>My Home</title>
</head>
<body>	
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 된 상태입니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
	}
	if(request.getParameter("userID") == null || request.getParameter("userPassword") == null || 
			request.getParameter("name")== null || request.getParameter("gender") == null || 
					request.getParameter("email") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
	}else{
		userDAO userDAO = new userDAO();
		int result = userDAO.join(user);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입을 축하합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
	}
	
%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>