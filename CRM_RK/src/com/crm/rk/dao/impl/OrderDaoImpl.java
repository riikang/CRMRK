package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.OrderDao;
import com.crm.rk.model.Orders;
@SuppressWarnings("unchecked")
public class OrderDaoImpl extends BaseDaoImpl<Orders> implements OrderDao {
	public void deleteByStringId(Class<Orders> entityClass,String id){
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		getHibernateTemplate().delete(entityName, this.findByStringId(entityClass, id));
	}
	public Orders findByStringId(Class<Orders> entityClass,String id){
		return (Orders)getHibernateTemplate().get(entityClass, id);
	}
	public List<Orders> findByTitle(String title){
		return (List<Orders>)getHibernateTemplate().find("from Orders where title='"+title+"'");
	}
	public List<Orders> findByTitleAndManager(String title,int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where title='"+title+"' and manager.id='"+id+"' ");
	}
	public List<Orders> findNoPayOrders(int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where (status='未付款' or status='已付部分款项') and manager.id='"+id+"' ");
	}
	public List<Orders> findOrdersByDate(String stime,String etime,int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where (dealdate between '"+stime+"' and '"+etime+"') and manager.id='"+id+"' ");
	}
	public List<Orders> findOrdersByProduct(int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where product.id='"+id+"'");
	}
	public List<Orders> findOrdersByChannel(int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where channel.id='"+id+"'");
	}
	public List<Orders> findOrdersByChannelAndSalesman(int id,int id2){
		return (List<Orders>)getHibernateTemplate().find("from Orders where channel.id='"+id+"' and salesman.id='"+id2+"'");
	}
	public List<Orders> findByCustomer(int id,int id2){
		return (List<Orders>)getHibernateTemplate().find("from Orders where customerP.id='"+id+"' and manager.id='"+id2+"' ");
	}
	public List<Orders> findBySalesman(int id){
		return (List<Orders>)getHibernateTemplate().find("from Orders where salesman.id='"+id+"' ");
	}
}
