package com.batches;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

public class FileOperations {
	public static String isFTPNeeded;
	public static String ftpServerName;
	public static String ftpUserName;
	public static String ftpPassword;
	public static String ftpDestFilePath;
	public static String ftpDestFileName;
	public static String fileName = null;
	public static String clobData = null;

	public static void TransferFile(String filePath){
		JSch jsch = new JSch();
		Session session = null;	
		try {
			session = jsch.getSession(ftpUserName, ftpServerName, 22);
			session.setConfig("StrictHostKeyChecking", "no");
			session.setPassword(ftpPassword);
			session.connect();
			Channel channel = session.openChannel("sftp");
			channel.connect();
			ChannelSftp sftpChannel = (ChannelSftp) channel;
			sftpChannel.put(filePath+fileName, ftpDestFilePath+ftpDestFileName);
			sftpChannel.disconnect();
			session.disconnect();            
		} catch (JSchException e) {
			e.printStackTrace();
			System.err.println(e.getMessage()); 
		} catch (SftpException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}
	}

	public static void setLocalFileModficationTime(SftpATTRS attrs, String filePath) {
		SimpleDateFormat format = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
		try {
			Date modDate = (Date) format.parse(attrs.getMtimeString());
			File downloadedFile = new File(filePath);
			downloadedFile.setLastModified(modDate.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}
	}
	public static void writeToFile(String filePath) {
		Writer wrtr = null;
		try {
			File statText = new File(filePath+fileName);
			FileOutputStream inputStream = new FileOutputStream(statText);
			OutputStreamWriter osw = new OutputStreamWriter(inputStream);    
			wrtr = new BufferedWriter(osw);
			wrtr.write(clobData);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}finally{
			try {
				wrtr.close();
			} catch (IOException e) {
				e.printStackTrace();
				System.err.println(e.getMessage());
			}	
		}
	}
	public static void loadFTPDetails(){
		String executingJob = ConfigPropertiesOperations.executingJob;
		Properties propJobs = ConfigPropertiesOperations.propJobs;
		isFTPNeeded = propJobs.getProperty(executingJob+".ftp.required");
		if (isFTPNeeded.equalsIgnoreCase("Y")){
			ftpServerName = propJobs.getProperty(executingJob+".ftp.serverName");
			ftpUserName = propJobs.getProperty(executingJob+".ftp.user");
			ftpPassword = propJobs.getProperty(executingJob+".ftp.password");
			ftpDestFilePath = propJobs.getProperty(executingJob+".ftp.path");
			ftpDestFileName = propJobs.getProperty(executingJob+".ftp.fileName")
					              .replace("YYYYMMDDHHMISS",new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()))
					              .replace("YYYYMMDD",new SimpleDateFormat("yyyyMMdd").format(new Date()));
		}
	}
}
