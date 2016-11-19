package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Channel;

public interface ChannelService extends BaseService<Channel> {
	public Channel findChannelByName(String cname);
	public List<Channel> findChannelByNameAndManager(String cname,int id);
}
