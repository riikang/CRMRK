package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Mission;

public interface MissionService extends BaseService<Mission> {
	public List<Mission> findMissionByChannel(int id);
	public List<Mission> findMissionBySalesman(int id);
}
