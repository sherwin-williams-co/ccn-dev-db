package com.giftcardreport;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileInputStream;

import com.crystaldecisions.sdk.occa.report.application.DBOptions;
import com.crystaldecisions.sdk.occa.report.application.OpenReportOptions;
import com.crystaldecisions.sdk.occa.report.application.ReportClientDocument;
import com.crystaldecisions.sdk.occa.report.data.ConnectionInfo;
import com.crystaldecisions.sdk.occa.report.data.Fields;
import com.crystaldecisions.sdk.occa.report.data.IConnectionInfo;
import com.crystaldecisions.sdk.occa.report.document.PaperOrientation;
import com.crystaldecisions.sdk.occa.report.exportoptions.ExportOptions;
import com.crystaldecisions.sdk.occa.report.exportoptions.ReportExportFormat;
import com.crystaldecisions.sdk.occa.report.lib.PropertyBag;
import com.crystaldecisions.sdk.occa.report.lib.ReportSDKException;
import java.util.Properties;

@SuppressWarnings("unused")
public class GiftCardReport {

	//	@SuppressWarnings("static-access")
	public static Properties prop = new Properties();
	public static void main(String[]args)  
	{ 
		FileOutputStream fos = null;
		ReportClientDocument reportClientDocument = new ReportClientDocument();
		String reportName;
		String outputReportName;
		String login; 
		String password;

		try
		{
			//setting up parameters from the config.properties files
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);
			reportName = args[0];
			outputReportName = args[1];
			//getting parameters from the config.properties
			login = prop.getProperty("DbUser");
			password = prop.getProperty("DbPassword");

			reportClientDocument.setReportAppServer(ReportClientDocument.inprocConnectionString);
			reportClientDocument.open(reportName, OpenReportOptions._openAsReadOnly);

			//Below code was added to change connection string dynamically during run time
		    String driver = "oracle.jdbc.driver.OracleDriver";
		    String dbClient = "jdbc:oracle:thin";
		    String dbName = prop.getProperty("DbName");
		    String ipAddress = prop.getProperty("ServerName");
		    String preQEServer = dbClient+":@"+ipAddress+"/"+dbName;
		    IConnectionInfo newConnectionInfo = new ConnectionInfo();
			IConnectionInfo oldConnectionInfo = reportClientDocument.getDatabaseController().getConnectionInfos(null).getConnectionInfo(0);
			PropertyBag boPropertyBag1 = new PropertyBag();
		    boPropertyBag1.clear();

		    boPropertyBag1.put("JDBC Connection String", "!"+driver+"!"+preQEServer);
		    boPropertyBag1.put("PreQEServerName",   preQEServer);
		    boPropertyBag1.put("Server Type", "JDBC (JNDI)");
		    boPropertyBag1.put("Database DLL", "crdb_jdbc.dll");
		    boPropertyBag1.put("Database", dbName);
		    boPropertyBag1.put("Database Class Name", driver);
		    boPropertyBag1.put("Use JDBC", "true");
		    boPropertyBag1.put("Database Name", dbName);
		    boPropertyBag1.put("Server Name", preQEServer);
		    boPropertyBag1.put("Connection URL", preQEServer);
		    boPropertyBag1.put("Server", null);
		    newConnectionInfo.setAttributes(boPropertyBag1);
		    newConnectionInfo.setUserName(login);
		    newConnectionInfo.setPassword(password);
		    int replaceParams = DBOptions._ignoreCurrentTableQualifiers + DBOptions._doNotVerifyDB;
		    // Now replace the connections
		    Fields pFields = null;
		    reportClientDocument.getDatabaseController().replaceConnection(oldConnectionInfo, newConnectionInfo, pFields, replaceParams);
		    //FINISH DYNAMIC CONNECTION CHANGES DURING RUN TIME

			reportClientDocument.getDatabaseController().logon(login, password); 
			reportClientDocument.getPrintOutputController().modifyPaperOrientation(PaperOrientation.landscape);

			ExportOptions exportOptions = new ExportOptions();

			exportOptions.setExportFormatType(ReportExportFormat.PDF); //for PDF format...
			//exportOptions.setExportFormatType(ReportExportFormat.RTF); //for PDF format...	
			
			InputStream reportInputStream = reportClientDocument.getPrintOutputController().export(exportOptions);

			fos = new FileOutputStream(outputReportName);
			byte[] data = new byte[1000];
			int nRead = 0;
			while ((nRead = reportInputStream.read(data)) != -1){
				fos.write(data, 0, nRead);
			}
			fos.close();
			reportClientDocument.close();
		}	  
		catch (ReportSDKException e)
		{
			e.printStackTrace();
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		finally
		{
			try 
			{
				if (fos != null){
					fos.close();
					try {
						reportClientDocument.close();
					} catch (ReportSDKException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			catch (IOException e)
			{
				e.printStackTrace(); 
			}
		}

	} 
}