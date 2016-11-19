package com.crm.rk.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ProductReportDao;
import com.crm.rk.model.ProductReport;
import com.crm.rk.service.ProductReportService;
@Transactional(readOnly = false)
public class ProductReportServiceImpl extends BaseServiceImpl<ProductReport> implements ProductReportService {
	@Resource ProductReportDao productReportDao;
}
