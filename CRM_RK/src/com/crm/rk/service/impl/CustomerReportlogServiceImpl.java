package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.CustomerReportlogDao;
import com.crm.rk.model.CustomerReportlog;
import com.crm.rk.service.CustomerReportlogService;
@Transactional(readOnly = false)
public class CustomerReportlogServiceImpl extends BaseServiceImpl<CustomerReportlog> implements CustomerReportlogService {
	@Resource private CustomerReportlogDao customerReportlogDao;
	public List<CustomerReportlog> findIfHavaReportlog(int id1,int id2){
		return customerReportlogDao.findIfHavaReportlog(id1, id2);
	}
	public List<CustomerReportlog> findCustomerReportlogByCrid(int id){
		return customerReportlogDao.findCustomerReportlogByCrid(id);
	}
	public void deleteByCustomerReportId(Class<CustomerReportlog> entityClass,List<CustomerReportlog> customerreportlogs){
		customerReportlogDao.deleteByCustomerReportId(entityClass, customerreportlogs);
	}
}
