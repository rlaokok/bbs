<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="bbs.bbsDTO" %>
<%@ page import="bbs.bbsDAO" %>
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
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
 	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요.');");
		script.println("location.href='login.jsp';");
		script.println("</script>");
	} 
 	if(request.getParameter("bbsTitle")==null ||request.getParameter("bbsContent")==null ){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력 안 된 사항이 있습니다.');");
 		script.println("history.back();");
 		script.println("</script>");
 	}else{
 		bbsDAO bbsDAO = new bbsDAO();
 		int result = bbsDAO.write(userID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
 		if(result == 1){
 			PrintWriter script = response.getWriter();
 	 		script.println("<script>");
 	 		script.println("location.href='bbs.jsp';");
 	 		script.println("</script>");
 		}else{
 			PrintWriter script = response.getWriter();
 	 		script.println("<script>");
 	 		script.println("alert('데이터베이스 오류입니다.');");
 	 		script.println("history.back();");
 	 		script.println("</script>");
 		}
 	}
	
	
%>
	<%=request.getParameter("bbsTitle") %>
	<%=request.getParameter("userID") %>
	<%=request.getParameter("bbsContent") %>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>