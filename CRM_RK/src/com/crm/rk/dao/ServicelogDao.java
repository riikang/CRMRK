package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Servicelog;

public interface ServicelogDao extends BaseDao<Servicelog> {
	public List<Servicelog> findByChannel(int id);
	public List<Servicelog> findBySalesman(int id);
	public List<Servicelog> findByProduct(int id);
	public List<Servicelog> findByCustomer(int id);
	public List<Servicelog> findByOrders(String id);
}
