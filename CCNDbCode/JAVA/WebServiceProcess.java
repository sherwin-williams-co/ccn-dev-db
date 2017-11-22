package com.polling.downloads;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.rmi.RemoteException;
import javax.xml.rpc.holders.StringHolder;
import p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps;
import p2storelkup.sherwin_p2storelkup.holders.POLLING2_APPSHolder;
import sherwin_p2storelkup.P2StorelkupObjProxy;

public class WebServiceProcess {
	private static StringHolder getAppStores(String inpAppId) {
		String inpStore_nbr = "";
		Date inpEffDt = new Date();
		StringHolder storeList = new StringHolder();
		StringHolder result = new StringHolder();
		StringHolder appList  = new StringHolder();
		try {
			POLLING2_APPSTt_polling2_apps apps = 
				new POLLING2_APPSTt_polling2_apps(inpStore_nbr, inpAppId, inpEffDt);
			p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[] valueApps =
				new p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[1];
			valueApps[0] = apps;
			POLLING2_APPSHolder POLLING2_APPS = new POLLING2_APPSHolder(valueApps);
			P2StorelkupObjProxy wat = new P2StorelkupObjProxy();
			wat.p2Storelkup(inpStore_nbr, inpAppId, result, POLLING2_APPS, storeList, appList);
		} catch (RemoteException e) { 	
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();	
		}
		return storeList;
	}
	public static String getAppStoresAsString(String inpAppId) {
		String appStoreList = null;
		StringHolder storeList  = getAppStores(inpAppId);
		appStoreList = Arrays.toString(storeList.value.split("\\s*,\\s*"));
		//Example : [9934, 9950, 9954, 9958, 9959, 9969, 9972, 9989]
		System.out.println(" Stores in WebService for application "+inpAppId+" : " + appStoreList);
		return appStoreList;
	}
	public static List<String> getAppStoresAsList(String inpAppId) {
		List<String> appStoreList = null;
		StringHolder storeList  = getAppStores(inpAppId);
		appStoreList = Arrays.asList(storeList.value.split("\\s*,\\s*"));
		//Example : [9934, 9950, 9954, 9958, 9959, 9969, 9972, 9989]
		System.out.println(" Stores in WebService for application "+inpAppId+" : " + appStoreList);
		return appStoreList;
	}
}
