package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.Properties;

import javax.jms.Connection;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import com.ibm.mq.jms.MQConnectionFactory;
import com.polling.dbcalls.DBConnection;

public class MessageQueueProcess {
	public static Properties prop = new Properties();
	public static void main(String[] args) throws Exception {
		// Invoke Configuration file to set properties 
		InputStream input = new FileInputStream("config.properties");
		prop.load(input);
		if (args[0].equals("downloadQueueMessages")) {
			downloadQueueMessages(args[1], args[2], args[3]);
		} else if (args[0].equals("validateQueueMessages")){
			validateQueueMessages(args[1]);
		} else if (args[0].equals("processStorePosStrtDtLoad")){
			processStorePosStrtDtLoad(args[1]);
		} else {
			System.out.println("Input argument defined by args[0] is unexpected..");
		}
	}

	public static void downloadQueueMessages(String CCDTUrl, String QueueManager, String Consumer) throws JMSException, MalformedURLException {
			MQConnectionFactory f = new MQConnectionFactory();
			f.setCCDTURL(new URL("file:///"+CCDTUrl));               
			// CCDT file (Client Channel Definition Table) - IBM-proprietary format configuration file for connection details 
			// to the different MQ environments, DEV, QA, PRODCCN-v8.ccdt
			f.setQueueManager(QueueManager);                              
			// Queue Manager is got as an input parameter 
			long waitMillis = 1000L;
			String out_message = "";
			try {
				Connection conn = f.createConnection();
				try {
					Session session = conn.createSession(true, Session.AUTO_ACKNOWLEDGE);
					MessageConsumer consumer = session.createConsumer(session.createQueue(Consumer));
					// Consumer name is also got as input.
					conn.start();
					//building a "comma-space" separated message list from queue
					for (Message m = consumer.receive(waitMillis); m != null; m = consumer.receive(waitMillis)) {                	
						TextMessage tm = (TextMessage) m;
						if(! out_message.contains(tm.getText())){
							out_message = out_message + tm.getText() + ", ";
						}
					}
					session.commit();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//Example message string read will be "1001, abcd, test, 1004, "
			//Stripping the last 2 characters from the above string
			// Do substring only when there is a message present. 
			if (out_message != null && !out_message.isEmpty()) {
				out_message = out_message.substring(0, out_message.length() - 2);
				System.out.println(out_message);
			}
	}
	
	public static String validateQueueMessages(String in_message) throws SQLException {
		//Example message string after above statement will be "1001, abcd, test, 1004"
		String validatedMessage = null;
		if (!in_message.isEmpty() && in_message.length() > 0) {
			try {
				// Connect to DB
				DBConnection.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));
				//Example input "1001, abcd, test, 1004"
				validatedMessage = DBConnection.validateQueueMessages(in_message);
				//Example output "1001, 1004"
				if (validatedMessage != null && !validatedMessage.isEmpty()) {
					System.out.println(validatedMessage);
				} 
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBConnection.closeConnection();
			}
		}
		return validatedMessage;
	}
	public static void processStorePosStrtDtLoad(String inMessage) throws SQLException {
		//Example message string after above statement will be "1001, abcd, test, 1004"
		if (!inMessage.isEmpty() && inMessage.length() > 0) {
			try {
				// Connect to DB
				DBConnection.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));
				//Example input "1001, abcd, test, 1004"
				//validatedMessage = DBConnection.process_store_pos_strt_dt_load(in_message);
				DBConnection.processStorePosStrtDtLoad(inMessage);
				//Example output "1001, 1004"
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBConnection.closeConnection();
			}
		}
	}
}