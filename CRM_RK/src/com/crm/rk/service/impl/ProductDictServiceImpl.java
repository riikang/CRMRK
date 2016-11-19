package com.crm.rk.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ProductDictDao;
import com.crm.rk.model.ProductDict;
import com.crm.rk.service.ProductDictService;
@Transactional(readOnly = false)
public class ProductDictServiceImpl extends BaseServiceImpl<ProductDict> implements ProductDictService {
	@Resource private ProductDictDao productDictDao;
}
