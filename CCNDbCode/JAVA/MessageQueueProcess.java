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
		if (args.length == 3) {
			downloadQueueMessages(args[0], args[1], args[2]);
		} else if (args.length == 1){
			validateQueueMessages(args[0]);
		} else {
			System.out.println("Invalid number of arguments");
		}
	}

	public static void downloadQueueMessages(String ccdturl, String qmgr, String cnsmr) throws JMSException, MalformedURLException {
			MQConnectionFactory f = new MQConnectionFactory();
			f.setCCDTURL(new URL("file:///"+ccdturl));               
			// CCDT file (Client Channel Definition Table) - IBM-proprietary format configuration file for connection details 
			// to the different MQ environments, DEV, QA, PRODCCN-v8.ccdt
			f.setQueueManager(qmgr);                              
			// Queue Manager is got as an input parameter 
			long waitMillis = 1000L;
			String out_message = "";
			try {
				Connection conn = f.createConnection();
				try {
					Session session = conn.createSession(true, Session.AUTO_ACKNOWLEDGE);
					MessageConsumer consumer = session.createConsumer(session.createQueue(cnsmr));
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
	
	public static String validateQueueMessages(String out_message) throws SQLException {
		//Example message string after above statement will be "1001, abcd, test, 1004"
		String validatedMessage = null;
		if (!out_message.isEmpty() && out_message.length() > 0) {
			try {
				// Invoke Configuration file to set properties
				InputStream input = new FileInputStream("config.properties");
				prop.load(input);
				// Connect to DB
				DBConnection.setConnection(prop.getProperty("dbuser"), prop.getProperty("dbpwd"), prop.getProperty("dbconn"));
				//Example input "1001, abcd, test, 1004"
				validatedMessage = DBConnection.validateQueueMessages(out_message);
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
}