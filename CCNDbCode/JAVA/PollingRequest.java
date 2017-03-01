package com.webservice;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
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
	private static String env = "";

	public static void main(String[] args) throws Exception {

		String requestId = "";

		if (args.length == 5) {
			username = args[0];
			password = args[1];
			application = args[2];
			filename = args[3];
			env = args[4];
			requestId = callPollingMethod();
			System.out.println(requestId);

		} else {
			System.out.println("Invalid Number of arguments passed.");
		}

	}

	public static String callPollingMethod() {
		String requestId = "";
		String fileExists = "";
		// Check for file existence
		fileExists = fileExists(filename);
		if (fileExists.equals("FILE_EXISTS")) {
			try {
				if (application.equals("PARAM")){
					/*
					 * Add the stores that is there in the XML File.
					 * Read the xml file and get the store name
					 * */
					//Read the xml file and return the store number.
					String storeNumber="";
					storeNumber = return_Store_Number(filename,"parmUpdtRcd","store-number");
					List<String> storeList = new ArrayList<String>();
					storeList.add(storeNumber);
					if (env.equals("DEV") || (env.equals("TEST"))) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.dev.name(),
										application), PollingDestMetadata
										.createDestinationList(storeList),
										PollingFileMetadata.create(filename));
					} else if (env.equals("QA")) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.qa.name(),
										application), PollingDestMetadata
										.createDestinationList(storeList),
										PollingFileMetadata.create(filename));
					} else if (env.equals("PROD")) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.prod.name(),
										application), PollingDestMetadata
										.createDestinationList(storeList),
										PollingFileMetadata.create(filename));
					}
				}
				else{
					if (env.equals("DEV") || (env.equals("TEST"))) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.dev.name(),
										application), PollingDestMetadata.createDestinationFullChain(),
										PollingFileMetadata.create(filename));
					} else if (env.equals("QA")) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.qa.name(),
										application), PollingDestMetadata.createDestinationFullChain(),
										PollingFileMetadata.create(filename));
					} else if (env.equals("PROD")) {
						requestId = RestAdapter.writeFileToPolling(username, password,
								PollingHeaderMetadata.create(Environment.prod.name(),
										application), PollingDestMetadata.createDestinationFullChain(),
										PollingFileMetadata.create(filename));
					}

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

	private static String return_Store_Number(String filePath, String parentNode, String elementName)  {
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
			//catch (JDOMException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		return storeNumber;
	}
}