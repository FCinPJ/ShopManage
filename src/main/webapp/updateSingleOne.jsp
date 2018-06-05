<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>updateSingleOne.jsp</title>
</head>
<body>
	<%	String type[] = new String[100];
		int typeid[] = new int[100];
		int count = 0;
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
				typeid[count] = rs.getInt(1);
				type[count] = rs.getString(2);
				count++;
			} 
	}
	catch(Exception e){
		out.print(e);
	}	
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e){
			out.print(e);
		}
		try{
			int id = Integer.parseInt(request.getParameter("id"));
			
			String url="jdbc:mysql://localhost/shopdb?useSSL=false";
			String user="root";
			String password = "123456";
			con = DriverManager.getConnection(url,user,password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT goods.goodid,goods.goodname,goodstype.typename,goods.price FROM GoodsType,goods WHERE goodstype.typeid = goods.typeid and goods.goodid="+id);
			%>
			<form action="goodstypeServlet?op=updateGood&id=<%=id%>" method = post>
			<table border ="1">
				<tr>
					<th>商品id</th>
					<th>商品名称</th>
					<th>商品类别</th>
					<th>商品价格</th>
					<th>操作</th>
				</tr>
			<%
			while(rs.next()){
				int i =rs.getInt(1);
				%>
				<tr>
					<td><%=i %></td>
					<td><input type = text name = goodname value = <%=rs.getString(2) %> ></td>
					<td>
					<%
						for(int k = 0;k < count;k++){
							%>
							<input type = radio name = typeid value = <%=typeid[k]%>><%=type[k] %>
							<%
						}
					%>
					</td>
					<td><input type = text name = price value = <%=rs.getDouble(4) %> ></td>
					<td><input type = submit name = submmit value = "确认"></td>
				</tr>
				<%
			}%>
			</table>
			</form>
			<%
		}
		catch(Exception e){
			out.print(e);
		}
		%>
</body>
</html>