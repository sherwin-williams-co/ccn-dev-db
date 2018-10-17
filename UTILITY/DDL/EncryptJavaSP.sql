set define off;

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE LIKE '%JAVA%';

EXEC DBMS_JAVA.DROPJAVA('-v -u CCN_UTILITY ENCRYPTJAVASP.java');

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE LIKE '%JAVA%';

create or replace and compile java source named "EncryptJavaSP"
as
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import java.util.Base64;
 
public class EncryptJavaSP {

	public static final String DES_ENCRYPTION_SCHEME = "DES";
	private static final String UNICODE_FORMAT = "UTF8";

	private KeySpec keySpec;
	private SecretKeyFactory keyFactory;
	private Cipher cipher;


	public static String callEncrypt(String key, String id) {
		try{
			EncryptJavaSP encrypter = new EncryptJavaSP(key);
			if(id!=null && !"".equalsIgnoreCase(id) && id.length()>0)
			id = encrypter.encrypt(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return id;
	}

	public static String callDecrypt(String key, String id) {
			try{
				EncryptJavaSP encrypter = new EncryptJavaSP(key);
				if(id!=null && !"".equalsIgnoreCase(id) && id.length()>0)
				id = encrypter.decrypt(id);
			}catch(Exception e){
				e.printStackTrace();
			}
			return id;
	}

	public EncryptJavaSP(String encryptionKey) throws Exception {
		if (encryptionKey == null)
			throw new IllegalArgumentException("encryption key was null");
		if (encryptionKey.trim().length() < 24)
			throw new IllegalArgumentException("encryption key was less than 24 characters");
		try {
			byte[] keyAsBytes = encryptionKey.getBytes(UNICODE_FORMAT);
			keySpec = new DESKeySpec(keyAsBytes);
			keyFactory = SecretKeyFactory.getInstance(DES_ENCRYPTION_SCHEME);
			cipher = Cipher.getInstance(DES_ENCRYPTION_SCHEME);
		}
		catch (Exception e) {
			throw new Exception(e);
		}
	}

	private String encrypt(String unencryptedString) throws Exception {
		if (unencryptedString == null || unencryptedString.trim().length() == 0)
			throw new IllegalArgumentException("unencrypted string was null or empty");
		try {
			SecretKey key = keyFactory.generateSecret(keySpec);
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] cleartext = unencryptedString.getBytes(UNICODE_FORMAT);
			byte[] ciphertext = cipher.doFinal(cleartext);
			return Base64.getEncoder().encodeToString(ciphertext);
		}
		catch (Exception e) {
			throw new Exception(e);
		}
	}


	private String decrypt(String encryptedString) throws Exception {
		if (encryptedString == null || encryptedString.trim().length() <= 0)
			throw new IllegalArgumentException("encrypted string was null or empty");
		try {
			SecretKey key = keyFactory.generateSecret(keySpec);
			cipher.init(Cipher.DECRYPT_MODE, key);
			byte[] cleartext = Base64.getDecoder().decode(encryptedString);
			byte[] ciphertext = cipher.doFinal(cleartext);
			return bytes2String(ciphertext);
		}
		catch (Exception e) {
            throw new Exception(e);
        }
	}

	private static String bytes2String(byte[] bytes) {
		StringBuffer stringBuffer = new StringBuffer();
		for (int i = 0; i < bytes.length; i++) {
			stringBuffer.append((char)bytes[i]);
		}
		return stringBuffer.toString();
	}

}
/