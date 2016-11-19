package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.BaseDao;
import com.crm.rk.dao.ProductDao;
import com.crm.rk.model.Product;
import com.crm.rk.service.ProductService;

@Transactional(readOnly = false)
public class ProductServiceImpl extends BaseServiceImpl<Product> implements ProductService {
	@Resource private ProductDao productDao;
	public List<Product> findProductByName(String name){
		return productDao.findProductByName(name);
	}
	public List<Product> findProductByNameAndManager(String name,int id){
		return productDao.findProductByNameAndManager(name, id);
	}
}
