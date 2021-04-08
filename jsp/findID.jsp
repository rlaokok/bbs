<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<title>아이디 찾기 화면</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">


</head>
<%
request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 된 상태입니다.');");
		script.println("location.herf='index.jsp'");
		script.println("</script>");
	}
%>
<body>
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
              <div style="text-align: center; font-size: 1.5em;"><b>아이디 찾기</b></div><br>
                    <form action="findIDAction.jsp" method="post">
                        <div class="form-floating mb-3">
                        	<p>회원가입시 등록하신 이름 혹은 이메일을 선택하여 입력해주세요.</p>
                        	<input type="radio" id="radio1" value="이름" name="findIDRadio" checked>&nbsp;&nbsp;&nbsp;이름&nbsp;&nbsp;|&nbsp;&nbsp;
                        	<input type="radio" id="radio2" value="이메일" name="findIDRadio">&nbsp;&nbsp;&nbsp;이메일
                            <input type="text" class="form-control" id="textInput" placeholder="이름으로 검색" name="findIDOrEmail">
                        </div>
                        <br>
                        <div class="d-grid gap-2">
                            <button class="btn btn-dark" id="findBtn" type="submit" style="width:100%"
                            onclick="nameOrEmail()">아이디 찾기</button>
                        </div>
                        <br>
                        <br>
                        <a href="main.jsp"><p class="text-dark">메인으로 가기</p></a>
                    </form>
            </div>
        </div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	<script>
	    /* $('#emailInput').attr("readonly", true); */
	    $("#radio1").click(function(){
	    	$('#textInput').prop("type", "text");
	    	$('#textInput').prop("placeholder", "이름으로 검색");
	    	/* $('#emailInput').val(null);
	        $('#emailInput').attr("readonly", true);
	        $('#nameInput').attr("readonly", false); */
	    });
	    $("#radio2").click(function(){
	    	$('#textInput').prop("type", "email");
	    	$('#textInput').prop("placeholder", "이메일로 검색");
	    	/* $('#nameInput').val(null);
	        $('#nameInput').attr("readonly", true);
	        $('#emailInput').attr("readonly", false); */
	    });
	</script>
	
</body>
</html>
