<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<a href ="javascript:kakaoLogin();"><img src="https://www.google.com/imgres?imgurl=http%3A%2F%2Fpapaspick.com%2Fweb%2Fupload%2F2019_web%2Ficon%2Fkakao_login.jpg&imgrefurl=http%3A%2F%2Fpapaspick.com%2Fmember%2Flogin.html&tbnid=C_pZKT7WDYRggM&vet=12ahUKEwiFjcHDseD3AhUBTPUHHSFfA6oQMyhGegUIARCCAQ..i&docid=Ah0AStkMF0_NFM&w=900&h=180&q=%EC%B9%B4%EC%B9%B4%EC%98%A4%20%EB%A1%9C%EA%B7%B8%EC%9D%B8&ved=2ahUKEwiFjcHDseD3AhUBTPUHHSFfA6oQMyhGegUIARCCAQ"/></a>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">


KaKao.init('1168879765a4d95dba3517e139b1ea14');  //발급중 자바스크립스 키
console.log(Kakao.isInitialized()); // sdk초기화여부판단


function kakaoLogin() {
    Kakao.Auth.login({
  		scope:'profile,account_email',
  		success: function(authObj){
  			console.log(authObj);
  		   Kakao.API.request({   ///v1/user/me 로그인한 사용자 정보 가져옴
  		        url: '/v1/user/me',
  		      success: function (res) {
   	        	  const kakao_account = res.kakao_account ;
   	        	  console.log(kakao_account) ;
  	          } 
  				
  			}); // 리퀘스트 요청
  		}
    	
    });
  }
</script>




</body>
</html>