<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
</head>
<frameset rows = "98,*,5" frameborder="no">
	<frame src = "top.jsp" name = "topFrame" id = "topFrame/">
	<frameset cols="168,*" frameborder="no">
		<frame src="left.jsp" name = "leftFrame"/>
		<frame src="main.jsp" name= "mainFrame"/>
	</frameset>
</frameset>
<noframes>
	<body>
		浏览器不支持frame
	</body>
</noframes>
</html>
