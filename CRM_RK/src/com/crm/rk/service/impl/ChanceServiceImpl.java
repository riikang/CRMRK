package com.crm.rk.service.impl;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ChanceDao;
import com.crm.rk.model.Chance;
import com.crm.rk.service.ChanceService;

@Transactional(readOnly = false)
public class ChanceServiceImpl extends BaseServiceImpl<Chance> implements ChanceService {
	@Resource private ChanceDao chanceDao;
	public List<Chance> findChanceByName(String name){
		return chanceDao.findChanceByName(name);
	}
	public List<Chance> findChanceByNameAndManager(String name,int id){
		return chanceDao.findChanceByNameAndManager(name, id);
	}
	public List<Chance> findChanceByProduct(int id){
		return chanceDao.findChanceByProduct(id);
	}
	public List<Chance> findChanceByChannel(int id){
		return chanceDao.findChanceByChannel(id);
	}
	public List<Chance> findChanceBySalesman(int id){
		return chanceDao.findChanceBySalesman(id);
	}
	public List<Chance> findChanceByCustomerp(int id){
		return chanceDao.findChanceByCustomerp(id);
	}
}
