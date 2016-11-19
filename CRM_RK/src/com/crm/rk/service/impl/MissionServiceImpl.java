package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.MissionDao;
import com.crm.rk.model.Mission;
import com.crm.rk.service.MissionService;
@Transactional(readOnly = false)
public class MissionServiceImpl extends BaseServiceImpl<Mission> implements MissionService {
	@Resource private MissionDao missionDao;
	public List<Mission> findMissionByChannel(int id){
		return missionDao.findMissionByChannel(id);
	}
	public List<Mission> findMissionBySalesman(int id){
		return missionDao.findMissionBySalesman(id);
	}
}
