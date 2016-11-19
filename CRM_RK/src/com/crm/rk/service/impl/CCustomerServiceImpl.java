package com.crm.rk.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.CCustomerDao;
import com.crm.rk.model.CCustomer;
import com.crm.rk.service.CCustomerService;

@Transactional(readOnly = false)
public class CCustomerServiceImpl extends BaseServiceImpl<CCustomer> implements CCustomerService {
	@Resource private CCustomerDao cCustomerDao;
}
