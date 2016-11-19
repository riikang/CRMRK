package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.MissionDao;
import com.crm.rk.model.Mission;

public class MissionDaoImpl extends BaseDaoImpl<Mission> implements MissionDao {
	public List<Mission> findMissionByChannel(int id){
		return (List<Mission>)getHibernateTemplate().find("from Mission where channel.id='"+id+"'");
	}
	public List<Mission> findMissionBySalesman(int id){
		return (List<Mission>)getHibernateTemplate().find("from Mission where salesman.id='"+id+"'");
	}
}
