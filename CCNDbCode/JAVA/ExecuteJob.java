package com.batches;

import java.sql.Savepoint;
import static java.lang.System.err;

public class ExecuteJob{
	public static void main(String[] args){
		/*
		 * Development COSTCNTR GNRT_STORE_BANK_CARD_SERIAL_FL
		 * Development COSTCNTR GNRT_STORE_BANK_CARD_MRCHNT_FL
		 * Development COSTCNTR RELEASE_TIMED_OUT_OBJECTS
		 * Development COSTCNTR CCN_HIERARCHY_FUTURE_TO_CURRENT
		 * Development CSTMR_DPSTS CSTMR_DEP_DAILY_LOAD
		 * Development CSTMR_DPSTS cstmr_dep_zero_net_close_dt_upd
		 * Development COSTCNTR delimitedCSVFileJobTesting
		 * Development STORDRFT ROYAL_BANK_PAIDS_UPDATE
		 * Development STORDRFT SUNTRUST_BANK_PAIDS_UPDATE
		 */
		if (args.length != 3 || 
				!args[0].matches("Development|Test|QA|Production") || 
				!args[1].matches("COSTCNTR|STORDRFT|FLDPRRPT|BANKING|CSTMR_DPSTS|CCN_UTILITY")) {
			err.format("Usage: java com.batches.ExecuteJob <execution-environmant> <app-db-user> <job-name> %n");
			err.format("<execution-environmant> (argument 1) should be Development (or) Test (or) QA (or) Production %n");
			err.format("<app-db-user>           (argument 2) should be COSTCNTR (or) STORDRFT (or) FLDPRRPT (or) BANKING (or) CSTMR_DPSTS (or) CCN_UTILITY %n");
			err.format("Example: java com.batches.ExecuteJob Development COSTCNTR CCN_HIERARCHY_FUTURE_TO_CURRENT %n");
			err.format("Example: java com.batches.ExecuteJob Development CSTMR_DPSTS cstmr_dep_zero_net_close_dt_upd %n");
			System.exit(-1);
		}else {
			try{
				ConfigPropertiesOperations.executingEnvironment=args[0];
				ConfigPropertiesOperations.executingDatabaseUser=args[1];
				ConfigPropertiesOperations.executingJob=args[2];
				ConfigPropertiesOperations.load();
				System.out.println("Connecting to database : "+ 
						ConfigPropertiesOperations.prop.getProperty(ConfigPropertiesOperations.executingDatabaseUser + ".dbuser") + "/" + 
						ConfigPropertiesOperations.prop.getProperty(ConfigPropertiesOperations.executingDatabaseUser + ".dbpwd") + "@" + 
						ConfigPropertiesOperations.prop.getProperty("dbconn"));
				DatabaseOperations.setConnection(
						ConfigPropertiesOperations.prop.getProperty(ConfigPropertiesOperations.executingDatabaseUser + ".dbuser"), 
						ConfigPropertiesOperations.prop.getProperty(ConfigPropertiesOperations.executingDatabaseUser + ".dbpwd"), 
						ConfigPropertiesOperations.prop.getProperty("dbconn"));
				System.out.println("Setting autocommit to false");
				DatabaseOperations.conn.setAutoCommit(false);
				System.out.println("Establishing save point svpt1");
				Savepoint spt1 = DatabaseOperations.conn.setSavepoint("svpt1");
				try{
					if (DataLoadOperations.isDataloadNeeded.equalsIgnoreCase("Y")){
						System.out.println("Loading the file "+ DataLoadOperations.dataLoadFileName +" under "+ DataLoadOperations.dataLoadFilePath + " path into table : " + DataLoadOperations.dataLoadFileTable);
						DataLoadOperations.loadDataFile();
					}
					if(DatabaseOperations.dbCallRequired.equalsIgnoreCase("Y")) {
						if(DatabaseOperations.dbCallParamsExists.equalsIgnoreCase("Y")){
							if(DatabaseOperations.dbCallType.equalsIgnoreCase("1")){
								System.out.println("Executing DB Call Type 1 -> " + DatabaseOperations.dbCall + " with parameters : " + DatabaseOperations.dbCallParam1);
								DatabaseOperations.execProcStringIpClobOpFileNmOp(DatabaseOperations.dbCall, DatabaseOperations.dbCallParam1);
								System.out.println("Creating file on server location -> " + ConfigPropertiesOperations.prop.getProperty("defaultDataPath")+FileOperations.fileName);
								FileOperations.writeToFile(ConfigPropertiesOperations.prop.getProperty("defaultDataPath"));
							}else if(DatabaseOperations.dbCallType.equalsIgnoreCase("2")){
								System.out.println("Executing DB Call Type 2 -> " + DatabaseOperations.dbCall + " with parameters : " + DatabaseOperations.dbCallParam1);
								DatabaseOperations.execProcStringIpNoOp(DatabaseOperations.dbCall, DatabaseOperations.dbCallParam1);
							}
						}else if(DatabaseOperations.dbCallParamsExists.equalsIgnoreCase("N")){
							if(DatabaseOperations.dbCallType.equalsIgnoreCase("4")){
								System.out.println("Executing DB Call Type 4 -> " + DatabaseOperations.dbCall + " with out any parameters");
								DatabaseOperations.execProcNoIpClobOpFileNmOp(DatabaseOperations.dbCall);
								System.out.println("Creating file on server location -> " + ConfigPropertiesOperations.prop.getProperty("defaultDataPath")+FileOperations.fileName);
								FileOperations.writeToFile(ConfigPropertiesOperations.prop.getProperty("defaultDataPath"));
							}else if(DatabaseOperations.dbCallType.equalsIgnoreCase("3")){
								System.out.println("Executing DB Call Type 3 -> " + DatabaseOperations.dbCall + " with out any parameters");
								DatabaseOperations.executeProcedureNoIO(DatabaseOperations.dbCall);
							}
						}
					}
					System.out.println("Committing the database transaction");
					DatabaseOperations.conn.commit();
					if (EmailOperations.isMailNeeded.equalsIgnoreCase("Y")){
						System.out.println("Emailing the file as per category : " + EmailOperations.mailCategory);
						EmailOperations.execute();
					}
					if (FileOperations.isFTPNeeded.equalsIgnoreCase("Y")){
						System.out.println("FTP'ing the file as "+FileOperations.ftpDestFilePath+FileOperations.ftpDestFileName+" to "+FileOperations.ftpServerName+" server");
						FileOperations.TransferFile(ConfigPropertiesOperations.prop.getProperty("defaultDataPath"));
					}
				}catch(Exception e){
					e.printStackTrace();
					DatabaseOperations.conn.rollback(spt1);
					System.err.println(e.getMessage());
					System.exit(1);
				}
			} catch(Exception e) {
				e.printStackTrace();
				System.err.println(e.getMessage());
				System.exit(2);
			}finally{
				try{
					DatabaseOperations.closeConnection();
					System.out.println("Closing the database connection");
				}catch(Exception e) {
					e.printStackTrace();
					System.err.println(e.getMessage());
					System.exit(3);
				}
			}			
		}
	}
}
