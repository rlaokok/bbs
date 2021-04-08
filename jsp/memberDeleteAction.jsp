<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해주세요.');");
		script.println("history.back();");
		script.println("</script>");
	}
	if (!userID.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자 권한만 가능합니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
	}

	String memberID = null;
	if (request.getParameter("memberID") != null) {
		memberID = request.getParameter("memberID");
	}
	if (memberID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제할 회원이 없습니다.');");
		script.println("history.back();");
		script.println("</script>");
	} else {
		userDAO userDAO = new userDAO();
		int result = userDAO.deleteMember(memberID);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류 입니다.');");
			script.println("history.back();");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='memberList.jsp';");
			script.println("</script>");
		}
	}
	%>
</body>
</html>