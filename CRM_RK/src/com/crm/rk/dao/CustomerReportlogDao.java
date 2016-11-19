package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.CustomerReportlog;

public interface CustomerReportlogDao extends BaseDao<CustomerReportlog> {
	public List<CustomerReportlog> findIfHavaReportlog(int id1,int id2);
	public List<CustomerReportlog> findCustomerReportlogByCrid(int id);
}
