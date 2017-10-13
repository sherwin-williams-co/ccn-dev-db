package com.webservice;
//*******************************************************************************
//This function returns the gets the list of stores in Web Service. Does a diff 
// against the DB and creates a COST_CEMTER_DEQUEUE.queue file based on the diff
// if any. Also, it runs the Init loads and places the .XML file on the APP server
//Created : 06/14/2017 rxv940 CCN Project....
//Changed :
//*******************************************************************************/
import java.io.*;
import java.rmi.RemoteException;
import java.sql.*;
import java.util.Arrays;
import java.util.Date;

import javax.xml.rpc.holders.StringHolder;
import p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps;
import p2storelkup.sherwin_p2storelkup.holders.POLLING2_APPSHolder;
import sherwin_p2storelkup.P2StorelkupObjProxy;

public class initLoads_WSDiff {
    private static String appName = "";
    private static String password = "";
    private static String userName = "";
    private static String dbName = "";
    private static String filePath = "";
    
    public static void main(String[] args)
    throws SQLException {
    	if (args.length == 5) {
    		appName     = args[0];
            password    = args[1];
            userName    = args[2];
            dbName      = args[3];
            filePath    = args[4];
            try {
            	//The below code gets the new stores added to the Web Service
            	String o_newStores = getWsDiff(appName, dbName, userName, password);
            	if (o_newStores != null) {
            		writeToFile("COST_CENTER_DEQUEUE.queue", o_newStores);
            		callInitLoad(appName, dbName, userName, password);
            		writeToFile("COST_CENTER_DEQUEUE.queue_trgrfile", "Trigger file to denote the completion of Init loads for Web Service diff");
            	} else {
            		System.out.println( "Warning:- No new stores found in Web Service ");
            	}            
            } finally{
            	System.out.println("Processing complete ");
            }
	    } else {
	        System.out.println("Error:- Invalid Number of arguments passed.");
	    }
    }

public static String dwnld_frm_web_srvc(String inpApp_id) {
	String items = null;
		try {
			String inpStore_nbr = "";
			//String inpApp_id = args[0];
			Date inpEffDt = new Date();

			StringHolder result = new StringHolder();
			StringHolder storeList  = new StringHolder();
			StringHolder appList  = new StringHolder();

			POLLING2_APPSTt_polling2_apps apps =
				new POLLING2_APPSTt_polling2_apps(inpStore_nbr, inpApp_id, inpEffDt);
			p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[] valueApps =
				new p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[1];
			valueApps[0] = apps;
			POLLING2_APPSHolder POLLING2_APPS = new POLLING2_APPSHolder(valueApps);
			P2StorelkupObjProxy wat = new P2StorelkupObjProxy();

			wat.p2Storelkup(inpStore_nbr, inpApp_id, result, POLLING2_APPS, storeList, appList);
			//System.out.println(storeList.value);
			items = Arrays.toString(storeList.value.split("\\s*,\\s*"));
			//System.out.println(storeList);
		} catch (RemoteException e) { 	
			e.printStackTrace();
		}
		return items;

}


public static void writeToFile(String inFileName, String fileContents) {
	
	File statText = new File(filePath+inFileName);
    FileOutputStream is = null;
	try {
		is = new FileOutputStream(statText);
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    OutputStreamWriter osw = new OutputStreamWriter(is);    
    Writer w = new BufferedWriter(osw);
    try {
		w.write(fileContents);
		w.close();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}

public static void callInitLoad(String appName, String dbName, String un, String pwd) throws SQLException {
	Connection connInit = null;
	connInit = DriverManager.getConnection(dbName, un, pwd);
	if (appName.equals("STORE")) { 
		CallableStatement cstmt = connInit.prepareCall("{call POS_DATA_GENERATION.INIT_LOAD_STORE_WS_DIFF_SP(?,?,?)}");
		cstmt.registerOutParameter(1,Types.CLOB);
		cstmt.registerOutParameter(2,Types.CLOB);
		cstmt.registerOutParameter(3,Types.CLOB);
		cstmt.executeUpdate();
	    String o_xml = cstmt.getString(1);
	    String o_reqID = cstmt.getString(2);
	    String o_fileName = cstmt.getString(3);
	    writeToFile(o_fileName, o_xml);
    	writeToFile(o_fileName.replace(".XML", ".POLLINGDONE"), o_reqID);
	    cstmt.close();
	    
	} else if (appName.equals("TERR")) { 
		CallableStatement cstmt = connInit.prepareCall("{call POS_DATA_GENERATION.INIT_LOAD_TERR_WS_DIFF_SP(?,?,?)}");
		cstmt.registerOutParameter(1,Types.CLOB);
		cstmt.registerOutParameter(2,Types.CLOB);
		cstmt.registerOutParameter(3,Types.CLOB);
		cstmt.executeUpdate();
		String o_xml = cstmt.getString(1);
	    String o_reqID = cstmt.getString(2);
	    String o_fileName = cstmt.getString(3);
	    writeToFile(o_fileName, o_xml);
    	writeToFile(o_fileName.replace(".XML", ".POLLINGDONE"), o_reqID);
	    cstmt.close();
	}
    connInit.close();
}

public static String getWsDiff(String appName, String dbName, String un, String pwd) throws SQLException {
	Connection connWs = null;
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    String ccWS = dwnld_frm_web_srvc(appName);
    //The above line calls the Web Service by passing the App and gets the list of stores 
    //in the Web Service
    connWs = DriverManager.getConnection(dbName, un, pwd);
    // The DB sub program below gets the App and list of stores in Web Service and spits out 
    // the newly created stores, if any
    CallableStatement pstmt = connWs.prepareCall("{call POS_DATA_GENERATION.WS_DIFF_BY_FILE_TYPE(?,?,?)}");
    pstmt.setString(1, appName);
    pstmt.setString(2, ccWS);
    pstmt.registerOutParameter(3,Types.CLOB);
    pstmt.executeUpdate();
    String o_ename = pstmt.getString(3);
    pstmt.close();
    connWs.close();
    return o_ename;
}

}