<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "bbs.bbsDAO" %>   
<%@ page import = "bbs.bbsDTO" %>   
<%@ page import = "java.util.ArrayList" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시글 수정 화면</title>
</head>
<style>
</style>
<body>	

<%
		String userID = null;
		int bbsNum = 0;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(request.getParameter("bbsNum")!=null){
			bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요.');");
			script.println("history.back();");
			script.println("</script>");
		}
		
		bbsDTO bbs = new bbsDAO().getBbs(bbsNum);
	%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">HOME</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
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
				if(userID == null){
				
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}else if(userID.equals("admin")){
				
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="memberList.jsp">관리회원</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
            <div id="container_70pro">
              <br>
              <div style="background-color: #F8F9FA; text-align: center;"><b>게시글 작성</b></div><br>
              <form action="updateAction.jsp?bbsNum=<%=bbsNum %>" method="post">
                <table>
                  <tr class="tr">
                    <th style="width: 20%;">제목</th>
                    <td style="width: 80%;"><input style="width: 100%;" type="text" name="bbsTitle" value="<%=bbs.getBbsTitle() %>"></td>
                  </tr>
                  <tr class="tr">
                    <th style="width: 20%;">작성자</th>
                    <td style="width: 80%;"><input style="width: 100%;" type="text" value="<%=bbs.getUserID() %>" name="userID" readonly ></td>
                  </tr>
                  <tr class="tr" style="height: 330px;">
                    <th style="width: 20%;">내용</th>
                    <td style="width: 80%;"><textarea style="width: 100%; height: 300px" type="text" name="bbsContent"><%=bbs.getBbsContent() %></textarea></td>
                  </tr>
                  <input type="hidden" name="bbsCount" value="<%=bbs.getBbsCount() %>">
                </table>
                <br>
                <button type="submit" class="btn btn-dark" id="btn-write">수정</button>
                </form>
            </div>
          </div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>