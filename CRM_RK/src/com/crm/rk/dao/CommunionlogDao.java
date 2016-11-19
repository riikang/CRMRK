package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Communionlog;

public interface CommunionlogDao extends BaseDao<Communionlog> {
	public List<Communionlog> findCommunionlogBySerid(int sid);
}
