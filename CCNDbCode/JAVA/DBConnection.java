package com.polling.dbcalls;

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
			//Below call will accept the application name and load type to build the xml and
			//pass back the xml, previous request id and file name as output
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
	
	public static String validateQueueMessages(String queueMessage) throws SQLException {
		CallableStatement cstmt = null;
		String validStores = null;
		try{
			//Below call will validate the messages came in the queue process and identify/return valid new store
			cstmt = conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.VALIDATE_POS_QUEUE_MESSAGE(?,?)}");
			cstmt.setString(1, queueMessage);
			cstmt.registerOutParameter(2,Types.VARCHAR);
			cstmt.execute();
			validStores = cstmt.getString(2);
		} catch (SQLException e) {
			System.err.println(e.getErrorCode() + e.getMessage());
		}finally{
			cstmt.close();
		}
		return validStores;
	}
	
    public static boolean isMaintenanceNeeded() throws SQLException {
        CallableStatement cstmt = null;
        boolean maintenanceRequired = false;
        try{
            //Below call will check if there are any maintenance requests that needs to be processed
        	cstmt = conn.prepareCall("{?=call POS_DOWNLOADS_INTERFACE_PKG.IS_MAINTENANCE_RQRD_FNC}");
            cstmt.registerOutParameter(1,Types.VARCHAR);
            cstmt.execute();
            String output = cstmt.getString(1);
            if (output.equals("Y")) {
                maintenanceRequired = true;
            }
        } catch (SQLException e) {
            System.err.println(e.getErrorCode() + e.getMessage());
        }finally{
            cstmt.close();
        }
        return maintenanceRequired;
    }

	public static void updatePollingRequestId(String pollingRequestId, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			//Below call will update the polling request id obtained from API after successful process completion
			//This looks like duplicate of updateMaintenancePollingRequestId but the file name parameter is class specific
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
			//Below call will update the polling request id obtained from API after successful process completion
			//This looks like duplicate of updatePollingRequestId but the file name parameter is class specific
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
			//Below call will accepts the entire list of cost centers from web service
			//and returns a list of cost centers that are added newly to the web service
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
			//Below call will send email based on the mail category and message passed
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
        //Below call will get all the polling requests that needs to be processed 
        CallableStatement pstmt = conn.prepareCall("{call POS_DOWNLOADS_INTERFACE_PKG.GET_POLLING_MAINTENANCE_DTLS(?)}");
        try {
            pstmt.registerOutParameter(1,OracleTypes.CURSOR);
            pstmt.execute();
            ResultSet rset =((OracleCallableStatement) pstmt).getCursor(1);
            //building requests array to be processed 
            while (rset.next()){
            	posId = rset.getString(1);
            	appName = rset.getString(3);
                requests.put(posId, appName);
            }
            rset.close();
        } catch (SQLException e) {
            System.err.println(e.getErrorCode() + e.getMessage());
        } finally {
        	pstmt.close();
        }
    	return requests;
	}
	
	public static void processMaintenanceForPOSId(String PosID, String appName) throws SQLException {
		CallableStatement cstmt = null;
		try{
			//Below call will process the passed POSID for tha passed Application
			//and gets the xml, previous request id and file name as output 
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