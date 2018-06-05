<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><center>
<head>
<title>GoodsType.jsp</title>
</head>
<body>
	<%String username = (String)session.getAttribute("username");
		if(username==null||username.length()==0){
			response.sendRedirect("login.jsp");
		}
	%>
	<form action="goodstypeServlet?op=insert" method = post>
		<table>
			<tr>
				<td>添加商品类别</td>
			</tr>
			<tr>
				<td>商品类别：<input type="text" name = typename></td>
				<td><input type = "submit" name = submit value="确定"></td>
			</tr>
		</table>
	</form>
	<form action="goodstypeServlet?op=delete" method = post>
		<table>
			<tr>
				<td>删除商品类别</td>
			</tr>
			<tr>
				<td>商品类别：</td>
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
					<%
						} 
					%>
					<td><input type = "submit" name = submit value="确定"></td>
					<%
				}
				catch(Exception e){
					out.print(e);
				}
				%>
			</tr>
		</table>
	</form>
</body>
</center></html>