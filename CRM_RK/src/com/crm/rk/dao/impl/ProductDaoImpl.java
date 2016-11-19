package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ProductDao;
import com.crm.rk.model.Product;

public class ProductDaoImpl extends BaseDaoImpl<Product> implements ProductDao {
	public List<Product> findProductByName(String name){
		return (List<Product>) getHibernateTemplate().find("from Product where pname='"+name+"'");
	}
	public List<Product> findProductByNameAndManager(String name,int id){
		return (List<Product>) getHibernateTemplate().find("from Product where pname='"+name+"' and manager.id='"+id+"'");
	}
}
