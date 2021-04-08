<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>멤버 리스트 화면</title>
</head>
<style>
</style>
<body>	

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String masterID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		if(userID.equals("admin")){
			masterID = userID;
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
		
	
%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">HOME</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Python<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="http://rlaokok.iptime.org:5000/selenium">웹 크롤링</a></li>
						<li><a href="http://rlaokok.iptime.org:5000/canvas">딥 러닝(손글씨)</a></li>
						<li><a href="http://rlaokok.iptime.org:5000/r_learning">딥 러닝(게임)</a></li>
					</ul>
				</li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else if (userID.equals("admin")) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="memberList.jsp">관리회원</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div id="container_70pro">
			<br>
			<div style="text-align: center; font-size: 1.5em;">
				<b>게시판</b>
			</div>
			<%
				userDAO user = new userDAO();
				String userCnt = user.cnt();
			%>
			<br> <span>전체 <%=userCnt%>건
			</span>
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope="col" class="table-num" style="width:10%; text-align: center;">아이디</th>
						<th scope="col" class="table-title" style="text-align: center;">이름</th>
						<th scope="col" class="table-userID" style="width: 10%; text-align: center;">성별</th>
						<th scope="col" class="table-date" style="width: 20%; text-align: center;">이메일</th>
						<th scope="col" class="table-date" style="width: 20%; text-align: center;">삭제</th>
					</tr>
				</thead>
				<%
					userDAO userDAO = new userDAO();
					ArrayList<userDTO> list = userDAO.getList();
				for (int i = 0; i < list.size(); i++) {
				%>
				<tbody>
					<tr>
						<th scope="row" class="table-num" style="width: 10%; text-align: center;"><%=list.get(i).getUserID() %></th>
						<td style="width: 20%; text-align: center;"><%=list.get(i).getName() %></td>
						<td style="width: 10%; text-align: center;"><%=list.get(i).getGender() %></td>
						<td style="width: 30%; text-align: center;"><%=list.get(i).getEmail() %></td>
						<td style="width: 30%; text-align: center;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="memberDeleteAction.jsp?memberID=<%=list.get(i).getUserID() %>">삭제</a></td>
					</tr>

				</tbody>
				<%
					}
				%>
			</table>
		</div>
	</div>
	
</body>
</html>