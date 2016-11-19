package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.FollowupDao;
import com.crm.rk.model.Followup;

public class FollowupDaoImpl extends BaseDaoImpl<Followup> implements FollowupDao {
	public List<Followup> findFollowupByChanceId(int id){
		return (List<Followup>) getHibernateTemplate().find("from Followup where chance.id='"+id+"'");
	}
}
