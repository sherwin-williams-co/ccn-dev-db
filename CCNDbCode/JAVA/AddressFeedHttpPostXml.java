package com.descartes.httppost;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.Map;
import java.util.Properties;

import com.descartes.dbcalls.DBConnectionDscrts;

public class AddressFeedHttpPostXml{
	public static Properties prop = new Properties();
	public static void main(String[] args){
		try{
			System.out.println("Configuring properties");
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);
			System.setProperty("https.proxyHost", prop.getProperty("swProxy"));
			System.out.println("Connecting to database");
			DBConnectionDscrts.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));
			Map<String,String> requests;
			System.out.println("Getting all the requests to process");
			requests = DBConnectionDscrts.getRequests();
			String response;
			for (Map.Entry<String, String> request : requests.entrySet()) {
				DBConnectionDscrts.conn.setAutoCommit(false);
				Savepoint spt1 = DBConnectionDscrts.conn.setSavepoint("svpt1");
				response = "about to process the request with key : " + request.getKey();
				try{
					System.out.println("Processing request GUID : "+request.getKey());
					response = postdata(prop.getProperty("descartesUrl"), request.getValue());
					System.out.println("Updating the response");
					DBConnectionDscrts.setResponse(request.getKey(), response);
					DBConnectionDscrts.conn.commit();
				}catch(Exception e){
					DBConnectionDscrts.conn.rollback(spt1);
					System.out.println(e.getMessage());
					DBConnectionDscrts.sendMail("DESCARTES_ADDR_FEED_FAIL", "Error in processing GUID "+ request.getKey() +" request "+ e.getMessage());
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			try {
				DBConnectionDscrts.sendMail("DESCARTES_ADDR_FEED_FAIL", "Error in processing the request "+e.getMessage());
			} catch (SQLException e1) {
				System.out.println(e.getMessage());
				e1.printStackTrace();
			}
		}finally{
			try{
				System.out.println("Closing the database connection");
				DBConnectionDscrts.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	public static String postdata(String urlPath, String inRequest) throws Exception {
		String responseVal = "";
		URL url = new URL(urlPath);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		//			String authStr = username + ":" + Password;
		//			String authEncoded = Base64.encodeBytes(authStr.getBytes());
		connection.setRequestMethod("POST");
		connection.setRequestProperty("Content-Type","text/xml");
		//			connection.setRequestProperty("Authorization", "Basic " + authEncoded);
		connection.setDoInput(true);
		connection.setDoOutput(true);
		PrintWriter out = new PrintWriter(connection.getOutputStream());
		out.println(inRequest);
		out.close();
		InputStream content = (InputStream)connection.getInputStream();
		BufferedReader in   = new BufferedReader (new InputStreamReader (content));
		String line;
		while ((line = in.readLine()) != null) {
			responseVal = responseVal + line;
		}
		return responseVal;
	}
}