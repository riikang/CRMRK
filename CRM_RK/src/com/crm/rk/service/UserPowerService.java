package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.UserPower;

public interface UserPowerService extends BaseService<UserPower> {
	public List<UserPower> findByUsername(String name);
	public List<UserPower> findByEmail(String email);
	public List<UserPower> findByUsernameAndManager(String name,int id);
}
