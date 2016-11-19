package com.crm.rk.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.crm.rk.dao.BaseDao;

public class BaseDaoImpl<T> extends HibernateDaoSupport implements BaseDao<T> {
	@Override
	public void add(T t) throws Exception {
		this.getHibernateTemplate().persist(t);
	}

	@Override
	public void update(T t) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(t);
	}

	@Override
	public void delete(T t) throws Exception {
		this.getHibernateTemplate().delete(t);
	}

	@Override
	public void deleteById(Class<T> entityClass,int id) throws Exception {
		// 获取实体类型名
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		this.getHibernateTemplate().delete(entityName, this.findById(entityClass, id));
	}
	
	public List<T> findAllByManager(Class<T> entityClass,int id) {
		// 获取实体类型名
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		return (List<T>) this.getHibernateTemplate().find("from" + " " + entityName + " " + "where manager.id='"+id+"'");
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public T findById(Class<T> entityClass,int id) throws Exception {
		return (T)this.getHibernateTemplate().get(entityClass, id);
	}
	
	@Override
	public T findForObject(T entity) {
		return null;
	}

	@Override
	public List<T> findAll(Class<T> entityClass) throws Exception {
		// 获取实体类型名
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		return (List<T>) this.getHibernateTemplate().find("from" + " " + entityName);
	}
}
