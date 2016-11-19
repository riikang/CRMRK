package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Paylog;

public interface PaylogDao extends BaseDao<Paylog> {
	public List<Paylog> findPaylogByOrders(String id);
}
