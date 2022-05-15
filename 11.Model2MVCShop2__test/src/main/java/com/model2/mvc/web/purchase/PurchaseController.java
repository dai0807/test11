package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PuchaseDaoImpl;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;
 
//���Ű��� ��Ʋ���� 
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
//7��
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService ;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
//	
//	
	public   PurchaseController (){
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	@RequestMapping( value ="/addPurchaseView" , method = RequestMethod.GET)
	public ModelAndView  addPurchaseView(@RequestParam("prodNo") int prodNo  , HttpSession session, HttpServletRequest request) throws Exception {
	
		System.out.println("addPurchaseView ::: "  +prodNo );
		
	//	ProductService service = new ProductServiceImpl() ; 
		 Product product =  productService.getProduct(prodNo);
 
			String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 
		
 			
	 	User pubchaseUser=userService.getUser(buyer_id);
			
			System.out.println("user::::"+ buyer_id);
			System.out.println("product :::" + product);
		 
		

		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id" ,buyer_id);
		modelAndView.addObject("product" ,product);
		modelAndView.addObject("User" ,pubchaseUser);

		modelAndView.setViewName("/purchase/addPurchaseView.jsp") ;
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/addPurchase" , method = RequestMethod.POST ) // ���� ���� ���� ���� ���� �Ҳ� ���� �ϳİ�� ,,,, 
//	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase , @RequestParam("buyerId") String buyerId ,  @RequestParam("prodNo") int prodNo ) throws Exception {
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase , @ModelAttribute("user") User user ,  @ModelAttribute("product") Product product ) throws Exception {

	System.out.println("adddPrucase Action " + purchase );
//		System.out.println("adddPrucase buyerId " + buyerId );
	//	System.out.println("adddPrucase prodNo " + prodNo );
		
	//	User user  = new User() ;
		//user.setUserId(buyerId); 
 		purchase.setBuyer(user) ;
 		System.out.println("user ���Ͷ�!! :: " + user);
 		product =  productService.getProduct(product.getProdNo());

 		
 	//	Product product =new Product() ;
 	//	product.setProdNo(prodNo) ;
 		purchase.setPurchaseProd(product) ;
 		purchase.setTranCode("002") ; // ���� �Ϸ� 
 
 		System.out.println("product ���Ͷ�!! :: " + product);

 		
		purchaseService.addPurchase(purchase);
		product.setQuantity((product.getQuantity() - 1));
		System.out.println("quntity + "+ product.getQuantity());
		productService.minusQuantity(product) ;
	 
		System.out.println("���� ���浵 ��");
		 // productService.getProduct(prodNo);

		
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("purchase" , purchase) ;
		modelAndView.setViewName("/purchase/receiptView.jsp") ;
		return modelAndView;
	}

	@RequestMapping(value = "/listPurchase") // ���� ���� ���� ���� ���� �Ҳ� ���� �ϳİ�� ,,,, 
	public ModelAndView listPurchase(@ModelAttribute("search") Search search  ,HttpServletRequest request ,   HttpSession session ) throws Exception {
 //  ����Ʈ �ϱ� 
		System.out.println("listPurchase :: ��!! ");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		
		System.out.println("search ������ "+search);
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 
		System.out.println("buyer_id :: " + buyer_id );
		search.setSearchCondition(" ") ;
		search.setSearchKeyword(buyer_id) ;

		
		// Business logic ����

	 Map<String , Object> map=purchaseService.getPurchaseList(search);
			
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
 
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("search", search) ; 
		modelAndView.addObject("list",  map.get("list")) ; 
		modelAndView.addObject("resultPage", resultPage) ; 
 		modelAndView.setViewName("/purchase/ListPurchase.jsp") ;
 		
 		
		return modelAndView;
	}	
	
	@RequestMapping(value =  "/getPurchase"  ,method=RequestMethod.GET )
	public ModelAndView listPurchase(@RequestParam("tranNo" ) int tranNo , HttpServletRequest request ,  HttpSession session ) throws Exception 
	{
		
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 
		System.out.println("buyer_id :: " + buyer_id );
		System.out.println("getPurchase TranNO " + tranNo);
		 Purchase purchase = purchaseService.getPurchase(tranNo) ;
		System.out.println(purchase);
		
		ModelAndView modelAndView = new ModelAndView() ;

		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("purchase", purchase) ; 
 		modelAndView.setViewName("/purchase/getPurchaseView.jsp") ;

		return modelAndView;
		
	}
//	@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value = "/updatePurchase" ,method =RequestMethod.GET)

	public ModelAndView updatePurchaseView(@RequestParam("tranNo" ) int tranNo  , HttpServletRequest request ,  HttpSession session    ) throws Exception 
	{
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 

		System.out.println("UpdatePurchaseViewAction View�� ");
		System.out.println("tranNo  �� " +  tranNo );

		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);

		
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("purchase", purchase) ; 
		
		
		
		//  ������Ʈ �� ���� �� ,  �ͼ� VIw���� ������ Ȯ�� �ϱ�!! 
		
		
		
 		modelAndView.setViewName("/purchase/updatePurchaseView.jsp") ;
 		return modelAndView;
		
	}
	
	
	//@RequestMapping("/updatePurchase.do")  // ������ �ޱ� 
	@RequestMapping(value = "/updatePurchase" , method = RequestMethod.POST)  // ������ �ޱ� 

	public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo,@ModelAttribute("purchase") Purchase purchase, HttpServletRequest request ,  HttpSession session ) throws Exception 
	{
		System.out.println("updatePurchase ::  "  + purchase );
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //���� ���̵� �̱� 

		System.out.println("updatePurchase�� ");
		ModelAndView modelAndView = new ModelAndView() ;
		purchaseService.updatePurchase(purchase) ; 
		
		
		System.out.println("update ��! ");
		
 		modelAndView.setViewName("/purchase/getPurchase?tranNo"+tranNo) ;
 		return modelAndView;
		
	}
	
	//@RequestMapping("/updateTranCode.do")  // ������ �ޱ� 
	@RequestMapping(value ="/updateTranCode" , method = RequestMethod.GET)  // ������ �ޱ� 

	public ModelAndView updateTranCode(@ModelAttribute("search") Search search  , @RequestParam("tranNo") int tranNo  , @RequestParam("tranCode") String tranCode ,@RequestParam("currentPage") int  intcurrentPage ,   HttpServletRequest request ,  HttpSession session ) throws Exception 
	{
		System.out.println("updatePurchase�� ");

		System.out.println("updateTranCode :: tranNo ::  "  + tranNo  + " tranc Code :: " + tranCode );
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); // �������� Ȯ�� 
		System.out.println("role  " + buyer_id);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		System.out.println("tranNo���� ��  " + purchase  );
		purchase.setTranCode(tranCode)  ; 
		System.out.println(   "purchase ::: "+  purchase.getTranCode()     );    
		//purchase.setTranCode(tranCode); // Ʈ�� �ڵ� ����
		System.out.println("����");
		purchaseService.updateTranCode(purchase) ;
		
 
		purchase = purchaseService.getPurchase(tranNo);		
		System.out.println("tranNo������   " + purchase.getTranCode()  );
		
		ModelAndView modelAndView = new ModelAndView() ;
 		
		System.out.println(intcurrentPage);
		
		System.out.println("update ��! ");
		modelAndView.addObject("search", search) ; 

		if(buyer_id.equals("admin")) {
	 		modelAndView.setViewName("/purchase/listSale") ;

		}else {
	 		modelAndView.setViewName("/purchase/listPurchase") ;

		}

 		
 		return modelAndView;
		
	}
	 //  	<a href="/updateProdcutTranCodeByProd.
	
//	@RequestMapping("listSale.do") // �Ǹ� ����Ʈ 
	@RequestMapping(value = "listSale") // �Ǹ� ����Ʈ 

	public ModelAndView listSale(@ModelAttribute("search") Search search  ,HttpServletRequest request ,   HttpSession session ) throws Exception {
 //  ����Ʈ �ϱ� 
		System.out.println("listSale/: GET / POST");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	search.setSearchCondition("") ;
 
 
		

		 Map<String , Object> map=purchaseService.getSaleList(search);
				
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
	 
			
			ModelAndView modelAndView = new ModelAndView() ;
 			modelAndView.addObject("search", search) ; 
			modelAndView.addObject("list",  map.get("list")) ; 
			modelAndView.addObject("resultPage", resultPage) ;
		
 		modelAndView.setViewName("/purchase/listSaleView.jsp");
		return modelAndView;
	}	
	
}
