package com.batches;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailOperations{
	public static String isMailNeeded;
	public static String mailCategory;
	public static String from;
	public static String to;
	public static String subject;
	public static String body;
	public static String signature;

	public static void execute(){
		Properties props = new Properties();
		//	      props.put("mail.smtp.auth", "true");
		//	      props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", ConfigPropertiesOperations.prop.getProperty("mailHost"));
		props.put("mail.smtp.port", ConfigPropertiesOperations.prop.getProperty("mailPort"));
		Session session = Session.getDefaultInstance(props);
		try {
			// Create a default MimeMessage object.
			Message message = new MimeMessage(session);
			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));
			// Set To: header field of the header.
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			// Set Subject: header field
			message.setSubject(ConfigPropertiesOperations.executingEnvironment+" : "+subject);
			// Create the message part
			BodyPart messageBodyPart = new MimeBodyPart();
			// Now set the actual message
			messageBodyPart.setText(body+"\n\n"+signature);
			// Create a multipar message
			Multipart multipart = new MimeMultipart();
			// Set text message part
			multipart.addBodyPart(messageBodyPart);
			// Part two is attachment
			messageBodyPart = new MimeBodyPart();
			String filename = ConfigPropertiesOperations.prop.getProperty("defaultDataPath") + FileOperations.fileName;
			DataSource source = new FileDataSource(filename);
			messageBodyPart.setDataHandler(new DataHandler(source));
			messageBodyPart.setFileName(FileOperations.fileName);
			multipart.addBodyPart(messageBodyPart);
			// Send the complete message parts
			message.setContent(multipart);
			// Send message
			Transport.send(message);
			System.out.println("Sent message successfully....");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	public static void setMailingInfo(String mailCategory){
		try{
			System.out.println("Connecting to database : "+
					ConfigPropertiesOperations.prop.getProperty("CCN_UTILITY.dbuser") + "/" + 
					ConfigPropertiesOperations.prop.getProperty("CCN_UTILITY.dbpwd") + "@" + 
					ConfigPropertiesOperations.prop.getProperty("dbconn"));
			DatabaseOperations.setConnection(
					ConfigPropertiesOperations.prop.getProperty("CCN_UTILITY.dbuser"),
					ConfigPropertiesOperations.prop.getProperty("CCN_UTILITY.dbpwd"),
					ConfigPropertiesOperations.prop.getProperty("dbconn"));
			try{
				System.out.println("Executing procedure with parameters -> " + mailCategory);
				DatabaseOperations.getMailingInfo(mailCategory);
			}catch(Exception e){
				System.out.println(e.getMessage());
				//send mail
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try{
				System.out.println("Closing the database connection");
				DatabaseOperations.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
				System.err.println(e.getMessage());
			}
		}
	}

	public static void loadMailingDetails(){
		String executingJob = ConfigPropertiesOperations.executingJob;
		Properties propJobs = ConfigPropertiesOperations.propJobs;
		isMailNeeded = propJobs.getProperty(executingJob+".mailing.required");
		if (isMailNeeded.equalsIgnoreCase("Y")){
			mailCategory = propJobs.getProperty(executingJob+".mailing.category");
			setMailingInfo(mailCategory);
		}
	}
}