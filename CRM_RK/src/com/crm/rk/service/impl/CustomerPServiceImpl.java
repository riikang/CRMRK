package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.CustomerPDao;
import com.crm.rk.model.CustomerP;
import com.crm.rk.service.CustomerPService;
@Transactional(readOnly = false)
public class CustomerPServiceImpl extends BaseServiceImpl<CustomerP> implements CustomerPService {
	@Resource private CustomerPDao customerPDao;
	public List<CustomerP> findCustomerPByName(String name){
		return customerPDao.findCustomerPByName(name);
	}
	public List<CustomerP> findCustomerPByUserPower(int id){
		return customerPDao.findCustomerPByUserPower(id);
	}
	public List<CustomerP> findCustomerPByNameAndManager(String name, int id){
		return customerPDao.findCustomerPByNameAndManager(name, id);
	}
	public List<CustomerP> findCustomerPByifcompanyAndManager(String ifm,int id){
		return customerPDao.findCustomerPByifcompanyAndManager(ifm, id);
	}
	public List<CustomerP> findCustomerPByStatusAndManager(String string1,int id){
		return customerPDao.findCustomerPByStatusAndManager(string1, id);
	}
	public List<CustomerP> findCustomerPByTypeAndManager(String string1,int id){
		return customerPDao.findCustomerPByTypeAndManager(string1, id);
	}
}
