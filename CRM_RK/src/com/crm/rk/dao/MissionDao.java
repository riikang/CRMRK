package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Mission;

public interface MissionDao extends BaseDao<Mission> {
	public List<Mission> findMissionByChannel(int id);
	public List<Mission> findMissionBySalesman(int id);
}
