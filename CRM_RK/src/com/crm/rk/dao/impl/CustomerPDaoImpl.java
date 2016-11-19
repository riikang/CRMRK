package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.CustomerPDao;
import com.crm.rk.model.CustomerP;

public class CustomerPDaoImpl extends BaseDaoImpl<CustomerP> implements CustomerPDao {
	public List<CustomerP> findCustomerPByName(String name){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where cname='"+name+"'");
	}
	public List<CustomerP> findCustomerPByUserPower(int id){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where userPower='"+id+"'");
	}
	public List<CustomerP> findCustomerPByNameAndManager(String name, int id){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where cname='"+name+"' and manager.id='"+id+"'");
	}
	public List<CustomerP> findCustomerPByifcompanyAndManager(String ifm,int id){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where ifcompany='"+ifm+"' and manager.id='"+id+"'");
	}
	public List<CustomerP> findCustomerPByStatusAndManager(String string1,int id){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where status='"+string1+"' and manager.id='"+id+"'");
	}
	public List<CustomerP> findCustomerPByTypeAndManager(String string1,int id){
		return (List<CustomerP>) getHibernateTemplate().find("from CustomerP where type='"+string1+"' and manager.id='"+id+"'");
	}
}
