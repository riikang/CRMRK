package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.EmailMessageDao;
import com.crm.rk.model.EmailMessage;

public class EmailMessageDaoImpl extends BaseDaoImpl<EmailMessage> implements EmailMessageDao {
	public List<EmailMessage> findByManager(int id) {
		return (List<EmailMessage>)getHibernateTemplate().find("from EmailMessage where manager.id='"+id+"' ");
	}
}
