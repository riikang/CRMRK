package com.crm.rk.service;

import java.util.List;

import com.crm.rk.dao.BaseDao;
import com.crm.rk.model.Product;

public interface ProductService extends BaseService<Product> {
	public List<Product> findProductByName(String name);
	public List<Product> findProductByNameAndManager(String name,int id);
}
