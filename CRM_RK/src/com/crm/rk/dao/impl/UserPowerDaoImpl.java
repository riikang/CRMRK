package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.UserPowerDao;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Manager;
import com.crm.rk.model.UserPower;

public class UserPowerDaoImpl extends BaseDaoImpl<UserPower> implements UserPowerDao {
	public List<UserPower> findByUsername(String name) {
		return (List<UserPower>)getHibernateTemplate().find("from UserPower where username='"+name+"'");
	}
	public List<UserPower> findByUsernameAndManager(String name,int id) {
		return (List<UserPower>)getHibernateTemplate().find("from UserPower where username='"+name+"' and manager.id='"+id+"'");
	}
	public List<UserPower> findByEmail(String email){
		return (List<UserPower>)getHibernateTemplate().find("from UserPower where username='"+email+"'");
	}
}
