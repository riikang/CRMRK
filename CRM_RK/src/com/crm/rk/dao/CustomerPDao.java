package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.CustomerP;

public interface CustomerPDao extends BaseDao<CustomerP> {
	public List<CustomerP> findCustomerPByName(String name);
	public List<CustomerP> findCustomerPByUserPower(int id);
	public List<CustomerP> findCustomerPByNameAndManager(String name, int id);
	public List<CustomerP> findCustomerPByifcompanyAndManager(String ifm,int id);
	public List<CustomerP> findCustomerPByStatusAndManager(String string1,int id);
	public List<CustomerP> findCustomerPByTypeAndManager(String string1,int id);
}
