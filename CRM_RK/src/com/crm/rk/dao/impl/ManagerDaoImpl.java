package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ManagerDao;
import com.crm.rk.model.Manager;

public class ManagerDaoImpl extends BaseDaoImpl<Manager> implements ManagerDao {
	public List<Manager> findByUserPower(int id){
		return (List<Manager>)getHibernateTemplate().find("from Manager where userPower.id='"+id+"'");
	}
}
