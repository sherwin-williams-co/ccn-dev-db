package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Savepoint;
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
			DBConnection.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));

			// Check if there are items to process
			// Main logic starts
			if (DBConnection.isMaintenanceNeeded()) {
				Map<String,String> posIdAppName = new LinkedHashMap<String,String>();
				posIdAppName = DBConnection.getPollingRequestsToBeProcessed();
				//loop through the requests that needs to be processed
				for (java.util.Map.Entry<String, String> entrySet : posIdAppName.entrySet()) {
					//Get the file path where to place the xml file
					String fileNameWithPath = prop.getProperty("pollingDownloadFilePath");
					String posId = null;
					String pollingAppName = null;
					Savepoint spt1 = null;
					try {
						posId = entrySet.getKey();
						pollingAppName = entrySet.getValue();

						//Maintaining save points to handle multiple request independant of each other
						DBConnection.conn.setAutoCommit(false);
						spt1 = DBConnection.conn.setSavepoint("svpt1");
						//Process the request to get xml, previous request id and file name
						DBConnection.processMaintenanceForPOSId(posId, pollingAppName);

						fileNameWithPath = fileNameWithPath + ccnFileName;
						System.out.println("writing the file on server at : " + fileNameWithPath);
						//Write the file on the server
						UtilityProcess.writeToFile(fileNameWithPath,xml);

						System.out.println("Getting the polling request id");
						//set the required polling API parameters based on the application
						PollingRequestProcess pr = new PollingRequestProcess(pollingAppName);
						//Invoke the polling API with the file and previous request id 
						String pollingRequestId = pr.callPollingMethod(fileNameWithPath, ccnPrevRequestID);

						if(pollingRequestId.contains("Exception") || pollingRequestId.contains("Error")){
							DBConnection.sendMail("RequestidFailure", "Error in the retrieved requestid. The file "+ccnFileName+" has a REQUESTID: "+pollingRequestId);
							UtilityProcess.writeToFile(fileNameWithPath, "Error while processing POS_ID " + posId +  "\n" + xml);
						}else{
							if(pollingRequestId != null && !pollingRequestId.isEmpty()){
								System.out.println("Updating the polling request id");
								//Update the request id received after successful polling process
								DBConnection.updateMaintenancePollingRequestId(pollingRequestId, pollingAppName);
								System.out.println("PosID = " + posId + " , appName = " + pollingAppName + " , pollingRequestId = " + pollingRequestId + " PrevReqId = " + ccnPrevRequestID);
							}else{
								System.out.println("No request Id to update anything in the database");
							}
						}
					} catch(Exception e) {
						e.printStackTrace();
						DBConnection.conn.rollback(spt1);
					}
					DBConnection.conn.commit();
				}
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