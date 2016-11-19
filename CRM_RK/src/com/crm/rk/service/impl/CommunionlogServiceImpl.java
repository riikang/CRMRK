package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.CommunionlogDao;
import com.crm.rk.model.Communionlog;
import com.crm.rk.service.CommunionlogService;
@Transactional(readOnly = false)
public class CommunionlogServiceImpl extends BaseServiceImpl<Communionlog> implements CommunionlogService  {
	@Resource private CommunionlogDao communionlogDao;
	public List<Communionlog> findCommunionlogBySerid(int sid){
		return communionlogDao.findCommunionlogBySerid(sid);
	}
}
