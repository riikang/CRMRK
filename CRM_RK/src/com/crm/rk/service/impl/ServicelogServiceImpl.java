package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ServicelogDao;
import com.crm.rk.model.Servicelog;
import com.crm.rk.service.ServicelogService;
@Transactional(readOnly = false)
public class ServicelogServiceImpl extends BaseServiceImpl<Servicelog> implements ServicelogService {
	@Resource private ServicelogDao servicelogDao;
	public List<Servicelog> findByChannel(int id){
		return servicelogDao.findByChannel(id);
	}
	public List<Servicelog> findBySalesman(int id){
		return servicelogDao.findBySalesman(id);
	}
	public List<Servicelog> findByCustomer(int id){
		return servicelogDao.findByCustomer(id);
	}
}


