package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ChannelDao;
import com.crm.rk.model.Channel;
import com.crm.rk.service.ChannelService;
@Transactional(readOnly = false)
public class ChannelServiceImpl extends BaseServiceImpl<Channel> implements ChannelService {
	@Resource private ChannelDao channelDao;
	public Channel findChannelByName(String cname){
		return channelDao.findChannelByName(cname);
	}
	public List<Channel> findChannelByNameAndManager(String cname,int id){
		return channelDao.findChannelByNameAndManager(cname, id);
	}
}
