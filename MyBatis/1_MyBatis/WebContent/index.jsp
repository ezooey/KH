<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="WEB-INF/views/common/menubar.jsp"/>
	
	<h1 align="center">Hello, I am MyBatis!</h1>
	<div align='center'>
		<img src="${ pageContext.servletContext.contextPath }/resources/mybatis.PNG">
	</div>
</body>
</html>