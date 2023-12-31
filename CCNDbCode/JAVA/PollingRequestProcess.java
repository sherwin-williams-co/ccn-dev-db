package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import com.sherwin.polling.api.PollingDestMetadata;
import com.sherwin.polling.api.PollingFileMetadata;
import com.sherwin.polling.api.PollingHeaderMetadata;
import com.sherwin.polling.api.RestAdapter;
import com.sherwin.polling.api.RestAdapter.Environment;
import com.sherwin.polling.api.RestAdapter.Prerequisite;
import com.sherwin.polling.enums.FixType;

public class PollingRequestProcess {
	private static String username = "";
	private static String password = "";
	private static String application = "";
	private static String filename = "";
	private static String environment = "";
	private static String prevRequestId = "";
	private static String pilotPhaseIndicator = "";
	private static Properties prop = new Properties();

	public PollingRequestProcess(String appName){
		System.out.println("Constructor of PollingRequest setting the configuration values");
		try {
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);
		} catch (Exception e) {
			e.printStackTrace();
		}
		application = appName;
		environment = prop.getProperty("environment");
		username = prop.getProperty(appName+"UserName");
		password = prop.getProperty(appName+"Password");
		pilotPhaseIndicator = prop.getProperty("pilotPhaseInd");
	}

	private static String callPollingInitMethod(List<String> storeList){
		String requestId = "";
		//If input store list is empty we do nothing and return empty string
		if (!storeList.isEmpty()) {
			try {
				requestId = RestAdapter.writeFileToPolling(
						username,
						password,
						getPollingHdrMetadata("INITLOAD"),
						PollingDestMetadata.createDestinationList(storeList),
						PollingFileMetadata.create(filename));
				System.out.println(requestId + " Polling information sent to stores :" + storeList);
			} catch (Exception e) {
				e.printStackTrace();
				requestId = e.getMessage() + "Exception in the RestAdapter calling method section.";
			}
		}
		return requestId;
	}

	public String callPollingInitMethod(String ccnFileName, String ccnRequestId, String costCentersList) {
		filename = ccnFileName;
		prevRequestId = ccnRequestId;
		List<String> newStrList = new ArrayList<String>(Arrays.asList(costCentersList.split(",")));
		String requestId = callPollingInitMethod(newStrList);
		return requestId;
	}
	
	public String callPollingMethod(String ccnFileName, String ccnRequestId){
		filename = ccnFileName;
		prevRequestId = ccnRequestId;
		String requestId = callPollingMethod();
		return requestId;
	}

	public static String callPollingMethod() {
		String requestId = "";
		String PrmStoreNbr = "";
		List<String> PltStoreList = new ArrayList<String>();
		PollingDestMetadata pollingMetadata;
		String fileExists = UtilityProcess.fileExists(filename);
		if (fileExists.equals("FILE_EXISTS")) {
			try {
				if (application.matches("PARAM|TAXCURR")){
					// Read and get the store number from XML file name to pass for polling
					String storeNumber = filename.substring(filename.length()-32,filename.length()-26);
					List<String> storeList = new ArrayList<String>();
					//storeList.add(storeNumber.substring(2, 6));
					//Commented above line as we are moving from 4 digit to 6 digit cost center while invoking Polling 2.0 API : jxc517 on 4/23/2019
					storeList.add(storeNumber);
					if (pilotPhaseIndicator.equalsIgnoreCase("Y")){
						//For pilot phase, we need to check the PARAM cost center that came in is part of web service or not
						//We process it only if it is part of the web service
						System.out.println("Pilot phase");
						PltStoreList = WebServiceProcess.getAppStoresAsList(application);
						PrmStoreNbr = storeNumber.substring(2, 6);
						if (!PltStoreList.contains(PrmStoreNbr)) {
							//This is very important as for pilot phase as
							//we exit out of this procedure here itself if cost center is not part of web service
							return requestId;
						}
					}else{
						System.out.println("Non Pilot phase");
					}
					pollingMetadata = PollingDestMetadata.createDestinationList(storeList);
				} else if (pilotPhaseIndicator.equalsIgnoreCase("Y") && application.matches("STORE|TERR|PrimeSub")){
					System.out.println("Pilot phase");
					PltStoreList = WebServiceProcess.getAppStoresAsList(application);
					pollingMetadata = PollingDestMetadata.createDestinationList(PltStoreList);
				} else {
					System.out.println("Non Pilot phase");
					// createDestinationFullChain        - Original Destination
					// createDestinationFullChainWithCis - New destination (probably interim)
					pollingMetadata = PollingDestMetadata.createDestinationFullChainWithCis();
				}
				requestId = RestAdapter.writeFileToPolling(
						username,
						password,
						getPollingHdrMetadata("MAINTENANCE"),
						pollingMetadata,
						PollingFileMetadata.create(filename));
				if (application.equals("PARAM")){
					System.out.println(" Polling information sent to stores :" + PrmStoreNbr);
				} else {
					System.out.println(" Polling information sent to stores :" + PltStoreList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				requestId = e.getMessage() + ". Exception in the RestAdapter calling method section.";
			}
		} else {
			requestId = "Error - Invalid file path provided.";
		}
		return requestId;
	}

	private static PollingHeaderMetadata getPollingHdrMetadata(String loadType)  {
		// This method by natural selection uses the DEV environment. Later, it checks to see if the 
		// environment matches with QA or PROD. If the match is found, the selection is changed to the 
		// corresponding environment gets picked. else, dev becomes the forced selection. This is used
		// only for NON INIT LOADS
		PollingHeaderMetadata pollingHdrMetadata;
		String env = Environment.dev.name();
		if (environment.equals("QA")) {
			env = Environment.qa.name();
		} else if (environment.equals("PROD")) {
			env = Environment.prod.name();
		}
		if (prevRequestId.equals("NULL_RQST_ID")) {
			//This is the first request for that app/cost center combination, so pass equivalent id
			System.out.println("Initial Load process with out prerequisite and equivalent id to " + env + " environment");
			pollingHdrMetadata = PollingHeaderMetadata.create(env, application);
		} else{
			if(loadType.equals("INITLOAD")){
				//This is a pilot stores New Grp Load/New store load
				//So pass equivalent id
				System.out.println("Passing equivalent ID to " + env + " environment : "+prevRequestId);
				pollingHdrMetadata = PollingHeaderMetadata.create(env, application, prevRequestId, FixType.equivalent_to);
			}else{
				//This is an actual maintenance, pass prerequisite id
				System.out.println("Passing prerequisite ID to " + env + " environment : "+prevRequestId);
				pollingHdrMetadata = PollingHeaderMetadata.create(env, application, Prerequisite.REQUIREMENTS.afterRequest(prevRequestId));
			}
		}
		return pollingHdrMetadata;
	}
}