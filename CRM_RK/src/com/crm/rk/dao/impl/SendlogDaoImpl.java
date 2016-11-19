package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.SendlogDao;
import com.crm.rk.model.Sendlog;

public class SendlogDaoImpl extends BaseDaoImpl<Sendlog> implements SendlogDao {
	public List<Sendlog> findSendlogByOrders(String id){
		return (List<Sendlog>)getHibernateTemplate().find("from Sendlog where orders.id='"+id+"'");
	}
}
