package com.batches;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class ConfigPropertiesOperations {
	public static Properties prop = new Properties();
	public static String executingEnvironment;
	public static String executingDatabaseUser;

	public static Properties propJobs = new Properties();
	public static String executingJob;

	public static void load() throws FileNotFoundException, IOException{
		System.out.println("Configuring properties in ConfigFileProperties.load() -> "+"resources/"+executingEnvironment+".properties");
		prop.load(new FileInputStream("resources/"+executingEnvironment+".properties"));
//		prop.load(ConfigPropertiesOperations.class.getResourceAsStream("/resources/"+executingEnvironment+".properties"));
		System.out.println("Configuring properties in ConfigFileProperties.load() -> "+"resources/"+executingEnvironment+"-job.details => "+executingJob);
		propJobs.load(new FileInputStream("resources/"+executingEnvironment+"-job.details"));
//		propJobs.load(ConfigPropertiesOperations.class.getResourceAsStream("/resources/"+executingEnvironment+"-job.details"));
		System.out.println("Configuring database properties in DatabaseOperations.loadDBDetails()");
		DatabaseOperations.loadDBDetails();
		System.out.println("Configuring E-Mail properties in EmailOperations.loadMailingDetails()");
		EmailOperations.loadMailingDetails();
		System.out.println("Configuring FTP properties in FileOperations.loadFTPDetails()");
		FileOperations.loadFTPDetails();
		System.out.println("Configuring Dataload properties in DataLoadOperations.loadDataloadFileDetails()");
		DataLoadOperations.loadDataloadFileDetails();
	}
}