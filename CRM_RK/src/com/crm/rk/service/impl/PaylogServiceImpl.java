package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.PaylogDao;
import com.crm.rk.model.Paylog;
import com.crm.rk.service.PaylogService;
@Transactional(readOnly = false)
public class PaylogServiceImpl extends BaseServiceImpl<Paylog> implements PaylogService {
	@Resource PaylogDao paylogDao;
	public List<Paylog> findPaylogByOrders(String id){
		return paylogDao.findPaylogByOrders(id);
	}
}
