package com.bee.beeMarket.commons.util;

import java.security.MessageDigest;

public class MessageDigestUtil {

	//비밀번호 암호화:SHA-1
			public static String getPasswordHashing(String password) {
				String hashcode=null;
				
				StringBuilder sb = new StringBuilder();
				try {
					MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");

					messageDigest.reset();
					messageDigest.update(password.getBytes("UTF-8"));

					byte[] chars = messageDigest.digest();

					for (int i = 0; i < chars.length; i++) {
						String tmp = Integer.toHexString(0xff & chars[i]);
						if (tmp.length() == 1)
							sb.append("0");
						sb.append(tmp);
					}
					hashcode = sb.toString();
					
				} catch (Exception e) {
					e.printStackTrace();
				}

				return hashcode;
			}
}
