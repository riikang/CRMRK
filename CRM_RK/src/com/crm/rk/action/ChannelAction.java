package com.crm.rk.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Channel;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.service.ChannelService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.excelutils.ExcelException;
import net.sf.excelutils.ExcelUtils;

public class ChannelAction extends ActionSupport {
	@Resource private ChannelService channelService;
	private Channel channel;
	private List<Channel> channels;
	private String cid;
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public List<Channel> getChannels() {
		return channels;
	}
	public void setChannels(List<Channel> channels) {
		this.channels = channels;
	}
	
	public String findAllchannel() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else{
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				return "findAllchannel_s";
			}
		}else {
			return "error";
		}
	}
	
	public String addChannel() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else{
				channel.setEnjoyDate(new Date());
				channel.setManager(manager);
				channelService.save(channel);
				return "addChannel_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteSomeChannel(){
		if(cid==null||cid==""){
			System.out.println("没有数据");
			return "deleteSomeChannel_f";
		}
		else{
			String cid1[]=cid.split(", ");
			int [] cid2 = new int[cid1.length];
			for(int i=0;i<cid1.length;i++){
				cid2[i]=Integer.parseInt(cid1[i]);
			}
			for(int i=0;i<cid2.length;i++){
				System.out.println(cid2[i]);
			}
			return "deleteSomeChannel_s";
		}
	}
	
	public String deleteTheChannel() throws Exception{
		System.out.println(channel.getId());
		//channelService.deleteById(Channel.class, channel.getId());
		return "deleteTheChannel_s";
	}
	
	public String findTheChannel() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else{
				channel=channelService.findById(Channel.class, channel.getId());
				return "findTheChannel_s";
			}
		}else {
			return "error";
		}
	}
	
	public String updateChannel() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else{
				channel.setManager(manager);
				channelService.update(channel);
				return "updateChannel_s";
			}
		}else{
			return "error";
		}
	}
	
	public void exportTableMessage() throws ExcelException, IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");			
			}else{
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				ExcelUtils.addValue("dataList", channels);
		    	String tplpath = "/report/excel/exportChannelInfomation.xls";
		    	response.reset();
		    	response.addHeader("Content-Type", "application/vnd.ms-excel");
		    	String filename = "渠道商信息统计";
		    	response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename,"UTF-8") + ".xls");
		    	ExcelUtils.export(request.getSession().getServletContext(),tplpath,response.getOutputStream());
			}
		}else{
			response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
		}
	}
	
	public String validateInput1(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String cname=request.getParameter("cname");
			String result="";
			channels=channelService.findChannelByNameAndManager(cname, manager.getId());
			if(channels.size()>0){
				result="1";
			}else{
				result="0";
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public String validateInput2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String cname=request.getParameter("cname");
			int channelid=Integer.valueOf(request.getParameter("channelid"));
			String result="";
			channel=channelService.findById(Channel.class, channelid);
			if(!channel.getCname().equals(cname)){
				channels=channelService.findChannelByNameAndManager(cname, manager.getId());
				if(channels.size()>0){
					result="1";
				}else{
					result="0";
				}
			}else{
				result="0";
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
