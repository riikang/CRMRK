package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.MessageDao;
import com.crm.rk.model.Message;
import com.crm.rk.service.MessageService;
@Transactional(readOnly = false)
public class MessageServiceImpl extends BaseServiceImpl<Message> implements MessageService {
	@Resource MessageDao messageDao;
	public List<Message> findByLevelAndPid(int id1,int id2){
		return messageDao.findByLevelAndPid(id1, id2);
	}
	public List<Message> findByMidLevelAndPid(int id1,int id3,int id2){
		return messageDao.findByMidLevelAndPid(id1, id3, id2);
	}
}
