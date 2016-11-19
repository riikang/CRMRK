package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Manager;

public interface ManagerService extends BaseService<Manager> {
	public List<Manager> findByUserPower(int id);
}
