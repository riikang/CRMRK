package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.OrderDao;
import com.crm.rk.model.Orders;
import com.crm.rk.service.OrderService;

@Transactional(readOnly = false)
public class OrderServiceImpl extends BaseServiceImpl<Orders> implements OrderService {
	@Resource private OrderDao orderDao;
	public void deleteByStringId(Class<Orders> entityClass,String id){
		orderDao.deleteByStringId(entityClass,id);
	}
	public Orders findByStringId(Class<Orders> entityClass,String id){
		return orderDao.findByStringId(entityClass, id);
	}
	public List<Orders> findByTitle(String title){
		return orderDao.findByTitle(title);
	}
	public List<Orders> findNoPayOrders(int id){
		return orderDao.findNoPayOrders(id);
	}
	public List<Orders> findOrdersByDate(String stime,String etime,int id){
		return orderDao.findOrdersByDate(stime, etime, id);
	}
	public List<Orders> findOrdersByProduct(int id){
		return orderDao.findOrdersByProduct(id);
	}
	public List<Orders> findOrdersByChannel(int id){
		return orderDao.findOrdersByChannel(id);
	}
	public List<Orders> findOrdersByChannelAndSalesman(int id,int id2){
		return orderDao.findOrdersByChannelAndSalesman(id, id2);
	}
	public List<Orders> findByTitleAndManager(String title,int id){
		return orderDao.findByTitleAndManager(title, id);
	}
	public List<Orders> findByCustomer(int id,int id2){
		return orderDao.findByCustomer(id,id2);
	}
	public List<Orders> findBySalesman(int id){
		return orderDao.findBySalesman(id);
	}
}
