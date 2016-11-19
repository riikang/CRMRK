package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ServicelogDao;
import com.crm.rk.model.Servicelog;

public class ServicelogDaoImpl extends BaseDaoImpl<Servicelog> implements ServicelogDao {
	public List<Servicelog> findByChannel(int id) {
		return (List<Servicelog>)getHibernateTemplate().find("from Servicelog where channel.id='"+id+"' ");
	}
	public List<Servicelog> findBySalesman(int id) {
		return (List<Servicelog>)getHibernateTemplate().find("from Servicelog where salesman.id='"+id+"' ");
	}
	public List<Servicelog> findByCustomer(int id) {
		return (List<Servicelog>)getHibernateTemplate().find("from Servicelog where customerP.id='"+id+"' ");
	}
}
