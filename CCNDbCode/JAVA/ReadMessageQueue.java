package com.webservice;
//*******************************************************************************
//This function prints the stores list from the Queue
//
//Created : 06/14/2017 rxv940 CCN Project....
//Changed :
//*******************************************************************************/
import java.net.URL;

import javax.jms.Connection;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import com.ibm.mq.jms.MQConnectionFactory;

public class ReadMessageQueue {

    public static void main(String[] args) throws Exception {
    	if (args.length == 3) {
	        MQConnectionFactory f = new MQConnectionFactory();
	        f.setCCDTURL(new URL("file:///"+args[0]));
	        f.setQueueManager(args[1]);
	        long waitMillis = 1000L;
	        String out_message = "";
	        try {
	        	Connection conn = f.createConnection();
	        	try {
	        		Session session = conn.createSession(true, Session.AUTO_ACKNOWLEDGE);
	                MessageConsumer consumer = session.createConsumer(session.createQueue(args[2]));
	                conn.start();              
	                for (Message m = consumer.receive(waitMillis); m != null; m = consumer.receive(waitMillis)) {                	
	                    TextMessage tm = (TextMessage) m;
	                    out_message = tm.getText();
	                    if (out_message.length() > 0) {
	                    	System.out.println(out_message);
	                    } 
	                }
	                session.commit();
	            } catch (Exception e) {
	            	e.printStackTrace();
				}
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
    } else {
		System.out.println("Invalid Number of arguments passed.");
    }
}

}
  