package com.fpoly.coffeeshop.util;

import java.util.ResourceBundle;

public class DomainUtil {

	public static String getDoamin() {
		ResourceBundle resourceBundle = ResourceBundle.getBundle("url");
		
		String result = resourceBundle.getString("domain.api");
		
		return result;
	}
	
}
