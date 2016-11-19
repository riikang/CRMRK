package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Message;

public interface MessageService extends BaseService<Message> {
	public List<Message> findByLevelAndPid(int id1,int id2);
	public List<Message> findByMidLevelAndPid(int id1,int id3,int id2);
}
