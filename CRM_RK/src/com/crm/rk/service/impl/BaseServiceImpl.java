package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.BaseDao;
import com.crm.rk.service.BaseService;

@Transactional(readOnly = false)
public class BaseServiceImpl<T> implements BaseService<T> {
	
    @Resource private BaseDao baseDao;

	@Override
	public void save(T t) throws Exception {
		baseDao.add(t);	
	}

	@Override
	public void update(T t) throws Exception {
		baseDao.update(t);
		
	}

	@Override
	public void delete(T t) throws Exception {
		baseDao.delete(t);		
	}

	@Override
	public void deleteById(Class<T> entityClass,int id) throws Exception {
		baseDao.deleteById(entityClass,id);	
	}
	
	public List<T> findAllByManager(Class<T> entityClass,int id){
		return baseDao.findAllByManager(entityClass, id);
	}
	
	@Override
	public List<T> findAll(Class<T> entityClass) throws Exception {
		return baseDao.findAll(entityClass);
	}

	@Override
	public T findById(Class<T> entityClass,int id) throws Exception {
		return (T) baseDao.findById(entityClass,id);
		
	}

	@Override
	public T findForObject(T entity) {
		return null;
	}
	
}
