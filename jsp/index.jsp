<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>My Home</title>
</head>
<body>	
<%
request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	String memberID = null;
	if (request.getParameter("memberID") != null) {
		memberID = request.getParameter("memberID");
	}
%>
	<script>
		location.href="main.jsp";
	</script>
</body>
</html>