package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.SendlogDao;
import com.crm.rk.model.Sendlog;
import com.crm.rk.service.SendlogService;
@Transactional(readOnly = false)
public class SendlogServiceImpl extends BaseServiceImpl<Sendlog> implements SendlogService {
	@Resource SendlogDao sendlogDao;
	public List<Sendlog> findSendlogByOrders(String id){
		return sendlogDao.findSendlogByOrders(id);
	}
}
