package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ManagerDao;
import com.crm.rk.model.Manager;
import com.crm.rk.service.ManagerService;
@Transactional(readOnly = false)
public class ManagerServiceImpl extends BaseServiceImpl<Manager> implements ManagerService {
	@Resource private ManagerDao managerDao;
	public List<Manager> findByUserPower(int id){
		return managerDao.findByUserPower(id);
	}
}
