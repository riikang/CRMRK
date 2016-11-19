package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Paylog;

public interface PaylogService extends BaseService<Paylog> {
	public List<Paylog> findPaylogByOrders(String id);
}
