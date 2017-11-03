package com.descartes.dbcalls;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

public class DBConnectionDscrts {
	public static Connection conn = null;
	public static void setConnection(String inUser, String inPwd, String inConn) throws SQLException{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		conn = DriverManager.getConnection("jdbc:oracle:thin:@"+inConn, inUser, inPwd);
	}
	public static void closeConnection() throws SQLException{
		conn.close();
	}
	public static Map<String,String> getRequests(String inDate) throws SQLException {
		Map<String,String> requests = new HashMap<String,String>();
		String costCenter = null;
		String action = null;
		String guid = null;
		try {
			CallableStatement pstmt = conn.prepareCall("{call CCN_DESCARTES_PROCESS.DESCARTES_ADRS_FEED_CC_SP(?,?)}");
			pstmt.setDate(1, java.sql.Date.valueOf(inDate));
//			pstmt.setNull(1,java.sql.Types.DATE);
			pstmt.registerOutParameter(2,OracleTypes.CURSOR);
			pstmt.execute();
			ResultSet rset =((OracleCallableStatement) pstmt).getCursor(2);
			while (rset.next()){
				costCenter = rset.getString(1);
				action = rset.getString(3);
				guid = rset.getString(7);
//				System.out.println(costCenter);
//				System.out.println(action);
				requests.put(guid, getCostCenterData(costCenter, action));
			}
			rset.close();
			pstmt.close();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}
		return requests;
	}

	public static String getCostCenterData(String inCostCenter, String inAction) throws SQLException {
		String data = "";
		try {
			CallableStatement pstmt = conn.prepareCall("{call CCN_DESCARTES_PROCESS.GNRT_DSCRTS_ADDRESS_CC_FILE(?,?,?)}");
			pstmt.setString(1, inCostCenter);
			pstmt.setString(2, inAction);
			pstmt.registerOutParameter(3, Types.CLOB);
			pstmt.execute();
			data = pstmt.getString(3);
			pstmt.close();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}
//		System.out.println(data);
		return data;
	}

	public static void setResponse(String inGuid, String inResponse) throws SQLException {
		try {
			CallableStatement pstmt = conn.prepareCall("{call CCN_DESCARTES_PROCESS.DESCARTE_ADRS_FEED_RESP_CC_UPD(?,?)}");
			pstmt.setString(1, inGuid);
			pstmt.setString(2, inResponse);
			pstmt.execute();
			pstmt.close();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}
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
	
//	public static Map<String,String> getInitlaodRequest() throws SQLException {
//		Map<String,String> requests = new HashMap<String,String>();
//		String guid = "";
//		String data = "";
//		try {
//			CallableStatement pstmt = conn.prepareCall("{call CCN_DESCARTES_PROCESS.GNRT_DSCRTS_ADDRESS_INIT_FILE(?,?)}");
//			pstmt.registerOutParameter(1, Types.CLOB);
//			pstmt.registerOutParameter(2, Types.VARCHAR);
//			pstmt.execute();
//			data = pstmt.getString(1);
//			guid = pstmt.getString(2);
//			requests.put(guid, data);
//			pstmt.close();
//		} catch (SQLException e) {
//			System.err.println(e.getErrorCode() + e.getMessage());
//		}
//		return requests;
//	}

}
