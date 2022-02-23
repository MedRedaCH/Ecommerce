package project;


import java.sql.*;

public class ConnectionProvider {
	
	public static Connection getCon() {
		
		
		try {			
			 String jdbcURL = "jdbc:mysql://localhost:3306/ospjsp";
			 String jdbcUsername = "root";
			 String jdbcpassword = "314488314488";
			 
			 Class.forName("com.mysql.cj.jdbc.Driver");			 
			Connection	con = DriverManager.getConnection(jdbcURL,jdbcUsername,jdbcpassword);
			System.out.print("connected");
			return con;
		}catch(Exception e) {
			System.out.println(e);
			
			return null;
		}
	}
}
