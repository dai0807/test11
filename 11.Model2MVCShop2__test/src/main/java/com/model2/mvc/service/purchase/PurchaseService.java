package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	
	//��ǰ �߰�
	public void addPurchase(Purchase purchase)  throws Exception;
	
	// ��ǰ ã��
	public  Purchase getPurchase (int tranNo) throws Exception;
	
	//���� ����Ʈ �������� 
	public Map<String, Object>  getPurchaseList(Search search  )  throws Exception;
	
	//�ǸŸ���Ʈ ��������
	public  Map<String, Object>  getSaleList(Search  search )  throws Exception; 
	
	//�Ǹ� ���� ������Ʈ
	public void updatePurchase(Purchase purchase)  throws Exception; 
	
	//Ʈ���ڵ� ���� 
	public void updateTranCode(Purchase purchase) throws Exception; 
	
}
