package com.polling.downloads;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

public class UtilityProcess {
	public static List<String> readFile(String filename)  {
		// The .queue file is passed as an input parameter to this method
		// which reads the .queue file and creates a list of stores
		List<String> records = new ArrayList<String>();
		try{
			BufferedReader reader = new BufferedReader(new FileReader(filename));
			String line;
			while ((line = reader.readLine()) != null){
				records.add(line);
			}
			reader.close();
			return records;
		}catch (Exception e){
			System.err.format("Exception occurred trying to read '%s'.", filename);
			e.printStackTrace();
			return null;
		}
	}

	public static String fileExists(String filepath) {
		// Below method checks to see if the file given in the 
		// input parameter exists. 
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

	public static void writeToFile(String inFileName, String fileContents) {
		Writer wrtr = null;
		try {
			File statText = new File(inFileName);
			FileOutputStream inputStream = new FileOutputStream(statText);
			OutputStreamWriter osw = new OutputStreamWriter(inputStream);    
			wrtr = new BufferedWriter(osw);
			wrtr.write(fileContents);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				wrtr.close();
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
	}
}
