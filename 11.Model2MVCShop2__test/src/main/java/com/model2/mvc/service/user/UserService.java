package com.model2.mvc.service.user;

import java.util.HashMap;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface UserService {
	
	// 회원가입
	public void addUser(User user) throws Exception;
	
	// 내정보확인 / 로그인
	public User getUser(String userId) throws Exception;
	
	// 회원정보리스트 
	public Map<String , Object> getUserList(Search search) throws Exception;
	
	// 회원정보수정
	public void updateUser(User user) throws Exception;
	
	// 회원 ID 중복 확인
	public boolean checkDuplication(String userId) throws Exception;

	public void certifiedPhoneNumber (String userPhoneNumber, int randomNumber) throws Exception ;

 	public String getAccessToken(String authorize_code) throws Exception ;
 	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception ; 
 	
}