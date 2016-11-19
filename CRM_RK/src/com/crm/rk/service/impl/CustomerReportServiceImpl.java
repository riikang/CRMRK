package com.crm.rk.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.CustomerReportDao;
import com.crm.rk.model.CustomerReport;
import com.crm.rk.service.CustomerReportService;
@Transactional(readOnly = false)
public class CustomerReportServiceImpl extends BaseServiceImpl<CustomerReport> implements CustomerReportService {
	@Resource private CustomerReportDao customerReportDao;
}
