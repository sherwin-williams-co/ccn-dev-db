package com.webservice;

public class PollingRequest {

	public static void main(String[] args) throws Exception {

		String requestId = "";

		if (args.length == 4) {
			Call_PollingMethod cpm = new Call_PollingMethod(args[0], args[1],
					args[2], args[3]);
			requestId = cpm.callPollingMethod();
			System.out.println(requestId);

		} else {
			System.out.println("Invalid Number of arguments passed.");
		}

	}
	
}
