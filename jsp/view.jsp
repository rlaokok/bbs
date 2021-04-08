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
<title>게시글 화면</title>
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
		if(bbsNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유요하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Cookie[] cookies = request.getCookies();
	    // 비교하기 위해 새로운 쿠키
	    Cookie viewCookie = null;
	    // 쿠키가 있을 경우 
	    if (cookies != null && cookies.length > 0) 
	    {
	        for (int i = 0; i < cookies.length; i++)
	        {
	            // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
	            if (cookies[i].getName().equals("cookie"+bbsNum))
	            { 
	                System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
	                viewCookie = cookies[i];
	                System.out.println(viewCookie);
	            }
	        }
	    }
	    
	    	if (viewCookie == null) {    
		        // 쿠키 생성(이름, 값)
		        Cookie newCookie = new Cookie("cookie"+bbsNum, "|" + bbsNum + "|");
		                        
		        // 쿠키 추가
		        response.addCookie(newCookie);

		        // 쿠키를 추가 시키고 조회수 증가시킴
		        bbsDAO bbsCount = new bbsDAO();
		        bbsCount.hitCounter(bbsNum);
		    }
			// viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
			else {
				String value = viewCookie.getValue();
	            System.out.println("cookie 값 : " + value);
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
              <div style="background-color: #F8F9FA; text-align: center;"><b>게시글</b></div><br>
                <table id="table">
                  <tr class="tr">
                    <th style="width: 20%; text-align: left;">제목</th>
                    <td style="width: 80%; text-align: left;" colspan="3"><%=bbs.getBbsTitle() %></td>
                  </tr>
                  <tr class="tr">
                    <th style="width: 20%; text-align: left;">작성자</th>
                    <td style="width: 30%; text-align: left;"><%=bbs.getUserID() %></td>
                    <th style="width: 20%; text-align: left;">조회수</th>
                    <td style="width: 30%; text-align: left;"><%=bbs.getBbsCount() %></td>
                  </tr>
                  <tr class="tr" style="height: 330px;">
                    <th style="width: 20%; text-align: left;">내용</th>
                    <td style="width: 80%; text-align: left;" colspan="3"><%=bbs.getBbsContent() %></td>
                  </tr>
                </table>
                <br>
                <%if(bbs.getUserID().equals(userID)){ %>
                  <a href="deleteAction.jsp?bbsNum=<%=bbs.getBbsNum() %>" onclick="return confirm('정말로 삭제하시겠습니까?')">
                  <button type="button" class="btn btn-dark" id="btn-write">글 삭제</button></a>
                  <a href="update.jsp?bbsNum=<%=bbs.getBbsNum() %>">
                  <button type="button" class="btn btn-dark" id="btn-write">글 수정</button></a><br>
                <%} %>
                <%if(userID != null){
                	if(userID.equals("admin")){ %>
                  <a href="deleteAction.jsp?bbsNum=<%=bbs.getBbsNum() %>" onclick="return confirm('정말로 삭제하시겠습니까?')">
                  <button type="button" class="btn btn-dark" id="btn-write">글 삭제</button></a><br>
                <%}} %>
                
            </div>
            <br>
            <div class="container" style="text-align:center;"><a href="bbs.jsp">메인으로 돌아가기</a></div>
          </div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>