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


KaKao.init('1168879765a4d95dba3517e139b1ea14');  //�߱��� �ڹٽ�ũ���� Ű
console.log(Kakao.isInitialized()); // sdk�ʱ�ȭ�����Ǵ�


function kakaoLogin() {
    Kakao.Auth.login({
  		scope:'profile,account_email',
  		success: function(authObj){
  			console.log(authObj);
  		   Kakao.API.request({   ///v1/user/me �α����� ����� ���� ������
  		        url: '/v1/user/me',
  		      success: function (res) {
   	        	  const kakao_account = res.kakao_account ;
   	        	  console.log(kakao_account) ;
  	          } 
  				
  			}); // ������Ʈ ��û
  		}
    	
    });
  }
</script>




</body>
</html>