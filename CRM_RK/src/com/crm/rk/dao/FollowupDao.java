package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Followup;

public interface FollowupDao extends BaseDao<Followup> {
	public List<Followup> findFollowupByChanceId(int id);
}
