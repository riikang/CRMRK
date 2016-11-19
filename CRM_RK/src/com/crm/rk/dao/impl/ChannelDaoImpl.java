package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ChannelDao;
import com.crm.rk.model.Channel;

public class ChannelDaoImpl extends BaseDaoImpl<Channel> implements ChannelDao {
	public Channel findChannelByName(String cname){
		List<Channel> channels;
		channels=(List<Channel>)getHibernateTemplate().find("from Channel where cname ='"+cname+"'");
		return channels.get(0);
	}
	public List<Channel> findChannelByNameAndManager(String cname,int id){
		return (List<Channel>)getHibernateTemplate().find("from Channel where cname ='"+cname+"' and manager.id='"+id+"'");
	}
}
