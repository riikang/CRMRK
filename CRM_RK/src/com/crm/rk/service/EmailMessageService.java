package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.EmailMessage;

public interface EmailMessageService extends BaseService<EmailMessage> {
	public List<EmailMessage> findByManager(int id);
}
