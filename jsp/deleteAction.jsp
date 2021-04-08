<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.bbsDTO" %>    
<%@ page import="bbs.bbsDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요.');");
			script.println("history.back();");
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
		if(userID.equals("admin")){
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.delete(bbsNum);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
		bbsDTO bbs = new bbsDAO().getBbs(bbsNum);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}else{
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.delete(bbsNum);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
				
		}
	%>
</body>
</html>