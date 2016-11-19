package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Channel;

public interface ChannelDao extends BaseDao<Channel> {
	public Channel findChannelByName(String cname);
	public List<Channel> findChannelByNameAndManager(String cname,int id);
}
