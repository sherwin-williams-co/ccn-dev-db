package com.webservice;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.sherwin.polling.api.PollingDestMetadata;
import com.sherwin.polling.api.PollingFileMetadata;
import com.sherwin.polling.api.RestAdapter;
import com.sherwin.polling.api.PollingHeaderMetadata;
import com.sherwin.polling.api.RestAdapter.Environment;

public class Call_PollingMethod {

	private String username = "";
	private String password = "";
	private String application = "";
	private String filename = "";

	Call_PollingMethod(String username, String password, String application,
			String filename) {
		this.username = username;
		this.password = password;
		this.application = application;
		this.filename = filename;
	}

	public String callPollingMethod() {
		
		String requestId = "";
		String fileExists = "";
		
		// Check for file existence
		fileExists = fileExists(filename);
        
		if (fileExists.equals("FILE_EXISTS")) {

			try {				
				
				if (application.equals("PARAM"))
				{
				/*
				 * Add the stores that is there in the XML File.
				 * Read the xml file and get the store name 
				 * */
					
				//Read the xml file and return the store number.
                String storeNumber="";
                
                storeNumber=ReturnStoreNumber.return_Store_Number(filename,"parmUpdtRcd","store-number");        
                
				List<String> storeList = new ArrayList<String>();
				storeList.add(storeNumber);
					
				requestId = RestAdapter.writeFileToPolling(username, password,
						PollingHeaderMetadata.create(Environment.dev.name(),
								application), PollingDestMetadata
								.createDestinationList(storeList),
						PollingFileMetadata.create(filename));
				
				}
				else
				{
					requestId = RestAdapter.writeFileToPolling(username, password,
							PollingHeaderMetadata.create(Environment.dev.name(),
									application), PollingDestMetadata.createDestinationFullChain(),
							PollingFileMetadata.create(filename));
					
				}
				return requestId;

			} catch (Exception e) {				
				e.printStackTrace();
				requestId = e.getMessage()+"Exception in the RestAdapter calling method section.";
			}
		} else {
			requestId = "Invalid file path provided.";
		}

		return requestId;
	}

	private static String fileExists(String filepath) {
		String fileCheck = "";
		try {

			File file = new File(filepath);
			if (file.exists() && !file.isDirectory()) {
				fileCheck = "FILE_EXISTS";
			} else {
				fileCheck = "FILE_DOESNOT_EXISTS";
			}

		} catch (Exception e) {
			fileCheck = "FILE_DOESNOT_EXISTS";
			e.printStackTrace();
		}

		return fileCheck;
	}

}
