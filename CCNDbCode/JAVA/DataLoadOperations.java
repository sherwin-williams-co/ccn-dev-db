package com.batches;

import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import com.batches.FixedWidthFile;
import com.csvreader.CsvReader;

public class DataLoadOperations {
	public static String isDataloadNeeded;
	public static String dataLoadFilePath;
	public static String dataLoadFileName;
	public static Character dataLoadFileDelimiter;
	public static String dataLoadFileTable;
	public static String[] columnWidthsList;

	public static void loadDataFile() {
		Character c1 = new Character('N');
		if(dataLoadFileDelimiter.equals(c1)) {
			loadFixedLengthFile();
		}else {
			loadDelimitedFile();
		}
	}
	public static void loadDelimitedFile() {
		CsvReader table = null;
		try {
			table = new CsvReader(dataLoadFilePath+dataLoadFileName, dataLoadFileDelimiter);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		DatabaseOperations.loadDataFile(table, dataLoadFileTable);
		table.close();
	}
	public static void loadFixedLengthFile() {
		columnWidthsList = ConfigPropertiesOperations.propJobs.getProperty(ConfigPropertiesOperations.executingJob+".dataload.colWidthList").split(":");
//		String[] columnWidthsList = "5:7:2:2:4:4:11:2:6:6:3:1:4:4:1:9:2:3:1".split(":");
		List<Integer> ncolumnWidths  = new ArrayList<>();
		for (String s1: columnWidthsList) {
			ncolumnWidths.add(Integer.parseInt(s1));
		}
//		FixedWidthFile file = new FixedWidthFile("C://Users//jxc517//OneDrive - Sherwin-Williams//Desktop//git//STBD0601_PAID_D191104_T110500.TXT", ncolumnWidths);
		FixedWidthFile table = new FixedWidthFile(dataLoadFilePath+dataLoadFileName, ncolumnWidths);
//		System.out.println(file.tokens());
		DatabaseOperations.loadDataFile(table, dataLoadFileTable);
	}
	public static void loadDataloadFileDetails(){
		String executingJob = ConfigPropertiesOperations.executingJob;
		Properties propJobs = ConfigPropertiesOperations.propJobs;
		isDataloadNeeded = propJobs.getProperty(executingJob+".dataload.required");
		if (isDataloadNeeded.equalsIgnoreCase("Y")){
			dataLoadFileTable = propJobs.getProperty(executingJob+".dataload.table");
			dataLoadFileDelimiter = propJobs.getProperty(executingJob+".dataload.delimiter").charAt(0);
			dataLoadFilePath = propJobs.getProperty(executingJob+".dataload.path");
			dataLoadFileName = propJobs.getProperty(executingJob+".dataload.fileName")
					              .replace("YYYYMMDDHHMISS",new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()))
					              .replace("YYYYMMDD",new SimpleDateFormat("yyyyMMdd").format(new Date()));
		}
	}
}
