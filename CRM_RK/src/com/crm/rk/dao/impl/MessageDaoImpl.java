package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.MessageDao;
import com.crm.rk.model.Message;

public class MessageDaoImpl extends BaseDaoImpl<Message> implements MessageDao {
	public List<Message> findByLevelAndPid(int id1,int id2){
		return (List<Message>)getHibernateTemplate().find("from Message where level='"+id1+"' and pid='"+id2+"' ");
	}
	public List<Message> findByMidLevelAndPid(int id1,int id3,int id2){
		return (List<Message>)getHibernateTemplate().find("from Message where mid='"+id1+"' and level='"+id3+"' and pid='"+id2+"' ");
	}
}
