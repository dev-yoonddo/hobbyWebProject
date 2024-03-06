package com.toogether.session;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.jdbc.pool.DataSource;

public class SqlConfig {

	private SqlConfig() {
	}

//	public static Connection getConn() {
//		Connection conn = null;
//		try {
//			String DB_DRIVER_CLASS = "org.mariadb.jdbc.Driver";
//			String DB_URL = "jdbc:mariadb://localhost:3306/cksndbs7";
//			String DB_USERNAME = "cksndbs7";
//			String DB_PASSWORD = "qlalf0720!";
//			Class.forName(DB_DRIVER_CLASS);
//			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
//			System.out.println("연결성공");
//
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			System.out.println("드라이브 로딩 실패");
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			System.out.println("DB 연결 실패");
//		}
//		return conn;
//	}

	private static Connection conn;
	static {
		try {
			Context initContext = new InitialContext();
//			Context envContext = (Context) initContext.lookup("java:/comp/env");
//			DataSource ds = (DataSource) envContext.lookup("jdbc/togetherDB");
			DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/cksndbs7");
			conn = ds.getConnection();
//			conn = dataSource.getConnection();
			if (conn != null && !conn.isClosed()) {
				System.out.println("데이터베이스 연결 성공");
			} else {
				System.out.println("데이터베이스 연결 실패");
			}
		} catch (SQLTimeoutException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConn() {
		System.out.println("Connection 요청");
		return conn;
	}

//	static {
//		try {
//			System.out.println("데이터베이스 연결 시작");
//			String dbURL = "jdbc:mysql://database-1.cxujakzvpvip.ap-southeast-2.rds.amazonaws.com:3306/hobbyWebProject?useUnicode=true&characterEncoding=UTF-8";
//			String dbID = "root";
//			String dbPassword = "qlalf9228?";
//			Class.forName("com.mysql.jdbc.Driver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//			if (conn != null && !conn.isClosed()) {
//				System.out.println("데이터베이스 연결 성공");
//			} else {
//				System.out.println("데이터베이스 연결 실패");
//			}
//		} catch (ClassNotFoundException e) {
//			System.out.println("드라이버 클래스가 없거나 읽어올 수 없습니다.");
//			e.printStackTrace();
//		} catch (SQLException e) {
//			System.out.println("데이터베이스 접속 정보가 올바르지 않습니다.");
//			e.printStackTrace();
//		}
//	}
//
//	public static Connection getConn() {
//		System.out.println("Connection 요청");
//		return conn;
//	}

//	public static Connection getConn() {
//		Connection conn = null;
//		try {
//			String dbURL = "jdbc:mariadb://toogether.me:3306/cksndbs7";
//			String dbID = "cksndbs7";
//			String dbPassword = "qlalf0720!";
//			Class.forName("com.mariadb.jdbc.Driver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//		} catch (ClassNotFoundException | SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return conn;
//	}

//	public static Connection getConn() {
//		try {
//			String dbURL = "jdbc:mysql://database-1.cxujakzvpvip.ap-southeast-2.rds.amazonaws.com:3306/hobbyWebProject?useUnicode=true&characterEncoding=UTF-8";
//			String dbID = "root";
//			String dbPassword = "qlalf9228?";
//			Class.forName("com.mysql.jdbc.Driver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//		} catch (ClassNotFoundException | SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return conn;
//	}

//	public static ResultSet getRs() {
//		return rs;
//	}
	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

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
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException ex) {
			ex.printStackTrace(); // Handle exception while closing resources
		}
	}
}
