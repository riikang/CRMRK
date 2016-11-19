package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.UserPowerDao;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.UserPowerService;
@Transactional(readOnly = false)
public class UserPowerServiceImpl extends BaseServiceImpl<UserPower> implements UserPowerService {
	@Resource private UserPowerDao userPowerDao;
	public List<UserPower> findByUsername(String name){
		return userPowerDao.findByUsername(name);
	}
	public List<UserPower> findByEmail(String email){
		return userPowerDao.findByUsername(email);
	}
	public List<UserPower> findByUsernameAndManager(String name,int id){
		return userPowerDao.findByUsernameAndManager(name, id);
	}
}
