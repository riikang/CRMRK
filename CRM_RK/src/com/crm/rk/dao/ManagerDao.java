package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Manager;

public interface ManagerDao extends BaseDao<Manager> {
	public List<Manager> findByUserPower(int id);
}
