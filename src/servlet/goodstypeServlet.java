package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import java.sql.*;
import entity.Goods;

/**
 * Servlet implementation class goodstypeServlet
 */
public class goodstypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public goodstypeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String op = request.getParameter("op");
		System.out.println(op);
		//商品类别增加
		if(op.equals("insert")) {
			String typename = request.getParameter("typename");
			if(typename.equals("")==false && typename.length()!=0) {
				insertType(typename);
			}
			response.sendRedirect("GoodsType.jsp");
		}else if(op.equals("delete")) {//商品类别删除
			int id = Integer.parseInt(request.getParameter("id"));
			deleteType(id,response);
			response.sendRedirect("GoodsType.jsp");
		}else if(op.equals("goodinsert")) {//商品增加
			String goodname = request.getParameter("goodname");
			int id = Integer.parseInt(request.getParameter("id"));
			double price = Double.parseDouble(request.getParameter("price"));
			insertGood(goodname,id,price);
			response.sendRedirect("GoodsInsert.jsp");
		}else if(op.equals("deleteGood")) {//商品删除
			int id = Integer.parseInt(request.getParameter("id"));
			deleteGood(id);
			response.sendRedirect("GoodsUpdate.jsp");
		}else if(op.equals("updateGood")) {//商品更新
			int id = Integer.parseInt(request.getParameter("id"));
			String goodname = request.getParameter("goodname");
			int typeid = Integer.parseInt(request.getParameter("typeid"));
			double price = Double.parseDouble(request.getParameter("price"));
			updateGood(id,goodname,typeid,price,response);
			response.sendRedirect("GoodsUpdate.jsp");
		}
	}

	public void insertType(String typename) {
		String resource = "config/Configuration.xml";
		Reader reader;
		SqlSessionFactory sqlSessionFactory = null;
		SqlSession sqlsession = null;
		Connection con=null;
		Statement stmt;
		ResultSet rs;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e){
			
		}
		try {
			String type[] = new String[100];
			int count = 0;
			
			String url="jdbc:mysql://localhost/shopdb?useSSL=false";
			String user="root";
			String password = "123456";
			
			con = DriverManager.getConnection(url,user,password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM GoodsType");
			
			while(rs.next()){
				type[count] = rs.getString(2);
				count++;
			}
			int sum = count;
			for(int i = 0; i < sum; i++) {
				if(type[i].equals(typename)==false) {
					count--;
				}
			}
			if(count == 0) {
				try {
					reader = Resources.getResourceAsReader(resource);
					sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
					sqlsession = sqlSessionFactory.openSession();

					int result = sqlsession.insert("GoodsTypeMapper.insertType", typename);
					sqlsession.commit();
					System.out.println(result);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					sqlsession.rollback();
				} finally {
					if (sqlsession != null) {
						sqlsession.close();
					}
				}
			}
		}
		catch(Exception e) {
			
		}	
	}
	//后续加上判断两张表有无链接项再删除
	public void deleteType(int id,HttpServletResponse response) {
		
		Connection con=null;
		Statement stmt;
		ResultSet rs;
					
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e){
			
		}
		try{
			String url="jdbc:mysql://localhost/shopdb?useSSL=false";
			String user="root";
			String password = "123456";
			con = DriverManager.getConnection(url,user,password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT goods.goodid,goods.goodname,goodstype.typename,goods.price FROM GoodsType,goods WHERE goodstype.typeid = goods.typeid");
			while(rs.next()) {
				PrintWriter out = response.getWriter();
				out.print("尚有商品包含此商品类别，无法删除");
				response.sendRedirect("main.jsp");
			}
		}
		catch(Exception e){
			
		}
		String resource = "config/Configuration.xml";
		Reader reader;
		SqlSessionFactory sqlSessionFactory = null;
		SqlSession sqlsession = null;
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			sqlsession = sqlSessionFactory.openSession();

			int result = sqlsession.delete("GoodsTypeMapper.deleteType", id);
			sqlsession.commit();
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlsession.rollback();
		} finally {
			if (sqlsession != null) {
				sqlsession.close();
			}
		}
	}
	
	public void insertGood(String goodname,int id,double price) {
		String resource = "config/Configuration.xml";
		Reader reader;
		SqlSessionFactory sqlSessionFactory = null;
		SqlSession sqlsession = null;
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			sqlsession = sqlSessionFactory.openSession();
			Goods good = new Goods();
			good.setGoodname(goodname);
			good.setTypeid(id);
			good.setPrice(price);
			int result = sqlsession.insert("GoodsTypeMapper.insertGood", good);
			sqlsession.commit();
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlsession.rollback();
		} finally {
			if (sqlsession != null) {
				sqlsession.close();
			}
		}
	}
	
	
	public void deleteGood(int id) {
		String resource = "config/Configuration.xml";
		Reader reader;
		SqlSessionFactory sqlSessionFactory = null;
		SqlSession sqlsession = null;
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			sqlsession = sqlSessionFactory.openSession();
			
			int result = sqlsession.delete("GoodsTypeMapper.deleteGood", id);
			sqlsession.commit();
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlsession.rollback();
		} finally {
			if (sqlsession != null) {
				sqlsession.close();
			}
		}
	}
	
	public void updateGood(int id,String goodname,int typeid,double price,HttpServletResponse response) {
		String resource = "config/Configuration.xml";
		Reader reader;
		SqlSessionFactory sqlSessionFactory = null;
		SqlSession sqlsession = null;
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			sqlsession = sqlSessionFactory.openSession();
			
			Goods good =new Goods();
			good.setGoodname(goodname);
			good.setTypeid(typeid);
			good.setPrice(price);
			good.setId(id);
		
		
			int result = sqlsession.update("GoodsTypeMapper.updateGood", good);
			sqlsession.commit();
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlsession.rollback();
		} finally {
			if (sqlsession != null) {
				sqlsession.close();
			}
		}
	}
}
