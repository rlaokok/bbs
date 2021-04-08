<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.bbsDAO"%>
<%@ page import="bbs.bbsDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>게시판 화면</title>
</head>
<style>
</style>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	
	
	int bbsNum = 0;
	if (request.getParameter("bbsNum") != null) {
		bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
	}
	
	String bbsSearch = "";
	String bbsSearchType = "전체";
	if (request.getParameter("bbsSearch") != null) {
		bbsSearch = request.getParameter("bbsSearch");
	}
	if (request.getParameter("bbsSearchType") != null) {
		bbsSearchType = request.getParameter("bbsSearchType");
	}
	
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				bbsDAO bbs = new bbsDAO();
				String bbsAllCount = bbs.bbsAllCount();
				String bbsSearchCount = bbs.bbsSearchCount(bbsSearchType, bbsSearch);
			%>
			<br> <span>전체 <%=bbsAllCount%>건 중 <%=bbsSearchCount %>건
			</span> <a href="write.jsp">
				<button id="btn-write" type="button" class="btn btn-dark mb-2">
					글쓰기</button>
			</a>
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope="col" class="table-num"
							style="width: 10%; text-align: center;">번호</th>
						<th scope="col" class="table-title" style="text-align: center;">제목</th>
						<th scope="col" class="table-userID"
							style="width: 10%; text-align: center;">글쓴이</th>
						<th scope="col" class="table-date"
							style="width: 20%; text-align: center;">조회수</th>
						<th scope="col" class="table-bbsCount"
							style="width: 15%; text-align: center;">등록일</th>
					</tr>
				</thead>
				<%
					bbsDAO bbsDAO = new bbsDAO();
				ArrayList<bbsDTO> list = bbsDAO.getList(bbsSearchType, bbsSearch, pageNumber);
				for (int i = 0; i < list.size(); i++) {
				%>
				<tbody>
					<tr>
						<th scope="row" class="table-num"
							style="width: 10%; text-align: center;"><%=list.get(i).getBbsNum()%></th>
						<td
							style="width: 30%; max-width: 35%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; text-align: center;">
							<a href="view.jsp?bbsNum=<%=list.get(i).getBbsNum()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp").replace("<", "&lt").replace(">", "&gt").replace("\n",
		"<br>")%></a>
						</td>
						<td style="width: 20%; text-align: center;"><%=list.get(i).getUserID()%></td>
						<td style="width: 10%; text-align: center;"><%=list.get(i).getBbsCount()%></td>
						<td style="width: 30%; text-align: center;"><%=list.get(i).getBbsDate()%></td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>

			<!-- paging -->
			<div class="container">
				<div id="container_70pro">
					<ul>
						<%
							// int startPage = (pageNumber/10)*10+1 ;
						int startPage = (pageNumber / 10) * 10 + 1;
						if (pageNumber % 10 == 0) {
							startPage -= 10;
						}
						int targetPage = new bbsDAO().targetPage(bbsSearchType, bbsSearch, pageNumber);
						if (startPage != 1) {
						%>
						<li><a href="bbs.jsp?pageNumber=<%=startPage - 1%>&bbsSearchType=<%=URLEncoder.encode(bbsSearchType, "UTF-8")%>&bbsSearch=<%=URLEncoder.encode(bbsSearch, "UTF-8")%>"><button
									type="button" class="btn btn-outline-primary">&lt;</button></a></li>

						<%
							} else {
						%>
						<li><button type="button" class="btn btn-outline-danger">&lt;</button></li>
						<%
							}
						for (int i = startPage; i < pageNumber; i++) {
						%>
						<li><a href="bbs.jsp?pageNumber=<%=i%>&bbsSearchType=<%=URLEncoder.encode(bbsSearchType, "UTF-8")%>&bbsSearch=<%=URLEncoder.encode(bbsSearch, "UTF-8")%>"><button
									type="button" class="btn btn-outline-primary"><%=i%></button></a></li>
						<%
							}
						%>
						<li><a href="bbs.jsp?pageNumber=<%=pageNumber%>&bbsSearchType=<%=URLEncoder.encode(bbsSearchType, "UTF-8")%>&bbsSearch=<%=URLEncoder.encode(bbsSearch, "UTF-8")%>"><button
									type="button" class="btn btn-outline-primary active"><%=pageNumber%></button></a></li>
						<%
							for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
							if (i < startPage + 10) {
						%>
						<li><a href="bbs.jsp?pageNumber=<%=i%>&bbsSearchType=<%=URLEncoder.encode(bbsSearchType, "UTF-8")%>&bbsSearch=<%=URLEncoder.encode(bbsSearch, "UTF-8")%>"><button
									type="button" class="btn btn-outline-primary"><%=i%></button></a></li>
						<%
							}
						}
						if (targetPage + pageNumber > startPage + 9) {
						%>
						<li><a href="bbs.jsp?pageNumber=<%=startPage + 10%>&bbsSearchType=<%=URLEncoder.encode(bbsSearchType, "UTF-8")%>&bbsSearch=<%=URLEncoder.encode(bbsSearch, "UTF-8")%>"><button
									type="button" class="btn btn-outline-primary">&gt;</button></a></li>
						<%
							} else {
						%>
						<li><button type="button" class="btn btn-outline-primary">&gt;</button></li>

						<%
							}
						%>
					</ul>
				</div>
			</div><br>
			
			<div style="text-align:center;">
				<form action="bbs.jsp" method="post">
					<select id="bbsSearchType" name="bbsSearchType"onChange="javascript:fn_changeSelected(this);">
						<option id="All" value="전체" <% if(bbsSearchType.equals("전체")) out.println("selected"); %>>전체</option>
						<option value="글쓴이" <% if(bbsSearchType.equals("글쓴이")) out.println("selected"); %>>글쓴이</option>
						<option value="제목+내용" <% if(bbsSearchType.equals("제목+내용")) out.println("selected"); %>>제목+내용</option>
					</select>
					<input type="text" id="bbsSearch" name="bbsSearch" value="<%=bbsSearch %>">
					<button type="submit">검색</button>
				</form>
			</div>
		</div>
	</div>
	<script>
	function fn_changeSelected(obj) {
		  var getObj = obj[obj.selectedIndex].innerHTML;
		 	if(getObj =="전체"){
		 		$("#bbsSearch").val("");
		 		$('#bbsSearch').attr("readonly", true);
		 	}else{
		 		$('#bbsSearch').attr("readonly", false);
		 	}
		  // 혹은, document.getElementById("SUBJECT").value = getObj;   등등
		} 
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>