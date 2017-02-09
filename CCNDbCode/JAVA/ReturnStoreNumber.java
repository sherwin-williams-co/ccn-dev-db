package com.webservice;

import java.io.File;
import java.io.IOException;
import java.util.List;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

public class ReturnStoreNumber {	

	static String return_Store_Number(String filePath, String parentNode, String elementName)  {
		SAXBuilder builder = new SAXBuilder();
		File xmlFile = new File(filePath);
		String storeNumber = "test";
		Document document;
		try {
			document = builder.build(xmlFile);
			Element rootNode = document.getRootElement();
			List list = rootNode.getChildren(parentNode); 
			
			for (int i = 0; i < list.size(); i++) { 
				Element node = (Element) list.get(i);
				storeNumber = node.getChildText(elementName);
			}
		} catch (JDOMException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return storeNumber;
		

	}

}