package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {

	// ��ǰ �߰� 
	public void addProduct(Product product) throws Exception;
	
	//��ǰ ������Ʈ
	public void updateProduct(Product product) throws Exception;

	//��ǰ ��������
	public Product getProduct (int prodNo) throws Exception;

	//����Ʈ ��������
	public  Map<String, Object> getProductList(Search search)  throws Exception;

	public  List<Product>getnewProductList (int  num) throws Exception  ; // ����Ʈ �������� 

	// public int findTrandtranNo(int prodNo )  throws Exception; �̰� ���� 

	//Ʈ���ڵ� ã�� 
	public int findTrandtranNo(int prodNo )  throws Exception;

	public void minusQuantity (Product product ) throws Exception ;
	
}
