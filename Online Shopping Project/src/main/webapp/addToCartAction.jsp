<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String product_id = request.getParameter("id");
System.out.println(email+product_id);
int quantity =1;
int product_price = 0;
int product_total = 0;
int cart_total = 0;

int z=0;
try{
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from product where id = '"+product_id+"'");
	while(rs.next()){
		product_price = rs.getInt(4);
		product_total = product_price;;
		System.out.println("//while1"+product_price+"//"+product_total );
	}
	ResultSet rs1 = st.executeQuery("select * from cart where product_id = '"+product_id+"'and email = '"+email+"' and address is null");
	while(rs1.next()){
		cart_total = rs1.getInt(5);
		cart_total = cart_total + product_total;
		quantity = rs.getInt(3);
		quantity = quantity + 1;
		z=1;
		System.out.println("//while1"+cart_total+"//"+cart_total+"//while1"+quantity+"//"+quantity );
	}
	if(z==1){
		System.out.println("update !");
		st.executeUpdate("update cart set total = '"+cart_total+"',quantity='"+quantity+"' where product_id='"+product_id+"' and email='"+email+"' and address is null");
		
		response.sendRedirect("home.jsp?msg=exist");
	}
	if(z==0){
		System.out.println("add !");
		PreparedStatement ps = con.prepareStatement("insert into cart(email,product_id,quantity,price,total) values (?,?,?,?,?)");
		ps.setString(1,email);
		ps.setString(2,product_id);
		ps.setInt(3,quantity);
		ps.setInt(4,product_price);
		ps.setInt(5,product_total);
		System.out.println("add !"+email+"//"+product_id+"//"+quantity+"//"+product_price+"//"+product_total);
		ps.executeUpdate();
		response.sendRedirect("home.jsp?msg=added");		
	}
	
	
}catch(Exception e){
	response.sendRedirect("home.jsp?msg=invalid");
}


%>
