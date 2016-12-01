package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Orders;

public interface OrderDao extends BaseDao<Orders> {
	public void deleteByStringId(Class<Orders> entityClass,String id);
	public Orders findByStringId(Class<Orders> entityClass,String id);
	public List<Orders> findByTitle(String title);
	public List<Orders> findNoPayOrders(int id);
	public List<Orders> findOrdersByDate(String stime,String etime,int id);
	public List<Orders> findOrdersByProduct(int id);
	public List<Orders> findOrdersByChannel(int id);
	public List<Orders> findOrdersByChannelAndSalesman(int id,int id2);
	public List<Orders> findByTitleAndManager(String title,int id);
	public List<Orders> findByCustomer(int id,int id2); 
	public List<Orders> findBySalesman(int id);
}
