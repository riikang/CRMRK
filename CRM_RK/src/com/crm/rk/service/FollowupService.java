package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Followup;

public interface FollowupService extends BaseService<Followup> {
	public List<Followup> findFollowupByChanceId(int id);
}
