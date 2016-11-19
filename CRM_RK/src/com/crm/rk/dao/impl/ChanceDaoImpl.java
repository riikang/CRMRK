package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ChanceDao;
import com.crm.rk.model.Chance;

public class ChanceDaoImpl extends BaseDaoImpl<Chance> implements ChanceDao {
	public List<Chance> findChanceByName(String name){
		return (List<Chance>)getHibernateTemplate().find("from Chance where name='"+name+"'");
	}
	public List<Chance> findChanceByNameAndManager(String name,int id){
		return (List<Chance>)getHibernateTemplate().find("from Chance where name='"+name+"' and manager.id='"+id+"'");
	}
	public List<Chance> findChanceByChannel(int id){
		return (List<Chance>)getHibernateTemplate().find("from Chance where channel.id='"+id+"'");
	}
	public List<Chance> findChanceBySalesman(int id){
		return (List<Chance>)getHibernateTemplate().find("from Chance where salesman.id='"+id+"'");
	}
}
