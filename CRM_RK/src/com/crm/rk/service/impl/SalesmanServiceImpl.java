package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.SalesmanDao;
import com.crm.rk.model.Salesman;
import com.crm.rk.service.SalesmanService;
@Transactional(readOnly = false)
public class SalesmanServiceImpl extends BaseServiceImpl<Salesman> implements SalesmanService {
	@Resource private SalesmanDao salesmanDao;
	public List<Salesman> findSalesmanByChannel(int channel){
		return salesmanDao.findSalesmanByChannel(channel);
	}
	public List<Salesman> findSalesmanByName(String name){
		return salesmanDao.findSalesmanByName(name);
	}
	public List<Salesman> findSalesmanByUserPower(int id){
		return salesmanDao.findSalesmanByUserPower(id);
	}
	public List<Salesman> findSalesmanByNameAndManager(String name, int id){
		return salesmanDao.findSalesmanByNameAndManager(name, id);
	}
}
