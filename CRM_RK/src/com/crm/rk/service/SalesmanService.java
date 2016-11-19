package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Salesman;

public interface SalesmanService extends BaseService<Salesman> {
	public List<Salesman> findSalesmanByChannel(int channel);
	public List<Salesman> findSalesmanByName(String name);
	public List<Salesman> findSalesmanByUserPower(int id);
	public List<Salesman> findSalesmanByNameAndManager(String name, int id);
}
