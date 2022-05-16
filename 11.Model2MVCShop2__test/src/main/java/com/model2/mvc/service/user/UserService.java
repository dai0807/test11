package com.model2.mvc.service.user;

import java.util.HashMap;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;


//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition  
public interface UserService {
	
	// ȸ������
	public void addUser(User user) throws Exception;
//	public void addKUser(User user) throws Exception;

	// ������Ȯ�� / �α���
	public User getUser(String userId) throws Exception;
	
	// ȸ����������Ʈ 
	public Map<String , Object> getUserList(Search search) throws Exception;
	
	// ȸ����������
	public void updateUser(User user) throws Exception;
	
	// ȸ�� ID �ߺ� Ȯ��
	public boolean checkDuplication(String userId) throws Exception;

	public void certifiedPhoneNumber (String userPhoneNumber, int randomNumber) throws Exception ;

 	public String getAccessToken(String authorize_code) throws Exception ;
 	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception ; 
 	
}