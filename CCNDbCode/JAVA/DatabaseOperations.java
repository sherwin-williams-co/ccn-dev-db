package com.batches;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import com.batches.FixedWidthFile;
import com.csvreader.CsvReader;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

public class DatabaseOperations {
	public static Connection conn = null;
	public static String dbCallRequired;
	public static String dbCall;
	public static String dbCallParamsExists;
	public static String dbCallType;
	public static String dbCallParam1;
	public static String dbCallParam2;

	public static void setConnection(String inUser, String inPwd, String inConn) throws SQLException{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		//		conn = DriverManager.getConnection("jdbc:oracle:thin:@"+inConn, inUser, inPwd);
		conn = DriverManager.getConnection(inConn, inUser, inPwd);
	}
	public static void closeConnection() throws SQLException{
		conn.close();
	}
	public static void loadDBDetails(){
		String executingJob = ConfigPropertiesOperations.executingJob;
		Properties propJobs = ConfigPropertiesOperations.propJobs;
		dbCallRequired = propJobs.getProperty(executingJob+".db.call.required");
		if (dbCallRequired.equalsIgnoreCase("Y")){
			dbCall = propJobs.getProperty(executingJob+".db.call");
			dbCallType = propJobs.getProperty(executingJob+".db.callType");
			dbCallParamsExists = propJobs.getProperty(executingJob+".db.parameter.required");
			if (dbCallParamsExists.equalsIgnoreCase("Y")){
				String[] myParams = propJobs.getProperty(executingJob+".db.parameter.commaSeperatedInputParams").split(",");
				int i = 0;
				for (String s1: myParams) {
					if(i==0){ 
						dbCallParam1 = s1.replace("YYYYMMDDHHMISS",new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()))
								.replace("YYYYMMDD",new SimpleDateFormat("yyyyMMdd").format(new Date()));
					}else if (i==1) {
						dbCallParam2 = s1.replace("YYYYMMDDHHMISS",new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()))
								.replace("YYYYMMDD",new SimpleDateFormat("yyyyMMdd").format(new Date()));
					}
					i++;
				}
			}
		}
	}

	public static void execProcStringIpClobOpFileNmOp(String methodCall, String inParam){
		CallableStatement pstmt = null;
		try {
			pstmt = conn.prepareCall("{call " + methodCall + "}");
			pstmt.setString(1, inParam);
			pstmt.registerOutParameter(2, Types.CLOB);
			pstmt.registerOutParameter(3, Types.VARCHAR);
			pstmt.execute();
			FileOperations.clobData = pstmt.getString(2);
			FileOperations.fileName = pstmt.getString(3);
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void execProcStringIpNoOp(String methodCall, String inParam){
		CallableStatement pstmt = null;
		try {
			pstmt = conn.prepareCall("{call " + methodCall + "}");
			pstmt.setString(1, inParam);
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void executeProcedureNoIO(String methodCall){
		CallableStatement pstmt = null;
		try {
			pstmt = conn.prepareCall("{call " + methodCall + "}");
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void execProcNoIpClobOpFileNmOp(String methodCall){
		CallableStatement pstmt = null;
		try {
			pstmt = conn.prepareCall("{call " + methodCall + "}");
			pstmt.registerOutParameter(1, Types.CLOB);
			pstmt.registerOutParameter(2, Types.VARCHAR);
			pstmt.execute();
			FileOperations.clobData = pstmt.getString(2);
			FileOperations.fileName = pstmt.getString(3);
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void getMailingInfo(String mailCategory){
		CallableStatement pstmt = null;
		try {
			pstmt = conn.prepareCall("{call MAIL_PKG.MAILING_DETAILS_SP(?,?)}");
			pstmt.setString(1, mailCategory);
			pstmt.registerOutParameter(2, OracleTypes.CURSOR);
			pstmt.execute();
			ResultSet rset =((OracleCallableStatement) pstmt).getCursor(2);
			while (rset.next()){
				EmailOperations.subject = rset.getString(3);
				EmailOperations.from = rset.getString(4);
				EmailOperations.body = rset.getString(5);
				EmailOperations.signature = rset.getString(6);
				EmailOperations.to = rset.getString(7);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void loadDataFile(CsvReader table, String tableName) {
		PreparedStatement stmt = null;
		try {
			//			System.out.println(table.readHeaders());
			table.readHeaders();
			String queryIp = "";
			for (int i =0; i < table.getHeaderCount(); i++){
				queryIp = queryIp + "?,";
			}
			queryIp = queryIp.substring(0, queryIp.length()-1);
			//			System.out.println(queryIp);
			stmt = conn.prepareStatement("INSERT INTO "+ tableName +" VALUES ("+queryIp+")");
			final int batchSize = 1000;
			int count = 0;
			while (table.readRecord()) {
				for (int i =0; i < table.getHeaderCount(); i++){
					//					System.out.println(i+1+ "->" + table.getHeader(i));
					stmt.setString(i+1, table.get(table.getHeader(i)));
				}
				stmt.addBatch();
				if (++count % batchSize == 0) {
					stmt.executeBatch();
				}
			}
			stmt.executeBatch();
		} catch (Exception e) {
			System.err.println(e.getClass().getName() + " : " + e.getMessage());
			System.exit(0);
		} finally {
			table.close();
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("Records created successfully");
	}
	public static void loadDataFile(FixedWidthFile table, String tableName) {
		PreparedStatement stmt = null;
		try {
			String queryIp = "";
			for (List<String> s1: table.tokens()) {
				for (String s2: s1) {
					queryIp = queryIp + "?,";
				}
				break;
			}
			queryIp = queryIp.substring(0, queryIp.length()-1);
			//			System.out.println(queryIp);
			stmt = conn.prepareStatement("INSERT INTO "+ tableName +" VALUES ("+queryIp+")");
			final int batchSize = 1000;
			int count = 0;
			for (List<String> s1: table.tokens()) {
				int i = 0;
				for (String s2: s1) {
					stmt.setString(i+1, s2);
					i++;
				}
				stmt.addBatch();
				if (++count % batchSize == 0) {
					stmt.executeBatch();
				}
			}
			stmt.executeBatch();
		} catch (Exception e) {
			System.err.println(e.getClass().getName() + " : " + e.getMessage());
			System.exit(0);
		} finally {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("Records created successfully");
	}
}
