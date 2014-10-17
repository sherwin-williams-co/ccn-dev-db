package com.businessobjects.samples;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import com.crystaldecisions.sdk.occa.report.application.DBOptions;
import com.crystaldecisions.sdk.occa.report.application.ReportClientDocument;
import com.crystaldecisions.sdk.occa.report.data.ConnectionInfo;
import com.crystaldecisions.sdk.occa.report.data.Fields;
import com.crystaldecisions.sdk.occa.report.data.IConnectionInfo;
import com.crystaldecisions.sdk.occa.report.document.PaperOrientation;
import com.crystaldecisions.sdk.occa.report.exportoptions.ExportOptions;
import com.crystaldecisions.sdk.occa.report.exportoptions.ReportExportFormat;
import com.crystaldecisions.sdk.occa.report.lib.PropertyBag;
import com.crystaldecisions.sdk.occa.report.lib.ReportSDKException;

public class CrystalExportExampleStrdrft
{
  public static void main(String[] args)
  {
    FileOutputStream fos = null;
    try
    {
      String reportName = args[0];
      String outputReportName = args[1];
      String login = args[2];
      String password = args[3];
      String startDate = args[4];
      String endDate = args[5];

      String flag = args[6];

      ReportClientDocument reportClientDocument = new ReportClientDocument();
      reportClientDocument.setReportAppServer("inproc:jrc");
      reportClientDocument.open(reportName, 8388608);

		//Below code was added to change connection string dynamically during run time
	    String driver = "oracle.jdbc.driver.OracleDriver";
	    String dbClient = "jdbc:oracle:thin";
	    String dbName = args[7]; //"SWPAYD.DEV.CORP.SHERWIN.COM";
	    String ipAddress = args[8]; //"@corpdbqa";
	    String portNumber = args[9]; //"1521";
	    String preQEServer = dbClient+":@"+ipAddress+":"+portNumber+"/"+dbName;
	    //System.out.println(preQEServer);
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

      if (flag.equals("1"))
      {
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "startDate", ParseDatePrompt("Date(" + startDate + ")"));
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "endDate", ParseDatePrompt("Date(" + endDate + ")"));
      }
      else if (flag.equals("2"))
      {
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "startDate", ParseDatePrompt("Date(" + startDate + ")"));
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "endDate", ParseDatePrompt("Date(" + endDate + ")"));
      }
      else if (flag.equals("3"))
      {
        DateFormat df1 = new SimpleDateFormat("yyyy,mm,dd");
        String sdate = df1.format(ParseDatePrompt("Date(" + startDate + ")"));
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "startDate", sdate);
        
        DateFormat df2 = new SimpleDateFormat("yyyy,mm,dd");
        String edate = df2.format(ParseDatePrompt("Date(" + endDate + ")"));
        reportClientDocument.getDataDefController().getParameterFieldController().setCurrentValue("", "endDate", edate);
      }

      reportClientDocument.getPrintOutputController().modifyPaperOrientation(PaperOrientation.landscape);

      ExportOptions exportOptions = new ExportOptions();

      exportOptions.setExportFormatType(ReportExportFormat.PDF);

      InputStream reportInputStream = reportClientDocument.getPrintOutputController().export(exportOptions);

      fos = new FileOutputStream(outputReportName);

      byte[] data = new byte[1000];
      int nRead = 0;
      while ((nRead = reportInputStream.read(data)) != -1)
      {
        fos.write(data, 0, nRead);
      }

      fos.close();
    }
    catch (ReportSDKException e)
    {
      e.printStackTrace();
      try
      {
        if (fos != null) {
          fos.close();
        }
      }
      catch (IOException e1)
      {
        e1.printStackTrace();
      }
    }
    catch (IOException e)
    {
      e.printStackTrace();
      try
      {
        if (fos != null) {
          fos.close();
        }
      }
      catch (IOException e1)
      {
        e1.printStackTrace();
      }
    }
    finally
    {
      try
      {
        if (fos != null) {
          fos.close();
        }
      }
      catch (IOException e)
      {
        e.printStackTrace();
      }
    }
  }

  public static Date ParseDatePrompt(String dateToParse)
  {
    try
    {
      String sDate = dateToParse.substring(dateToParse.indexOf("(") + 1);
      sDate = sDate.substring(0, sDate.lastIndexOf(")"));
      StringTokenizer st = new StringTokenizer(sDate, ",");
      Calendar cal = Calendar.getInstance();
      cal.set(Integer.valueOf(st.nextToken()).intValue(), 
        Integer.valueOf(st.nextToken()).intValue(), 
        Integer.valueOf(st.nextToken()).intValue());
      return cal.getTime();
    }
    catch (Exception localException)
    {
    }

    return new Date();
  }
}