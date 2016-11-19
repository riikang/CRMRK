package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Sendlog;

public interface SendlogService extends BaseService<Sendlog> {
	public List<Sendlog> findSendlogByOrders(String id);
}
