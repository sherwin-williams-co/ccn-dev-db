package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import com.polling.dbcalls.DBConnection; 
import com.polling.downloads.UtilityProcess;

public class MaintenanceLoadProcess {
	public static Properties prop = new Properties();
	public static String xml;
	public static String ccnPrevRequestID;
	public static String ccnFileName;

	public static void main(String[] args) throws SQLException {
		try{
			// Invoke Configuration file to set properties
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);

			// Connect to DB
			System.out.println("Connecting to Database");
			DBConnection.setConnection(prop.getProperty("utiluser"), prop.getProperty("utilpwd"), prop.getProperty("dbconn"));

			// Check if there are items to process
			// Main logic starts
			if (DBConnection.isMaintenanceNeeded().equals("Y")) {
				Map<String,String> posIdAppName = new LinkedHashMap<String,String>();
				posIdAppName = DBConnection.getPollingRequestsToBeProcessed();
				System.out.println("**********************************************************************************************");
				for (java.util.Map.Entry<String, String> entrySet : posIdAppName.entrySet()) {
					String fileNameWithPath = prop.getProperty("pollingDownloadFilePath");
					String posId = null;
					String pollingAppName = null;
					try {
						posId = entrySet.getKey();
						pollingAppName = entrySet.getValue();

						DBConnection.conn.setAutoCommit(false);
						DBConnection.conn.setSavepoint("SVPT");
						DBConnection.processMaintenanceForPOSId(posId, pollingAppName);

						fileNameWithPath = fileNameWithPath + ccnFileName;
						System.out.println("writing the file on server at : " + fileNameWithPath);
						UtilityProcess.writeToFile(fileNameWithPath,xml);

						System.out.println("Getting the polling request id");
						PollingRequestProcess pr = new PollingRequestProcess(pollingAppName);
						String pollingRequestId = pr.callPollingMethod(fileNameWithPath, ccnPrevRequestID);

						if(pollingRequestId.contains("Exception") || pollingRequestId.contains("Error")){
							DBConnection.sendMail("RequestidFailure", "Error in the retrieved requestid. The file "+ccnFileName+" has a REQUESTID: "+pollingRequestId);
							UtilityProcess.writeToFile(fileNameWithPath, "Error while processing POS_ID " + posId +  "\n" + xml);
						}else{
							if(pollingRequestId != null && !pollingRequestId.isEmpty()){
								System.out.println("Updating the polling request id");
								DBConnection.updateMaintenancePollingRequestId(pollingRequestId, pollingAppName);
								DBConnection.conn.commit();
								System.out.println("PosID = " + posId + " , appName = " + pollingAppName + " , pollingRequestId = " + pollingRequestId + " PrevReqId = " + ccnPrevRequestID);
								System.out.println("\n");
							}else{
								System.out.println("No request Id to update anything in the database");
							}
						}
					} catch(Exception e) {
						e.printStackTrace();
						DBConnection.conn.rollback();
					}
				}
				System.out.println("**********************************************************************************************");
			} else {
				System.out.println("No new data to process ... ");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally{
			try{
				System.out.println("Closing the data base connection");
				DBConnection.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}