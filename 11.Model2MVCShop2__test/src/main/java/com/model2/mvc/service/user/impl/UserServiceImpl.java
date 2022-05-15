package com.model2.mvc.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import com.model2.mvc.service.user.UserDao;;


//==> 회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	
	//
	 
	public String getAccessToken(String authorize_code) throws Exception {
		System.out.println("service에 왔음 ");
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";  
		/// /토큰 가져와

		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id=f0b36852932e865ae00c9ff2fcd19874&"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8080/user/kakaoLogin"); // 본인이 설정한 주소
            
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
            
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
		//통신 결과가 200이어야 OK
	}
	
	
	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String , Object > getUserList(Search search) throws Exception {
		List<User> list= userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}

	@Override
	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) throws Exception {
		
		System.out.println("certifiedPhoneNumber 에옴 " + userPhoneNumber  ) 	;
		System.out.println("randomNumber 에옴 " + randomNumber  ) 	;
	
		String api_key = "NCSX1AN2GVPGAKYQ"; 
		String api_secret = "VU56XMOI4OLSANYT4OD1LQJUVNOSS9KN";
	
		Message coolsms = new Message(api_key, api_secret); 
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>(); 
		params.put("to", userPhoneNumber); 
		// 수신전화번호 
		params.put("from", "01028382468");
		// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS"); params.put("text", "[TEST] 인증번호는" + "["+randomNumber+"]" + "입니다."); 
		// 문자 내용 입력
		params.put("app_version", "test app 1.2");
		// application name and version
		try { 
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString()); 
			System.out.println("아마 성공 한듯 ");
			} catch (CoolsmsException e) {
				System.out.println(e.getMessage());
				System.out.println(e.getCode()); 
			 e.printStackTrace() ;
		}

 		
	}

	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

 			String email = kakao_account.getAsJsonObject().get("email").getAsString();

 			userInfo.put("email", email);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}

}