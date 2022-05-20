package com.model2.mvc.web.user;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	
	@RequestMapping(value = "/uphoneCheck", method = RequestMethod.GET) 
	@ResponseBody 
	public String sendSMS(@RequestParam("phone") String userPhoneNumber ,  HttpSession session)  throws Exception { 
		// �޴��� ���ں�����
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
		//���� ���� 
		System.out.println("  randomNumber"  + randomNumber );
		userService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		 session.setAttribute("userAuth", randomNumber);
		// session.setMaxInactiveInterval(180); //180 ��
		 
		 
		 System.out.println(  session.getAttribute("userAuth")     );
		System.out.println("^_^���� ���� !! ^_^ ");
		System.out.println("���� ���°� ��!!! ");
		System.out.println("���� ���°� ��!!! ");
		System.out.println( );

		
		return Integer.toString(randomNumber); 

	}
	

	@RequestMapping(value = "/smsCertificationRequest", method = RequestMethod.GET) 
	@ResponseBody 
	public String smsCertificationRequest  (@RequestParam("phone") String userPhoneNumber ,  @RequestParam("phone2") String smsCertification ,  HttpSession session   ,HttpServletRequest request)  throws Exception { 
		
		System.out.println("�����Ϸ��� !! ");
	 // userPhoneNumber ���� ������ �޴��� ��ȣ �� 
		
		String result = "F" ;
		System.out.println("userPhoneNumber  :  " + userPhoneNumber  +"  smsCertification :  " +  smsCertification );
		System.out.println("session.getAttributeNames();" + session.getAttributeNames()     );
		
 		
		
				if( request.getSession(true).getAttribute("userAuth") != null ) {
 					System.out.println("���� �־�");
					System.out.println("  ���� ddd�� "  +  request.getSession(true).getAttribute("userAuth")  );

					String sessionP = request.getSession(true).getAttribute("userAuth").toString() ;  //  �̰� �� 
					String sessionP1 = (String )request.getSession(true).getAttribute("userAuth")  ;  //  �̰�  ���� 

					System.out.println("3333");
					System.out.println("  ���� �־� "  + sessionP);
					System.out.println("userPhoneNumber  :  " + userPhoneNumber  +"  smsCertification :  " +  smsCertification + " sessionP :" + sessionP );

					System.out.println("sessionP : " + sessionP );
						if   (      sessionP.equals(smsCertification)             ) {
							result = "T" ;
							
							}else {
								System.out.println("���� ��ġ xxxxx ");
							}
						
						
		
					
					
				}else {
					System.out.println(" ���� ���� ");
					
				}
				
				
				System.out.println("Result " + result);

		
//		// �޴��� ���ں�����
//		
//		
//		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
//		//���� ���� 
//		 session.setAttribute("phone", randomNumber);
//		 session.setMaxInactiveInterval(180); //180 ��
//		 
		System.out.println("���� ���� ��  ");
	 return  result ; 

	}
	
}
	
	
	
	
//	@RequestMapping( value="json/login", method=RequestMethod.POST )
//	public @ResponseBody String getKakaoAuthUrl(HttpServletRequest request) throws Exception {
//		String reqUrl = kakaoAuthUrl + "/oauth/authorize?client_id=" + kakaoApiKey + "&redirect_uri="+ redirectURI + "&response_type=code";
//		return reqUrl;
//	}
	
	
	
