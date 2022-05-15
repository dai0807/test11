package com.model2.mvc.service.product.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{


	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
 		return sqlSession.selectOne("ProductMapper.getProduct" ,prodNo);
	}

  	public List<Product> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
	 return sqlSession.selectList("ProductMapper.getProductList", search);
	}
	public List<Product> getnewProductList(int num) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProductMapper.getnewProductList", num);
	}
	

 	public void insertProduct(Product product) throws Exception {
 		sqlSession.insert("ProductMapper.addProduct" , product) ;
		
	}

 	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct", product);

	}

 	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

 	public int findTrandtranNo(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getTrandCode" ,prodNo);
	}

 	public void minusQuantity(Product product) throws Exception {
		System.out.println("minus  Qutity �� ");
		  sqlSession.update("ProductMapper.minusQuantity", product);
		
	}

 
	
	

}

