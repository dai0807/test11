package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")  // ���� 
public class ProductServiceImpl implements ProductService{

	@Autowired
	@Qualifier("productDaoImpl")
		private ProductDao productDao ;	
		public void setProudDao(ProductDao productDao) {
			this.productDao = productDao ;
			// u������ xml ������ �߾��µ� Service�� dao ������ service ���� �̰��� ���ٸ� ������ 

		}
		// findTrannNo ���� �׽�Ʈ�� �� �ϱ⸦ �ٶ� 
	
		public ProductServiceImpl() {
			System.out.println(this.getClass());
	 	}
	 	public void addProduct(Product product) throws Exception {
	  		System.out.println("product service impp :  " + product  );
	 		productDao.insertProduct(product ) ;
	  		
		}

	 	public void updateProduct(Product product) throws Exception {
	  		productDao.updateProduct(product);
		}

	 	public Product getProduct(int prodNo) throws Exception {
	  		System.out.println("���� �ٿ� getProduct  :: " + prodNo );
	  		System.out.println( "���Ͷ� " +productDao.getProduct(prodNo));
			return productDao.getProduct(prodNo);
		}

	 	public Map<String, Object> getProductList(Search search) throws Exception {
			// DAO���� List�� get TotalCount �޾Ƽ� Map �־ ������ 
	 		List<Product> list = productDao.getProductList(search) ;
	 		int totalCount 		=  productDao.getTotalCount(search) ;
//	 		System.out.println("totalCount ::" + totalCount );
//	 		System.out.println("list ::" + list );

	 		Map<String,Object>map = new HashMap<String, Object>() ;
	 		map.put("list", list ) ;
	 		map.put("totalCount", new Integer(totalCount) ) ;

	 		return map;
	 		
	 
		}

 		public List<Product>getnewProductList(int num) throws Exception {
	 		List<Product> list = productDao.getnewProductList(num) ;
 

 			return 	list;
		}	
	 	
	 	
	 	
 	 	public int findTrandtranNo(int prodNo) throws Exception {
			// TODO Auto-generated method stub
			return productDao.findTrandtranNo(prodNo);
		}

		@Override
		public void minusQuantity   (Product product ) throws Exception {
			  productDao.minusQuantity(product);
			
		}



	}
