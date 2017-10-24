package com.polling.downloads;

import java.io.FileInputStream;
import java.io.InputStream;
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
	public static void main(String[] args) throws Exception{
		getQueueMessagesAsString();
	}
    public static String getQueueMessagesAsString() throws Exception {
		try {
			System.out.println("Loading configuration properties");
			InputStream input = new FileInputStream("config.properties");
			prop.load(input);
		}catch(Exception e){
			e.printStackTrace();
		}
    	System.setProperty("javax.net.ssl.keyStore",prop.getProperty("messageQueueKeyStoreUserName"));
    	System.setProperty("javax.net.ssl.trustStore",prop.getProperty("messageQueueTrustStoreUserName"));
    	System.setProperty("javax.net.ssl.keyStorePassword",prop.getProperty("messageQueueKeyStorePassword"));
    	System.setProperty("javax.net.ssl.trustStorePassword",prop.getProperty("messageQueueTrustStorePassword"));
        
    	MQConnectionFactory f = new MQConnectionFactory();
        f.setCCDTURL(new URL("file:"+prop.getProperty("messageQueueCCDTFilePath")));
        f.setQueueManager(prop.getProperty("messageQueueMgrName"));
        //f.setQueueManager("*QAGET"); //*DEVGET or *QAGET

        String messagesAsCommaSeparatedString = "";
        int msgCount = 0;
        long waitMillis = 1000L;
        try{
        	Connection conn = f.createConnection();
        	try{
        		Session session = conn.createSession(true, Session.AUTO_ACKNOWLEDGE);
        		MessageConsumer consumer = session.createConsumer(session.createQueue(prop.getProperty("messageQueueCnsmrName")));
                conn.start();
                for (Message m = consumer.receive(waitMillis); m != null; m = consumer.receive(waitMillis)) {
                    TextMessage tm = (TextMessage) m;                    if(! messagesAsCommaSeparatedString.contains(tm.getText())){
                    	messagesAsCommaSeparatedString = messagesAsCommaSeparatedString + tm.getText() + ",";
                    }
                    msgCount++;
                }  
                session.commit();
            }catch (Exception e) {
    			e.printStackTrace();
    		}
        }catch(Exception e) {
			e.printStackTrace();
        	
        }
        if (messagesAsCommaSeparatedString != null 
        		&& messagesAsCommaSeparatedString.length() > 0
        		&& messagesAsCommaSeparatedString.charAt(messagesAsCommaSeparatedString.length() - 1) == ',') {
        	messagesAsCommaSeparatedString = messagesAsCommaSeparatedString.substring(0, messagesAsCommaSeparatedString.length() - 1);
        }
        System.out.println("message : " +messagesAsCommaSeparatedString);
        return messagesAsCommaSeparatedString;
    }
}