package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.SalesmanDao;
import com.crm.rk.model.Salesman;

public class SalesmanDaoImpl extends BaseDaoImpl<Salesman> implements SalesmanDao {
	public List<Salesman> findSalesmanByChannel(int channel){
		return (List<Salesman>)getHibernateTemplate().find("from Salesman where channel.id="+channel+"");
	}
	public List<Salesman> findSalesmanByName(String name){
		return (List<Salesman>) getHibernateTemplate().find("from Salesman where sname='"+name+"'");
	}
	public List<Salesman> findSalesmanByUserPower(int id){
		return (List<Salesman>) getHibernateTemplate().find("from Salesman where userPower.id='"+id+"'");
	}
	public List<Salesman> findSalesmanByNameAndManager(String name, int id){
		return (List<Salesman>) getHibernateTemplate().find("from Salesman where sname='"+name+"' and manager.id='"+id+"'");
	}
}
