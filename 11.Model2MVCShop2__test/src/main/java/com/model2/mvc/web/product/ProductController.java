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
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct" , method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/addProductView  �� ������ ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	//@RequestMapping("/addProduct.do") // d�̰� �ٽ� �ϱ�! ,,,, �����Ͱ� ��� ��� �ʴ� �� ������ �ִ� 
	@RequestMapping( value="addProduct" , method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product1 ") Product  product1 , Model model  , @RequestParam ("fileInfo" )  MultipartFile file   ) throws Exception {


		System.out.println("add Product View + product ::  �������� ������ " + product1 );
		product1.setManuDate(product1.getManuDate().replaceAll("-", "")) ;  // �������� 
		System.out.println("add Product View + product ::  �������� ���� �� " + product1 );

		 String fileName = file.getOriginalFilename();
		 
		 fileName =  uploadFile(fileName, file.getBytes());   // ���� �̸� �ߺ� ���� 
 		  System.out.println("�����̸�" +  fileName );
	 
//		
//		�̰͸� ��� 
//		  if(!file.getOriginalFilename().isEmpty()) {
//				file.transferTo(new File(uploadPath, file.getOriginalFilename()));
//				model.addAttribute("msg", "File uploaded successfully.");
//				System.out.println("���� ");
//			}else {
//				model.addAttribute("msg", "Please select a valid mediaFile..");
//				System.out.println("����  ");
//
//				
//			}
			
		product1.setFileName(fileName);
		
		
		
		
		
		
		productService.addProduct(product1) ;
		//Business Logic
		System.out.println("��ǰ �߰� !! ");
		System.out.println(product1);
  
 		model.addAttribute("product1", product1);

 		System.out.println("����! ");
 		 return "forward:/product/addgetProduct.jsp";
	}	

    //���ϸ� ���� ���� �޼���
    private String uploadFile(String originalName, byte[] fileData) throws Exception{
    
        // uuid ���� 
        UUID uuid = UUID.randomUUID();
        
        //savedName ������ uuid + ���� �̸� �߰�
        String savedName = uuid.toString()+"_"+originalName;
        //uploadPath����� savedName ���Ͽ� ���� file ��ü ����
        File target = new File(uploadPath, savedName);
        //fileData�� ������ target�� ������
        FileCopyUtils.copy(fileData, target);
 
         
        
        
        
        return savedName;
    }
	
    
	@RequestMapping( value="addProductVieww" , method=RequestMethod.GET )
	public String addProductView() throws Exception {

		System.out.println("/addProductView  �� ������ ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	@RequestMapping( value="MainView" , method=RequestMethod.GET )
	public String MainView( Model model ) throws Exception {

		System.out.println("/MainView  �� ������ ");
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
			System.out.println("search ������ "+search);
			// Business logic ����
			Map<String , Object> map=productService.getProductList(search);
			
			
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
			System.out.println("menu :::  " + menu +" ��µ� ");
			
			// Model �� View ����
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			model.addAttribute("menu", menu);  // �޴��� searh �� manage ������ 

					if(menu.equals("search")) {
						
						if( request.getSession(true).getAttribute("user") != null ) {
							String userId =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 
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
//		System.out.println("search ������ "+search);
//		// Business logic ����
//		Map<String , Object> map=productService.getProductList(search);
//		
//		
//		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
//		System.out.println(resultPage);
//		
//		System.out.println("menu :::  " + menu +" ��µ� ");
//		
//		// Model �� View ����
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);
//		model.addAttribute("menu", menu);  // �޴��� searh �� manage ������ 
//
//		
//		return "forward:/product/listProduct.jsp";
//	}
//	
		@RequestMapping(value = "getProduct" ,method=RequestMethod.GET  )
	public String getProduct(@RequestParam("prodNo" ) int prodNo ,  Model model ,  HttpServletRequest request ,   HttpSession session ) throws Exception 
	{
		System.out.println("getProduct:: prodNo ::: ����ϱ� " + prodNo );

		System.out.println("/getProduct.do");
		
		
		
		Product product  = productService.getProduct(prodNo) ;
		System.out.println("product ::: ����ϱ� " + product );

//		
		if( request.getSession(true).getAttribute("user") != null ) {
			String userId =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 
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
	
		System.out.println("product ::: ����ϱ� " + product );
		model.addAttribute("Product" , product ) ;
	 	
	
		return "forward:/product/updateProductView.jsp";
		
	
	}
		 
		 
		 
		
		@RequestMapping(value = "updateProduct" ,  method=RequestMethod.POST  )
	public String updateProduct( @ModelAttribute("product ") Product  product , Model model ) throws Exception 
	{
		System.out.println("/updateProductView.do");
//		Product product  = productService.getProduct(prodNo) ;
		product.setManuDate(product.getManuDate().replaceAll("-", "")) ;  // �������� 

		productService.updateProduct(product) ;
		  product  = productService.getProduct(product.getProdNo()) ;

		
		  
		  
		  
		  
		
		System.out.println("product ::: ����ϱ� " + product );
	//	model.addAttribute("Product" , product ) ;
	 	System.out.println("��������!! ");
	
		return "redirect:/product/getProduct.do?prodNo="+product.getProdNo();
		
	
	}	
		
		
		
		
	
	//	@RequestMapping("/updateProdcutTranCodeByProd.do")  // ������ �ޱ� 
	@RequestMapping(value = "updateProdcutTranCodeByProd" ,  method=RequestMethod.GET )  // ������ �ޱ� 
	public ModelAndView updateProdcutTranCodeByProd(@ModelAttribute("search") Search search  , @RequestParam("prodNo") int prodNo  , @RequestParam("tranCode") String tranCode ) throws Exception 
	{
		System.out.println("updateProdcutTranCodeByProd�� ");
		System.out.println("updateProdcutTranCodeByProd :: prodNo ::  "  + prodNo  + " tranc Code :: " + tranCode );
 
		//productNo�� DB  ã�Ƽ� tranNo ��������
		int tranNo =  productService.findTrandtranNo(prodNo) ; //  
		Purchase purchase = purchaseService.getPurchase(tranNo);		
 		purchase.setTranCode(tranCode)  ;  // update�� tranCode �����ϱ� 
 
 		
 	// �����Ͻ� ���� 
		purchaseService.updateTranCode(purchase) ; 
		
		
		purchase = purchaseService.getPurchase(tranNo);	 // ������Ʈ Ȯ�� �� 	
		System.out.println("update ��! :::: tranNo������   " + purchase.getTranCode()  );
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("search", search) ; 
 		modelAndView.setViewName("/product/listProduct") ;
 
 		
 
 		return modelAndView;
		
	}
 	
	
	
	
}
