package com.crm.rk.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.crm.rk.model.Channel;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Message;
import com.crm.rk.model.Mission;
import com.crm.rk.model.Salesman;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.MessageService;
import com.crm.rk.service.MissionService;
import com.crm.rk.service.SalesmanService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class MissionAction extends ActionSupport {
	@Resource private MissionService missionService;
	@Resource private ChannelService channelService;
	@Resource private SalesmanService salesmanService;
	@Resource private MessageService messageService;
	List<Message> messages;
	List<Mission> missions=new ArrayList<Mission>();
	List<Channel> channels;
	List<Salesman> salesmans;
	Message message;
	Mission mission;
	Channel channel;
	Salesman salesman;
	String mid;
	String meid;
	public String getMeid() {
		return meid;
	}
	public void setMeid(String meid) {
		this.meid = meid;
	}
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public List<Channel> getChannels() {
		return channels;
	}
	public void setChannels(List<Channel> channels) {
		this.channels = channels;
	}
	public List<Salesman> getSalesmans() {
		return salesmans;
	}
	public void setSalesmans(List<Salesman> salesmans) {
		this.salesmans = salesmans;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public List<Mission> getMissions() {
		return missions;
	}
	public void setMissions(List<Mission> missions) {
		this.missions = missions;
	}
	public Mission getMission() {
		return mission;
	}
	public void setMission(Mission mission) {
		this.mission = mission;
	}
	
	public String findAllmission() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(level==3){
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					missions=missionService.findMissionByChannel(salesman.getChannel().getId());
					return "findAllmission_s";
				}else if (level==2) {
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					channels=channelService.findAll(Channel.class);
					missions=missionService.findMissionBySalesman(salesman.getId());
					return "findAllmission_s";
				}else {
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					missions=missionService.findAllByManager(Mission.class, manager.getId());
					return "findAllmission_s";
				}
			}
		}else {
			return "error";
		}
	}
	
	public String findThemission() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				mission=missionService.findById(Mission.class, mission.getId());
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				salesmans=salesmanService.findSalesmanByChannel(mission.getChannel().getId());
				if(mission.getResult()==null){
					mission.setResult(" ");
				}
				ActionContext.getContext().getApplication().put("result1", mission.getResult());
				return "findThemission_s";
			}
		}else {
			return "error";
		}
	}
	
	public String findnewmission() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				String meid1[]=meid.split(",");
				int [] meid2 = new int[meid1.length];
				for(int i=0;i<meid1.length;i++){
					meid2[i]=Integer.parseInt(meid1[i]);
				}
				for(int i=0;i<meid2.length;i++){
					Mission mission1=new Mission();
					mission1=missionService.findById(Mission.class, meid2[i]);
					missions.add(mission1);
				}
				return "findnewmission_s";
			}
		}else{
			return "error";
		}
	}
	
	public String addMission() throws Exception {
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<3){
				return "error";
			}else {
				channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
				mission.setChannel(channels.get(0));
				mission.setManager(manager);
				mission.setStstus("等待分配");
				missionService.save(mission);
				missions=missionService.findAllByManager(Mission.class,manager.getId());
				int pid=0;
				salesmans=salesmanService.findSalesmanByChannel(missions.get(missions.size()-1).getChannel().getId());
				for (int i = 0; i < salesmans.size(); i++) {
					if(salesmans.get(i).getUserPower().getLevel()==3){
						pid=salesmans.get(i).getId();
					}
				}
				if(level==4){
					Message message1=new Message(1, 4, missions.get(missions.size()-1).getId(), 3, pid);
					messageService.save(message1);
				}
				return "addMission_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteSomeMission() throws Exception{
		if(mid==null||mid==""){
			System.out.println("没有数据");
			return "deleteSomeMission_f";
		}
		else{
			String mid1[]=mid.split(", ");
			int [] mid2 = new int[mid1.length];
			for(int i=0;i<mid1.length;i++){
				mid2[i]=Integer.parseInt(mid1[i]);
			}
			for(int i=0;i<mid2.length;i++){
				missionService.deleteById(Mission.class, mid2[i]);
			}
			return "deleteSomeMission_s";
		}
	}
	
	public String deleteTheMission() throws Exception{
		missionService.deleteById(Mission.class, mission.getId());
		return "deleteTheMission_s";
	}
	
	public String updateMission() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				String resultString=(String)ActionContext.getContext().getApplication().get("result1");
				String result2=mission.getResult();
				if(result2.length()>0||result2.length()>resultString.length()){
					SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");
					Date date=new Date();
					mission.setResult(mission.getResult()+"--"+dateFormater.format(date)+";");
				}
				mission.setUpdatetime(new Date());
				channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
				mission.setChannel(channels.get(0));
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				Mission mission1=new Mission();
				mission1=missionService.findById(Mission.class, mission.getId());
				
				if(salesmans.size()==0){
					mission.setStstus("等待分配");
					if(mission1.getSalesman()!=null){
						messages=messageService.findByMidLevelAndPid(mission.getId(), 2, mission1.getSalesman().getId());
						if(messages.size()>0){
							messageService.delete(messages.get(0));
						}
					}
				}else{
					mission.setSalesman(salesmans.get(0));
					mission.setStstus("进行中");
					if(mission1.getSalesman()==null){
						if(level==4){
							List<Salesman> salesmans1=salesmanService.findSalesmanByChannel(mission.getChannel().getId());
							for (int i = 0; i < salesmans1.size(); i++) {
								if(salesmans1.get(i).getUserPower().getLevel()==3){
									if(salesmans1.get(i).getId()!=salesmans.get(0).getId()){
										Message message1=new Message(1, 4, mission.getId(), 2, salesmans.get(0).getId());
										messageService.save(message1);
									}
								}
							}
						}else if(level==3){
							Salesman salesman1=(Salesman)ActionContext.getContext().getApplication().get("user");
							if(salesman1.getId()!=salesmans.get(0).getId()){
								Message message1=new Message(1, 4, mission.getId(), 2, salesmans.get(0).getId());
								messageService.save(message1);
							}
						}
					}else{
						if(mission1.getSalesman().getId()!=salesmans.get(0).getId()){
							messages=messageService.findByMidLevelAndPid(mission.getId(), 2, mission1.getSalesman().getId());
							if(messages.size()>0){
								messageService.delete(messages.get(0));
							}
							if(level==4){
								List<Salesman> salesmans1=salesmanService.findSalesmanByChannel(mission.getChannel().getId());
								for (int i = 0; i < salesmans1.size(); i++) {
									if(salesmans1.get(i).getUserPower().getLevel()==3){
										if(salesmans1.get(i).getId()!=salesmans.get(0).getId()){
											Message message1=new Message(1, 4, mission.getId(), 2, salesmans.get(0).getId());
											messageService.save(message1);
										}
									}
								}
								
							}else if(level==3){
								Salesman salesman1=(Salesman)ActionContext.getContext().getApplication().get("user");
								if(salesman1.getId()!=salesmans.get(0).getId()){
									Message message1=new Message(1, 4, mission.getId(), 2, salesmans.get(0).getId());
									messageService.save(message1);
								}
							}
						}
					}
				}
				
				if(mission1.getChannel().getId()!=channels.get(0).getId()){
					List<Salesman> salesmans2=salesmanService.findSalesmanByChannel(mission1.getChannel().getId());
					for (int i = 0; i < salesmans2.size(); i++) {
						if(salesmans2.get(i).getUserPower().getLevel()==3){
							messages=messageService.findByMidLevelAndPid(mission.getId(), 3, salesmans2.get(i).getId());
							if(messages.size()>0){
								messageService.delete(messages.get(0));
							}
						}
					}
					List<Salesman> salesmans1=salesmanService.findSalesmanByChannel(channels.get(0).getId());
					for (int i = 0; i < salesmans1.size(); i++) {
						if(salesmans1.get(i).getUserPower().getLevel()==3){
							Message message1=new Message(1, 4, mission.getId(), 3, salesmans1.get(i).getId());
							messageService.save(message1);
						}
					}
				}
				
				mission.setManager(manager);
				missionService.update(mission);
				return "updateMission_s";
			}
		}else {
			return "error";
		}
	}
}
