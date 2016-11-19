package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.EmailMessage;

public interface EmailMessageDao extends BaseDao<EmailMessage> {
	public List<EmailMessage> findByManager(int id);
}
