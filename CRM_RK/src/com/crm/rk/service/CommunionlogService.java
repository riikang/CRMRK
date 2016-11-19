package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Communionlog;

public interface CommunionlogService extends BaseService<Communionlog> {
	public List<Communionlog> findCommunionlogBySerid(int sid);
}
