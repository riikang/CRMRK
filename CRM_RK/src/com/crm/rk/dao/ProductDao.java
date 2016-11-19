package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Product;

public interface ProductDao extends BaseDao<Product> {
	public List<Product> findProductByName(String name);
	public List<Product> findProductByNameAndManager(String name,int id);
}
