package com.webservice;
//*******************************************************************************
//This function returns the request Id after successful Polling
//
//Created : 06/14/2017 rxv940 CCN Project....
//Changed :
//*******************************************************************************/
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.sherwin.polling.api.PollingDestMetadata;
import com.sherwin.polling.api.PollingFileMetadata;
import com.sherwin.polling.api.PollingHeaderMetadata;
import com.sherwin.polling.api.RestAdapter;
import com.sherwin.polling.api.RestAdapter.Environment;

public class PollingRequest {
	private static String username = "";
	private static String password = "";
	private static String application = "";
	private static String filename = "";
	private static String environment = "";
	private static String initLoadStore = "";

	public static void main(String[] args) throws Exception {
		String requestId = "";
		if (args.length == 5) {
			username    = args[0];
			password    = args[1];
			application = args[2];
			filename    = args[3];
			environment = args[4];
			
			initLoadStore = "/app/ccn/POSdownloads/POSxmls/COST_CENTER_DEQUEUE.queue"; 
			String fileStatus = "";
			
			fileStatus = fileExists(initLoadStore);
			if (fileStatus.equals("FILE_EXISTS")) {
				requestId = callPollingInitMethod();
			}else{
				requestId = callPollingMethod();
			}
			System.out.println(requestId);
		} else {
			System.out.println("Invalid Number of arguments passed.");
		}
	}

	public static String callPollingInitMethod() {
		String requestId = "";
		String fileExists = "";
		// Check for file existence
		fileExists = fileExists(filename);
		if (fileExists.equals("FILE_EXISTS")) {
			try {
				List<String> storeList = readFile(initLoadStore);
				requestId = RestAdapter.writeFileToPolling(
						username,
						password,
						getPollingHdrMetadata(),
						PollingDestMetadata.createDestinationList(storeList),
						PollingFileMetadata.create(filename));
				return requestId+ " Polling information sent to stores :" + storeList;
			} catch (Exception e) {
				e.printStackTrace();
				requestId = e.getMessage()+"Exception in the RestAdapter calling method section.";
			}
		} else {
			requestId = "Invalid file path provided.";
		}
		return requestId;
	}

	// Below function is used for non-Init loads and sends TERR and STORE files to all stores while PARAM
	// goes only to a specific store
	public static String callPollingMethod() {
		String requestId = "";
		String fileExists = "";
		//by default send to all stores
		PollingDestMetadata pollingMetadata = PollingDestMetadata.createDestinationFullChain();
		// Check for file existence
		fileExists = fileExists(filename);
		if (fileExists.equals("FILE_EXISTS")) {
			try {
				if (application.equals("PARAM")){
					// Read and get the store number from XML file name to pass for polling
					String storeNumber = "";
					storeNumber = return_Store_Number(filename, "parmUpdtRcd", "cost-center");
					List<String> storeList = new ArrayList<String>();
					storeList.add(storeNumber);
					pollingMetadata = PollingDestMetadata.createDestinationList(storeList);
				}
				requestId = RestAdapter.writeFileToPolling(
						username,
						password,
						getPollingHdrMetadata(),
						pollingMetadata,
						PollingFileMetadata.create(filename));
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
		String fileCheck = "FILE_DOESNOT_EXISTS";
		try {
			File file = new File(filepath);
			if (file.exists() && !file.isDirectory()) {
				fileCheck = "FILE_EXISTS";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileCheck;
	}

	private static String return_Store_Number(
			String filePath,
			String parentNode,
			String elementName)  {
		SAXBuilder builder = new SAXBuilder();
		File xmlFile = new File(filePath);
		String storeNumber = "test";
		Document document;
		try {
			document = builder.build(xmlFile);
			Element rootNode = document.getRootElement();
			List list = rootNode.getChildren(parentNode);
			for (int i = 0; i < list.size(); i++) {
				Element node = (Element) list.get(i);
				storeNumber = node.getChildText(elementName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return storeNumber;
	}

	private static PollingHeaderMetadata getPollingHdrMetadata()  {
		PollingHeaderMetadata pollingHdrMetadata = PollingHeaderMetadata.create(Environment.dev.name(), application);
		if (environment.equals("QA")) {
			pollingHdrMetadata = PollingHeaderMetadata.create(Environment.qa.name(), application);
		} else if (environment.equals("PROD")) {
			pollingHdrMetadata = PollingHeaderMetadata.create(Environment.prod.name(), application);
		}
		return pollingHdrMetadata;
	}
	
	private static List<String> readFile(String filename)
	{
	  List<String> records = new ArrayList<String>();
	  try
	  {
	    BufferedReader reader = new BufferedReader(new FileReader(filename));
	    String line;
	    while ((line = reader.readLine()) != null)
	    {
	      records.add(line);
	    }
	    reader.close();
	    return records;
	  }
	  catch (Exception e)
	  {
	    System.err.format("Exception occurred trying to read '%s'.", filename);
	    e.printStackTrace();
	    return null;
	  }
	}
}