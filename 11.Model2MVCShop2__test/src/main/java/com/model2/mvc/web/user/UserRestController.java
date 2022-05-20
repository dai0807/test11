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


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
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
		// 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
		//난수 생성 
		System.out.println("  randomNumber"  + randomNumber );
		userService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		 session.setAttribute("userAuth", randomNumber);
		// session.setMaxInactiveInterval(180); //180 초
		 
		 
		 System.out.println(  session.getAttribute("userAuth")     );
		System.out.println("^_^문자 갔어 !! ^_^ ");
		System.out.println("문자 가는거 끝!!! ");
		System.out.println("문자 가는거 끝!!! ");
		System.out.println( );

		
		return Integer.toString(randomNumber); 

	}
	

	@RequestMapping(value = "/smsCertificationRequest", method = RequestMethod.GET) 
	@ResponseBody 
	public String smsCertificationRequest  (@RequestParam("phone") String userPhoneNumber ,  @RequestParam("phone2") String smsCertification ,  HttpSession session   ,HttpServletRequest request)  throws Exception { 
		
		System.out.println("인증하러옴 !! ");
	 // userPhoneNumber 본인 인증한 휴대폰 번호 값 
		
		String result = "F" ;
		System.out.println("userPhoneNumber  :  " + userPhoneNumber  +"  smsCertification :  " +  smsCertification );
		System.out.println("session.getAttributeNames();" + session.getAttributeNames()     );
		
 		
		
				if( request.getSession(true).getAttribute("userAuth") != null ) {
 					System.out.println("세션 있어");
					System.out.println("  세션 ddd어 "  +  request.getSession(true).getAttribute("userAuth")  );

					String sessionP = request.getSession(true).getAttribute("userAuth").toString() ;  //  이건 됨 
					String sessionP1 = (String )request.getSession(true).getAttribute("userAuth")  ;  //  이건  터짐 

					System.out.println("3333");
					System.out.println("  세션 있어 "  + sessionP);
					System.out.println("userPhoneNumber  :  " + userPhoneNumber  +"  smsCertification :  " +  smsCertification + " sessionP :" + sessionP );

					System.out.println("sessionP : " + sessionP );
						if   (      sessionP.equals(smsCertification)             ) {
							result = "T" ;
							
							}else {
								System.out.println("값들 일치 xxxxx ");
							}
						
						
		
					
					
				}else {
					System.out.println(" 세션 없어 ");
					
				}
				
				
				System.out.println("Result " + result);

		
//		// 휴대폰 문자보내기
//		
//		
//		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
//		//난수 생성 
//		 session.setAttribute("phone", randomNumber);
//		 session.setMaxInactiveInterval(180); //180 초
//		 
		System.out.println("문자 검증 중  ");
	 return  result ; 

	}
	
}
	
	
	
	
//	@RequestMapping( value="json/login", method=RequestMethod.POST )
//	public @ResponseBody String getKakaoAuthUrl(HttpServletRequest request) throws Exception {
//		String reqUrl = kakaoAuthUrl + "/oauth/authorize?client_id=" + kakaoApiKey + "&redirect_uri="+ redirectURI + "&response_type=code";
//		return reqUrl;
//	}
	
	
	
