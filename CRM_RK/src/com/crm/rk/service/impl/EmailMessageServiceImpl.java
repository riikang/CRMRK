package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.EmailMessageDao;
import com.crm.rk.model.EmailMessage;
import com.crm.rk.service.EmailMessageService;
@Transactional(readOnly = false)

public class EmailMessageServiceImpl extends BaseServiceImpl<EmailMessage> implements EmailMessageService {
	@Resource EmailMessageDao emailMessageDao;
	public List<EmailMessage> findByManager(int id){
		return emailMessageDao.findByManager(id);
	}
}
