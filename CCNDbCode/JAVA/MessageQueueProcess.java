package com.polling.downloads;

import java.net.URL;
import java.util.Properties;

import javax.jms.Connection;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import com.ibm.mq.jms.MQConnectionFactory;

public class MessageQueueProcess {
	public static Properties prop = new Properties();
	public static void main(String[] args) throws Exception {
		if (args.length == 3) {
			MQConnectionFactory f = new MQConnectionFactory();
			f.setCCDTURL(new URL("file:///"+args[0]));               
			// CCDT file (Client Channel Definition Table) - IBM-proprietary format configuration file for connection details 
			// to the different MQ environments, DEV, QA, PRODCCN-v8.ccdt
			f.setQueueManager(args[1]);                              
			// Queue Manager is got as an input parameter
			long waitMillis = 1000L;
			String out_message = "";
			try {
				Connection conn = f.createConnection();
				try {
					Session session = conn.createSession(true, Session.AUTO_ACKNOWLEDGE);
					MessageConsumer consumer = session.createConsumer(session.createQueue(args[2]));
					// Consumer name is also got as input. 
					conn.start();              
					for (Message m = consumer.receive(waitMillis); m != null; m = consumer.receive(waitMillis)) {                	
						TextMessage tm = (TextMessage) m;
						out_message = tm.getText();
						if (out_message.length() > 0) {
							if(! out_message.contains(tm.getText())){
								out_message = out_message + tm.getText() + ",";
							}
						} 
					}
					session.commit();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (out_message != null 
					&& out_message.length() > 0
					&& out_message.charAt(out_message.length() - 1) == ',') {
				out_message = out_message.substring(0, out_message.length() - 1);
			}
			System.out.println(out_message);
		} else {
			System.out.println("Invalid Number of arguments passed.");
		}
	}
}