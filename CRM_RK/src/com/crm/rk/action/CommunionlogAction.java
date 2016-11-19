package com.crm.rk.action;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Communionlog;
import com.crm.rk.model.Servicelog;
import com.crm.rk.service.CommunionlogService;
import com.crm.rk.service.ServicelogService;
import com.crm.rk.util.JsonDateValueProcessor;
import com.opensymphony.xwork2.ActionContext;

public class CommunionlogAction {
	@Resource private CommunionlogService communionlogService;
	@Resource private ServicelogService servicelogService;
	private List<Servicelog> servicelogs;
	private List<Communionlog> communionlogs;
	private Communionlog communionlog;
	private Servicelog servicelog;
	public List<Servicelog> getServicelogs() {
		return servicelogs;
	}
	public void setServicelogs(List<Servicelog> servicelogs) {
		this.servicelogs = servicelogs;
	}
	public List<Communionlog> getCommunionlogs() {
		return communionlogs;
	}
	public void setCommunionlogs(List<Communionlog> communionlogs) {
		this.communionlogs = communionlogs;
	}
	public Communionlog getCommunionlog() {
		return communionlog;
	}
	public void setCommunionlog(Communionlog communionlog) {
		this.communionlog = communionlog;
	}
	public Servicelog getServicelog() {
		return servicelog;
	}
	public void setServicelog(Servicelog servicelog) {
		this.servicelog = servicelog;
	}
	
	public String addCommunionlogByAjax() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		int cid=Integer.valueOf(request.getParameter("c_id")); 
		servicelog=servicelogService.findById(Servicelog.class, cid);
		Communionlog communionlog=new Communionlog();
		communionlog.setCdate(new Date());
		communionlog.setServicelog(servicelog);
		communionlog.setContext(request.getParameter("c_context"));
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(level==3||level==2){
				communionlog.setCrole("负责人");
				communionlog.setName(servicelog.getSalesman().getSname());
			}else if(level==4) {
				communionlog.setName("经理");
				communionlog.setCrole("经理");
			}else{
				communionlog.setName(servicelog.getCustomerP().getCname());
				communionlog.setCrole("客户");
			}
		}else {
			communionlog.setName("");
			communionlog.setCrole("");
		}
		communionlogService.save(communionlog);
		
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		communionlogs=communionlogService.findCommunionlogBySerid(cid);
		List<Communionlog> communionlogs1=new ArrayList<Communionlog>();
		if(communionlogs.size()<10){
			for (int i = communionlogs.size()-1; i >= 0; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}else{
			for (int i = communionlogs.size()-1; i >= communionlogs.size()-10; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}
		JSONArray jsonArray = JSONArray.fromObject(communionlogs1,jsonConfig);
		String jsonStr2=jsonArray.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr2);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	public String findAllCommunionlogByAjax() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		HttpServletRequest request=ServletActionContext.getRequest();
		int cid=Integer.valueOf(request.getParameter("ididid"));
		communionlogs=communionlogService.findCommunionlogBySerid(cid);
		List<Communionlog> communionlogs1=new ArrayList<Communionlog>();
		if(communionlogs.size()<10){
			for (int i = communionlogs.size()-1; i >= 0; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}else{
			for (int i = communionlogs.size()-1; i >= communionlogs.size()-10; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}
		JSONArray jsonArray = JSONArray.fromObject(communionlogs1,jsonConfig);
		String jsonStr=jsonArray.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("解析失败");
		}
		return null;
	}
	
	public String findMoreCommunionlogByAjax(){
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		HttpServletRequest request=ServletActionContext.getRequest();
		int index=Integer.valueOf(request.getParameter("index2"));
		int c_id=Integer.valueOf(request.getParameter("c_id"));
		communionlogs=communionlogService.findCommunionlogBySerid(c_id);
		int index_size=communionlogs.size()-index;
		List<Communionlog> communionlogs1=new ArrayList<Communionlog>();
		if(0<index_size&&index_size<=10){
			for (int i = communionlogs.size()-1; i >= 0 ; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}else if(index_size>10){
			for (int i = communionlogs.size()-1; i >= communionlogs.size()-10-index ; i--) {
				Communionlog communionlog1=new Communionlog();
				communionlog1.setCdate(communionlogs.get(i).getCdate());
				communionlog1.setContext(communionlogs.get(i).getContext());
				communionlog1.setName(communionlogs.get(i).getName());
				communionlog1.setCrole(communionlogs.get(i).getCrole());
				communionlogs1.add(communionlog1);
			}
		}else if(index_size<=0){
				Communionlog communionlog1=new Communionlog();
				communionlog1.setContext("endendend");
				communionlogs1.add(communionlog1);
		}
		JSONArray jsonArray = JSONArray.fromObject(communionlogs1,jsonConfig);
		String jsonStr=jsonArray.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
