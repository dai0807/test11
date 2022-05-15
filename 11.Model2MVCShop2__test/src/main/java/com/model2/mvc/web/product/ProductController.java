package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


@Controller
@RequestMapping("/product/*")
public class ProductController {
// ALTER TABLE product ADD quantity number DEFAULT (10) ;
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
 	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService ;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	
    @Resource(name="uploadPath")
    String uploadPath;
	
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct" , method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/addProductView  로 보내기 ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	//@RequestMapping("/addProduct.do") // d이건 다시 하기! ,,,, 데이터가 운다 울어 너는 왜 못가고 있니 
	@RequestMapping( value="addProduct" , method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product1 ") Product  product1 , Model model  , @RequestParam ("fileInfo" )  MultipartFile file   ) throws Exception {


		System.out.println("add Product View + product ::  제조일자 변경전 " + product1 );
		product1.setManuDate(product1.getManuDate().replaceAll("-", "")) ;  // 제조일자 
		System.out.println("add Product View + product ::  제조일자 변경 후 " + product1 );

		 String fileName = file.getOriginalFilename();
		 
		 fileName =  uploadFile(fileName, file.getBytes());   // 파일 이름 중복 제거 
 		  System.out.println("파일이름" +  fileName );
	 
//		
//		이것만 기억 
//		  if(!file.getOriginalFilename().isEmpty()) {
//				file.transferTo(new File(uploadPath, file.getOriginalFilename()));
//				model.addAttribute("msg", "File uploaded successfully.");
//				System.out.println("성공 ");
//			}else {
//				model.addAttribute("msg", "Please select a valid mediaFile..");
//				System.out.println("실패  ");
//
//				
//			}
			
		product1.setFileName(fileName);
		
		
		
		
		
		
		productService.addProduct(product1) ;
		//Business Logic
		System.out.println("제품 추가 !! ");
		System.out.println(product1);
  
 		model.addAttribute("product1", product1);

 		System.out.println("가라! ");
 		 return "forward:/product/addgetProduct.jsp";
	}	

    //파일명 랜덤 생성 메서드
    private String uploadFile(String originalName, byte[] fileData) throws Exception{
    
        // uuid 생성 
        UUID uuid = UUID.randomUUID();
        
        //savedName 변수에 uuid + 원래 이름 추가
        String savedName = uuid.toString()+"_"+originalName;
        //uploadPath경로의 savedName 파일에 대한 file 객체 생성
        File target = new File(uploadPath, savedName);
        //fileData의 내용을 target에 복사함
        FileCopyUtils.copy(fileData, target);
 
         
        
        
        
        return savedName;
    }
	
    
	@RequestMapping( value="addProductVieww" , method=RequestMethod.GET )
	public String addProductView() throws Exception {

		System.out.println("/addProductView  로 보내기 ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	@RequestMapping( value="MainView" , method=RequestMethod.GET )
	public String MainView( Model model ) throws Exception {

		System.out.println("/MainView  로 보내기 ");
		int num =6;
		 List<Product>list=productService.getnewProductList(num);
		 System.out.println(list);
		model.addAttribute("list", list);

		
		
		return "forward:/main.jsp";
	}
	
	
    
    
	
		@RequestMapping(value = "listProduct"   )
		public String listProduct( @ModelAttribute("search") Search search , Model model ,@RequestParam("menu") String menu  ,HttpServletRequest request) throws Exception{
			System.out.println("/listProduct ::  GET / POST\"");

			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			System.out.println("search 정보들 "+search);
			// Business logic 수행
			Map<String , Object> map=productService.getProductList(search);
			
			
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
			System.out.println("menu :::  " + menu +" 출력됨 ");
			
			// Model 과 View 연결
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			model.addAttribute("menu", menu);  // 메뉴로 searh 와 manage 나누기 

					if(menu.equals("search")) {
						
						if( request.getSession(true).getAttribute("user") != null ) {
							String userId =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 
							model.addAttribute("userId" , userId ) ;

						}else {
						 	model.addAttribute("userId" ,"") ;

						}
						
						
						
					return "forward:/product/listProduct.jsp";
					}else {
						return "forward:/product/listMangeProduct.jsp";
					
					}
			
			}

		

		
//	
//	@RequestMapping("/listProduct.do")
//	public String listUser( @ModelAttribute("search") Search search , Model model ,@RequestParam("menu") String menu  ,HttpServletRequest request) throws Exception{
//	
//		System.out.println("/listProduct.do");
//
//		if(search.getCurrentPage() ==0 ){
//			search.setCurrentPage(1);
//		}
//		search.setPageSize(pageSize);
//		System.out.println("search 정보들 "+search);
//		// Business logic 수행
//		Map<String , Object> map=productService.getProductList(search);
//		
//		
//		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
//		System.out.println(resultPage);
//		
//		System.out.println("menu :::  " + menu +" 출력됨 ");
//		
//		// Model 과 View 연결
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);
//		model.addAttribute("menu", menu);  // 메뉴로 searh 와 manage 나누기 
//
//		
//		return "forward:/product/listProduct.jsp";
//	}
//	
		@RequestMapping(value = "getProduct" ,method=RequestMethod.GET  )
	public String getProduct(@RequestParam("prodNo" ) int prodNo ,  Model model ,  HttpServletRequest request ,   HttpSession session ) throws Exception 
	{
		System.out.println("getProduct:: prodNo ::: 출력하기 " + prodNo );

		System.out.println("/getProduct.do");
		
		
		
		Product product  = productService.getProduct(prodNo) ;
		System.out.println("product ::: 출력하기 " + product );

//		
		if( request.getSession(true).getAttribute("user") != null ) {
			String userId =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 
			model.addAttribute("userId" , userId ) ;

		}else {
		 	model.addAttribute("userId" ,"") ;

		}
		
		
		model.addAttribute("Product" , product ) ;

	
		return "forward:/product/getProduct.jsp";
		
	
	}
	
		 @RequestMapping(value = "updateProductView" ,  method=RequestMethod.GET  )
public String updateProductView(@RequestParam("prodNo" ) int prodNo , Model model ) throws Exception 

//	public String updateProductView(@RequestParam("prodNo" ) int prodNo , Model model ) throws Exception 
	{
		System.out.println("/updateProductView.do");
		Product product  = productService.getProduct(prodNo) ;
	
		System.out.println("product ::: 출력하기 " + product );
		model.addAttribute("Product" , product ) ;
	 	
	
		return "forward:/product/updateProductView.jsp";
		
	
	}
		 
		 
		 
		
		@RequestMapping(value = "updateProduct" ,  method=RequestMethod.POST  )
	public String updateProduct( @ModelAttribute("product ") Product  product , Model model ) throws Exception 
	{
		System.out.println("/updateProductView.do");
//		Product product  = productService.getProduct(prodNo) ;
		product.setManuDate(product.getManuDate().replaceAll("-", "")) ;  // 제조일자 

		productService.updateProduct(product) ;
		  product  = productService.getProduct(product.getProdNo()) ;

		
		  
		  
		  
		  
		
		System.out.println("product ::: 출력하기 " + product );
	//	model.addAttribute("Product" , product ) ;
	 	System.out.println("업데이투!! ");
	
		return "redirect:/product/getProduct.do?prodNo="+product.getProdNo();
		
	
	}	
		
		
		
		
	
	//	@RequestMapping("/updateProdcutTranCodeByProd.do")  // 데이터 받기 
	@RequestMapping(value = "updateProdcutTranCodeByProd" ,  method=RequestMethod.GET )  // 데이터 받기 
	public ModelAndView updateProdcutTranCodeByProd(@ModelAttribute("search") Search search  , @RequestParam("prodNo") int prodNo  , @RequestParam("tranCode") String tranCode ) throws Exception 
	{
		System.out.println("updateProdcutTranCodeByProd옴 ");
		System.out.println("updateProdcutTranCodeByProd :: prodNo ::  "  + prodNo  + " tranc Code :: " + tranCode );
 
		//productNo로 DB  찾아서 tranNo 가져오기
		int tranNo =  productService.findTrandtranNo(prodNo) ; //  
		Purchase purchase = purchaseService.getPurchase(tranNo);		
 		purchase.setTranCode(tranCode)  ;  // update할 tranCode 삽입하기 
 
 		
 	// 비지니스 로직 
		purchaseService.updateTranCode(purchase) ; 
		
		
		purchase = purchaseService.getPurchase(tranNo);	 // 업데이트 확인 용 	
		System.out.println("update 끝! :::: tranNo업뎃후   " + purchase.getTranCode()  );
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("search", search) ; 
 		modelAndView.setViewName("/product/listProduct") ;
 
 		
 
 		return modelAndView;
		
	}
 	
	
	
	
}
