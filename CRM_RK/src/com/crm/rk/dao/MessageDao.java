package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Message;

public interface MessageDao extends BaseDao<Message> {
	public List<Message> findByLevelAndPid(int id1,int id2);
	public List<Message> findByMidLevelAndPid(int id1,int id3,int id2);
}
