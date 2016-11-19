package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.CommunionlogDao;
import com.crm.rk.model.Communionlog;

public class CommunionlogDaoImpl extends BaseDaoImpl<Communionlog> implements CommunionlogDao {
	public List<Communionlog> findCommunionlogBySerid(int sid){
		return (List<Communionlog>)getHibernateTemplate().find("from Communionlog where servicelog.id='"+sid+"'");
	}
}

