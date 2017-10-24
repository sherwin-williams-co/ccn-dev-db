package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Properties;

import com.polling.dbcalls.DBConnection;

public class InitialLoadProcess {
	private static String loadType;
	public static String xml;
	public static String ccnPrevRequestID;
	public static String ccnFileName;
	public static Properties prop = new Properties();
	public static void main(String[] args) throws SQLException {
		loadType    = args[0];
		//loadType = "SYNC_LOAD";
		try {
			System.out.println("Loading configuration properties");
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);

			System.out.println("Connecting to Database");
			DBConnection.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));
			if(loadType.equals("NEW_GRP_LD")){
				String appName     = args[1];// "STORE" or "TERR"
				//String appName = "STORE";
				System.out.println("Processing New Group Load");
				processNewGroupLoad(appName);
			}else if(loadType.equals("NEW_STR_LD")){
				System.out.println("Processing New Store Load");
				processNewStoreLoad();
			}else if(loadType.equals("SYNC_LOAD")){
				String appName     = args[1];// "STORE" or "TERR"
				//String appName = "STORE";
				System.out.println("Processing Sync Load");
				processSyncLoad(appName);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally{
			try{
				System.out.println("Closing the data base connection");
				DBConnection.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	private static void processNewGroupLoad(String appName) throws Exception{
		System.out.println("Getting store list as string");
		String ccWS = WebServiceProcess.getAppStoresAsString(appName);

		System.out.println("connecting to database to find diffs in ccWS");
		String newStores = DBConnection.getWsDiff(appName, ccWS);
		System.out.println( "newStores : " + newStores);

		processInitLoad(newStores, appName);
	}

	private static void processNewStoreLoad() throws Exception{
		System.out.println("Getting the list of stores from message queue");
		String newStores = null;
		try{
			newStores = MessageQueueProcess.getQueueMessagesAsString();
		}catch(Exception e){
			DBConnection.sendMail("QueueDownloadFAILURE", "Error in Queue download process." + e.getMessage());
		}
		System.out.println( "newStores : " + newStores);
		processInitLoad(newStores, "STORE");

		processInitLoad(newStores, "TERR");
	}

	private static void processSyncLoad(String appName) throws Exception{
		processInitLoad("SYNC_LOAD",appName);
	}

	private static void processInitLoad(String stores, String pollingAppName) throws SQLException{
		if (stores != null) {
			System.out.println("Generating initial load file for application "+pollingAppName);
			DBConnection.callInitLoad(pollingAppName, loadType);

			String fileNameWithPath = prop.getProperty("pollingDownloadFilePath") + ccnFileName;
			System.out.println("writing the file on server at : " + fileNameWithPath);
			UtilityProcess.writeToFile(fileNameWithPath,xml);

			System.out.println("Getting the polling request id");
			PollingRequestProcess pr = new PollingRequestProcess(pollingAppName);
			String pollingRequestId = null;
			if(loadType.equals("SYNC_LOAD")){
				pollingRequestId = pr.callPollingMethod(fileNameWithPath, ccnPrevRequestID);
			}else{
				pollingRequestId = pr.callPollingInitMethod(fileNameWithPath, ccnPrevRequestID, stores);
			}
			if(pollingRequestId.contains("Exception") || pollingRequestId.contains("Error")){
				DBConnection.sendMail("RequestidFailure", "Error in the retrieved requestid. The file "+ccnFileName+" has a REQUESTID: "+pollingRequestId);
			}else{
				System.out.println("Updating the polling request id");
				DBConnection.updatePollingRequestId(pollingRequestId);
			}
		} else {
			System.out.println( "Warning:- No stores to send the initial load files to");
		}
	}
}