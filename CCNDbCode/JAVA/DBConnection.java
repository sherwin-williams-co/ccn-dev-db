package com.polling.dbcalls;

import java.sql.Statement;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedHashMap;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

import com.polling.downloads.InitialLoadProcess;
import com.polling.downloads.MaintenanceLoadProcess;

public class DBConnection {
	public static Connection conn     = null;
	public static String outXML       = null;
	public static String outFileName  = null;
	public static String outPrevReqId = null;
	
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
	
	public static String isMaintenanceNeeded() throws SQLException {
		Statement stmt = null;
		String cnt = null;
		String query=("SELECT POS_DOWNLOADS_INTERFACE_PKG.IS_MAINTENANCE_RQRD_FNC CNT FROM DUAL");
		try{
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
			cnt = rs.getString("CNT");
			}
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			stmt.close();
		}
		return cnt;
	}

	public static void updatePollingRequestId(String pollingRequestId, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt= conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.POS_DOWNLOADS_UPD_SP(?,?,?)}");
			cstmt.setString(1, appName);
			cstmt.setString(2, InitialLoadProcess.ccnFileName);
			cstmt.setString(3, pollingRequestId.substring(0,36));
			cstmt.execute();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
	}
	
	public static void updateMaintenancePollingRequestId(String pollingRequestId, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt= conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.POS_DOWNLOADS_UPD_SP(?,?,?)}");
			cstmt.setString(1, appName);
			cstmt.setString(2, MaintenanceLoadProcess.ccnFileName);
			cstmt.setString(3, pollingRequestId);
			cstmt.execute();
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
			DBConnection.sendMail("RequestidFailure", "Error while trying to update the polling request id ");
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
	
	public static Map<String,String> getPollingRequestsToBeProcessed() throws SQLException {
		Map<String,String> requests = new LinkedHashMap<String,String>();
        String posId = null;
        String appName = null;
        try {
        	CallableStatement pstmt = conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.GET_POLLING_MAINTENANCE_DTLS(?)}");
            pstmt.registerOutParameter(1,OracleTypes.CURSOR);
            pstmt.execute();
            ResultSet rset =((OracleCallableStatement) pstmt).getCursor(1);
            while (rset.next()){
            	posId = rset.getString(1);
            	appName = rset.getString(3);
//                System.out.println(posId);
//                System.out.println(appName);
                requests.put(posId, appName);
            }
            rset.close();
            pstmt.close();
        } catch (SQLException e) {
            System.err.println(e.getErrorCode() + e.getMessage());
        }
		return requests;
	}
	
	public static void processMaintenanceForPOSId(String PosID, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			cstmt= conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.PROCESS_POLLING_REQUEST_ID(?,?,?,?,?)}");
			cstmt.setString(1,PosID );
			cstmt.setString(2,appName);
			cstmt.registerOutParameter(3,Types.CLOB);
			cstmt.registerOutParameter(4,Types.VARCHAR);
			cstmt.registerOutParameter(5,Types.VARCHAR);
			cstmt.execute();
			MaintenanceLoadProcess.xml = cstmt.getString(3);
			MaintenanceLoadProcess.ccnPrevRequestID = cstmt.getString(4);
			MaintenanceLoadProcess.ccnFileName = cstmt.getString(5);			
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
			DBConnection.sendMail("RequestidFailure", "Error while calling POS_DOWNLOADS_INTERFACE_PKG.PROCESS_POLLING_REQUEST_ID ");
		}finally{
			cstmt.close();
		}
	}
	
}