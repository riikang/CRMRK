package com.crm.rk.dao;

import java.util.List;

public interface BaseDao<T> {
	// 添加
	public void add(T t) throws Exception;
	
	// 修改
	public void update(T t) throws Exception;
	 
	//按照对象删除
	public void delete(T t) throws Exception;
	
	// * 按照id删除
	public void deleteById(Class<T> entityClass,int id) throws Exception;
	
	//根据经理查
	public List<T> findAllByManager(Class<T> entityClass,int id);
	
	//查询所有
	public List<T> findAll(Class<T> entityClass) throws Exception;

	//按照id查询
	public T findById(Class<T> entityClass,int id) throws Exception;
	
	//以对象作为查询条件进行查询
	public T findForObject(final T entity);	
}
