<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="user.userDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>My Home</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	int reslut = 0;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;
		}
	if(request.getParameter("userID") == null || request.getParameter("userPassword") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		userDAO userDAO = new userDAO();
		int result = userDAO.login(request.getParameter("userID"), request.getParameter("userPassword"));
			if(result == 1){
				session.setAttribute("userID", request.getParameter("userID"));
				//request.setAttribute("user", request.getParameter("userID"));
				response.sendRedirect("index.jsp");
				//request.getRequestDispatcher("index.jsp").forward(request, response);
			}else if(result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 다시 확인하여주세요.');");
				script.println("history.back();");
				script.println("</script>");
			}else if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디입니다.');");
				script.println("history.back();");
				script.println("</script>");
			}else if(result == -2){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류입니다.');");
				script.println("history.back();");
				script.println("</script>");
			}
	}
	
%>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>