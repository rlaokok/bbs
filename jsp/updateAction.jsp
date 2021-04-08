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
 	int bbsNum = 0;
	if(request.getParameter("bbsNum")!=null){
		bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
	}
	if(bbsNum == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유요하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	int bbsCount = 0;
	if(request.getParameter("bbsCount")!= null){
		bbsCount = Integer.parseInt(request.getParameter("bbsCount"));
	}
	
 	if(request.getParameter("bbsTitle")==null ||request.getParameter("bbsContent")==null ){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력 안 된 사항이 있습니다.');");
 		script.println("history.back();");
 		script.println("</script>");
 	}else{
 		bbsDAO bbsDAO = new bbsDAO();
 		int result = bbsDAO.write2(userID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"), bbsCount);
 		if(result == 1){
 			bbsDAO.realDelete(bbsNum);
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

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>