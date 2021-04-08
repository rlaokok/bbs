<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="user.userDTO"%>
<%@ page import="javax.json.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>아이디 찾기 화면</title>
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
	
	String findIDRadio = "이름";
	String findIDOrEmail = null;
	if(!request.getParameter("findIDRadio").equals("이름")){
		findIDRadio = "이메일";
	}
	if(request.getParameter("findIDOrEmail") == ""){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
	}
	if(request.getParameter("findIDOrEmail") != null){
		findIDOrEmail = request.getParameter("findIDOrEmail");
	}
	userDAO userDAO = new userDAO();
	String findID = userDAO.findID(findIDOrEmail);
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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
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
              <div style="text-align: center; font-size: 1.5em;"><b>아이디 찾기</b></div><br>
                    
                        <div class="form-floating mb-3">
                        	<%if(findID != "") {%>
                        		<h3 style="text-align:center;">찾으시는 아이디는 "<%=findID %>" 입니다.</h3>
                        		<br>
                        		<div style="text-align:center; margin:0 auto;">
                        			<a href="login.jsp"><button type="button" class="btn btn-dark">로그인하러 가기</button></a>
                        		</div>
                        		
                        	<%} else {
                        		PrintWriter script = response.getWriter();
                        		script.println("<script>");
                        		script.println("alert('" + findIDRadio + "과(와) 일치하는 정보가 존재하지 않습니다.');");
                        		script.println("history.back();");
                        		script.println("</script>");
                        		}
                        	%>
                        </div>
                        
                        <br>
                        
                        <a href="main.jsp" style="text-align:center;"><p class="text-dark">메인으로 가기</p></a>
                    
            </div>
        </div>
        
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>