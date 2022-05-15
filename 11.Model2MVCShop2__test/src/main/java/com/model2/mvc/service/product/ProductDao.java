package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductDao {

	public   Product getProduct(int prodNo) throws Exception 	 ; // ��ǰ ã��
 	public  List<Product>getProductList (Search search) throws Exception  ; // ����Ʈ �������� 
	
	public  List<Product>getnewProductList (int  num) throws Exception  ; // ����Ʈ �������� 

	public void insertProduct(Product product) throws Exception  ; // ��ǰ �ֱ�
	
	public void updateProduct(Product product) throws Exception  ;  // ��ǰ ����!

	public int getTotalCount(Search search) throws Exception ; 
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return

	public int findTrandtranNo(int prodNo )  throws Exception; // Ʈ���ڵ� ã�� 

	public void minusQuantity(Product product)  throws Exception; 
}
