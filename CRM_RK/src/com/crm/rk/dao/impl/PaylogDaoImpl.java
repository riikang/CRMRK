package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.PaylogDao;
import com.crm.rk.model.Paylog;

public class PaylogDaoImpl extends BaseDaoImpl<Paylog> implements PaylogDao {
	public List<Paylog> findPaylogByOrders(String id){
		return (List<Paylog>)getHibernateTemplate().find("from Paylog where orders.id='"+id+"'");
	}
}
