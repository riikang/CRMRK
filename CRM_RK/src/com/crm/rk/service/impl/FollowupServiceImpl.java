package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.FollowupDao;
import com.crm.rk.model.Followup;
import com.crm.rk.service.FollowupService;

@Transactional(readOnly = false)
public class FollowupServiceImpl extends BaseServiceImpl<Followup> implements FollowupService {
	@Resource FollowupDao followupDao;
	public List<Followup> findFollowupByChanceId(int id){
		return followupDao.findFollowupByChanceId(id);
	}
}
