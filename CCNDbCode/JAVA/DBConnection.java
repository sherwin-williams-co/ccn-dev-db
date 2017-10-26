package com.polling.dbcalls;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Types;

import com.polling.downloads.InitialLoadProcess;

public class DBConnection {
	public static Connection conn = null;
	public static void setConnection(String inUser, String inPwd, String inConn) throws SQLException{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		conn = DriverManager.getConnection("jdbc:oracle:thin:@"+inConn, inUser, inPwd);
	}
	public static void closeConnection() throws SQLException{
		conn.close();
	}
	public static void callInitLoad(String appName, String loadType) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt = conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.INIT_LOAD_BY_APP_NAME(?,?,?,?,?)}");
			cstmt.setString(1, appName);
			cstmt.setString(2, loadType);
			cstmt.registerOutParameter(3,Types.CLOB);
			cstmt.registerOutParameter(4,Types.VARCHAR);
			cstmt.registerOutParameter(5,Types.VARCHAR);
			cstmt.execute();
			InitialLoadProcess.xml = cstmt.getString(3);
			InitialLoadProcess.ccnPrevRequestID = cstmt.getString(4);
			InitialLoadProcess.ccnFileName  = cstmt.getString(5);
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
	}

	public static void updatePollingRequestId(String pollingRequestId, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt= conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.POS_DOWNLOADS_UPD_SP(?,?,?)}");
			cstmt.setString(1, appName);
			cstmt.setString(2, InitialLoadProcess.ccnFileName);
			System.out.println(appName);
			System.out.println(InitialLoadProcess.ccnFileName);
			System.out.println(pollingRequestId);
			cstmt.setString(3, pollingRequestId.substring(0,36));
			cstmt.execute();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
	}

	public static String getWsDiff(String appName, String ccWS) throws SQLException {
		CallableStatement cstmt = null;
		String newStores = null;
		try{
			cstmt = conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.WS_DIFF_BY_FILE_TYPE(?,?,?)}");
			cstmt.setString(1, appName);
			cstmt.setString(2, ccWS);
			cstmt.registerOutParameter(3,Types.CLOB);
			cstmt.execute();
			newStores = cstmt.getString(3);
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
		return newStores;
	}    
	
	public static void sendMail(String mailCategory, String errorDetails) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt= conn.prepareCall("{call MAIL_PKG.send_mail(?,?,?,?)}");
			cstmt.setString(1, mailCategory);
			cstmt.setNull(2, Types.NULL);
			cstmt.setNull(3, Types.NULL);
			cstmt.setString(4, errorDetails);
			cstmt.execute();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
	}
}