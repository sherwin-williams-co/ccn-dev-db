package com.webservice;

import java.rmi.RemoteException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.xml.rpc.holders.StringHolder;

import p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps;
import p2storelkup.sherwin_p2storelkup.holders.POLLING2_APPSHolder;
import sherwin_p2storelkup.P2StorelkupObjProxy;

public class dwnld_frm_web_srvc {
	public static void main(String[] args){
		try {
			String inpStore_nbr = "";
			String inpApp_id = args[0];
			Date inpEffDt = new Date();

			StringHolder result = new StringHolder();
			StringHolder storeList  = new StringHolder();
			StringHolder appList  = new StringHolder();

			POLLING2_APPSTt_polling2_apps apps =
				new POLLING2_APPSTt_polling2_apps(inpStore_nbr, inpApp_id, inpEffDt);
			p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[] valueApps =
				new p2storelkup.sherwin_p2storelkup.POLLING2_APPSTt_polling2_apps[1];
			valueApps[0] = apps;
			POLLING2_APPSHolder POLLING2_APPS = new POLLING2_APPSHolder(valueApps);
			P2StorelkupObjProxy wat = new P2StorelkupObjProxy();

			wat.p2Storelkup(inpStore_nbr, inpApp_id, result, POLLING2_APPS, storeList, appList);
			//System.out.println(storeList.value);
			List<String> items = Arrays.asList(storeList.value.split("\\s*,\\s*"));
			System.out.println(items);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
	}
}
