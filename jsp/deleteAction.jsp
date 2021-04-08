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
			script.println("alert('�α��� �� �̿����ּ���.');");
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
			script.println("alert('�������� ���� ���Դϴ�.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		if(userID.equals("admin")){
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.delete(bbsNum);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�� ������ �����߽��ϴ�.')");
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
			script.println("alert('������ �����ϴ�.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}else{
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.delete(bbsNum);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�� ������ �����߽��ϴ�.')");
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