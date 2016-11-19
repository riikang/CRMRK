package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Sendlog;

public interface SendlogDao extends BaseDao<Sendlog> {
	public List<Sendlog> findSendlogByOrders(String id);
}
