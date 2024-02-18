package com.toogether.session;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SqlConfig {
	private static Connection conn; // 자바와 데이터베이스 연결

	private SqlConfig() {
	}

	static {
		try {
			String dbURL = "jdbc:mysql://database-1.cxujakzvpvip.ap-southeast-2.rds.amazonaws.com:3306/hobbyWebProject?useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "qlalf9228?";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 클래스가 없거나 읽어올 수 없습니다.");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("데이터베이스 접속 정보가 올바르지 않습니다.");
			e.printStackTrace();
		}
	}

	public static Connection getConn() {
		return conn;
	}

//	public static ResultSet getRs() {
//		return rs;
//	}

	public static void closeResources(Connection conn, ResultSet rs, PreparedStatement pstmt) {
		try {
			if (rs != null) {
				// System.out.println("resultset close");
				rs.close();
			}
			if (pstmt != null) {
				// System.out.println("prepared close");
				pstmt.close();
			}
			if (conn != null) {
				// System.out.println("connection close");
				conn.close();
			}
		} catch (SQLException ex) {
			ex.printStackTrace(); // Handle exception while closing resources
		}
	}
}
