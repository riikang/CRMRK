package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.CustomerReportlog;

public interface CustomerReportlogService extends BaseService<CustomerReportlog> {
	public List<CustomerReportlog> findIfHavaReportlog(int id1,int id2);
	public List<CustomerReportlog> findCustomerReportlogByCrid(int id);
}