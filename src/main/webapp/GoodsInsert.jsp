<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>GoodsInsert.jsp</title>
</head>
<body>
<%String username = (String)session.getAttribute("username");
		if(username==null||username.length()==0){
			response.sendRedirect("login.jsp");
		}
	%>
	<form action="goodstypeServlet?op=goodinsert" method=post>
		<table>
			<tr>
				<td>商品名称：<input type = text name = goodname></td>
			</tr>
			<tr>
				<td>商品类别：
				<%
					Connection con=null;
					Statement stmt;
					ResultSet rs;
					
					try{
						Class.forName("com.mysql.jdbc.Driver");
					}
					catch(Exception e){
						out.print(e);
					}
					try{
						String url="jdbc:mysql://localhost/shopdb?useSSL=false";
						String user="root";
						String password = "123456";
						con = DriverManager.getConnection(url,user,password);
						stmt = con.createStatement();
						rs = stmt.executeQuery("SELECT * FROM GoodsType");
						
						while(rs.next()){
							int id = rs.getInt(1);
							String typename = rs.getString(2);
					%>
							<td><input type = radio name = id value = <%=id%> > <%=typename%></td>
					<%}}
					catch(Exception e){
						out.print(e);
					} %>
			</tr>
			<tr>
				<td>商品价格：<input type = text name = price></td>
			</tr>
			<tr>
				<td><input type =submit name = submit value = "确认"></td>
			</tr>
		</table>
	</form>
</body>
</html>