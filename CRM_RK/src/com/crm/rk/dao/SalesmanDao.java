package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Salesman;

public interface SalesmanDao extends BaseDao<Salesman> {
	public List<Salesman> findSalesmanByChannel(int channel);
	public List<Salesman> findSalesmanByName(String name);
	public List<Salesman> findSalesmanByUserPower(int id);
	public List<Salesman> findSalesmanByNameAndManager(String name, int id);
}
