package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	
//��ǰ�߰�
	public void addPurchase(Purchase purchase)throws Exception  ;

	
	//��ǰ �ѹ��� Ʈ�� �ڵ� ã��
	public Purchase getPurchase(int tranNo) throws Exception;
 
	// �Ǹ� ����Ʈ ��������
	//public Map<String, Object> getSaleList(Search search) throws Exception ;
	 public  List<Purchase> getSaleList(Map<String,Object> map )   throws Exception ;
	

	
	// ����  ����Ʈ ��������
//	public Map<String, Object> getPurchaseList(Search search , String userId ) throws Exception ;
	public List<Purchase> getPurchaseList(Map<String,Object> map ) throws Exception ;
	//�Ǹų��� ������Ʈ
	public void updatePurchase(Purchase purchase) throws Exception  ;
	
	//Ʈ���ڵ� �����ϱ� 
//	public void tranCode(Purchase purchase) throws Exception ;
	public void updatetranCode(Purchase purchase) throws Exception ;
	
	
 //�Խ��� Page ó���� ���� ��üRow(totalCount)  return
 public int getTotalCount(Search search) throws Exception ; 
	
	
	
}
