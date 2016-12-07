package com.crm.rk.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Channel;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Mission;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.Servicelog;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.MissionService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.SalesmanService;
import com.crm.rk.service.ServicelogService;
import com.crm.rk.service.UserPowerService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.excelutils.ExcelException;
import net.sf.excelutils.ExcelUtils;

public class SalesmanAction extends ActionSupport {
	@Resource private SalesmanService salesmanService;
	@Resource private ChannelService channelService;
	@Resource private UserPowerService userPowerService;
	@Resource private OrderService orderService;
	@Resource private ChanceService chanceService;
	@Resource private MissionService missionService;
	@Resource private ServicelogService servicelogService;
	private Salesman salesman;
	private Channel channel;
	private UserPower userPower;
	private List<UserPower> userPowers;
	private List<Salesman> salesmans;
	private List<Channel> channels;
	private List<Orders> orderss;
	private List<Chance> chances;
	private List<Mission> missions;
	private List<Servicelog> servicelogs;
	private String sid;
	private String idtype;
	public String getIdtype() {
		return idtype;
	}
	public void setIdtype(String idtype) {
		this.idtype = idtype;
	}
	public UserPower getUserPower() {
		return userPower;
	}
	public void setUserPower(UserPower userPower) {
		this.userPower = userPower;
	}
	public List<UserPower> getUserPowers() {
		return userPowers;
	}
	public void setUserPowers(List<UserPower> userPowers) {
		this.userPowers = userPowers;
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
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public List<Salesman> getSalesmans() {
		return salesmans;
	}
	public void setSalesmans(List<Salesman> salesmans) {
		this.salesmans = salesmans;
	}
	
	public String findAllsalesman() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<3){
				return "error";
			}else{
				if(level==3){
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					salesmans=salesmanService.findSalesmanByChannel(salesman.getChannel().getId());
					return "findAllsalesman_s";
				}else {
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					salesmans=salesmanService.findAllByManager(Salesman.class, manager.getId());
					return "findAllsalesman_s";
				}
			}
		}else{
			return "error";
		}
	}
	
	public String findTheSalesman() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				salesman=salesmanService.findById(Salesman.class, salesman.getId());
				return "findTheSalesman_s";
			}
		}else {
			return "error";
		}
	}
	
	public String addSalesman() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null|level<3){
				return "error";
			}else{
				UserPower userPower1=new UserPower();
				if(idtype.equals("是")){
					userPower1.setLevel(3);
				}else{
					userPower1.setLevel(2);
				}
				userPower1.setUsername(salesman.getEmail());
				String pw=salesman.getEmail().substring(0, salesman.getEmail().indexOf("@"));
				userPower1.setPassword(pw);
				userPowerService.save(userPower1);
				userPowers=userPowerService.findAll(UserPower.class);
				salesman.setUserPower(userPowers.get(userPowers.size()-1));
				salesman.setManager(manager);
				channel=channelService.findChannelByName(channel.getCname());
				salesman.setChannel(channel);
				salesmanService.save(salesman);
				return "addSalesman_s";
			}
		}else{
			return "error";
		}
	}
	
	public String ifcandeleteone(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			int deleteid=Integer.parseInt(request.getParameter("deleteid"));
			String result="";
			orderss=orderService.findBySalesman(deleteid);
			chances=chanceService.findChanceBySalesman(deleteid);
			missions=missionService.findMissionBySalesman(deleteid);
			servicelogs=servicelogService.findBySalesman(deleteid);
			if(orderss.size()>0 || chances.size()>0 || missions.size()>0 || servicelogs.size()>0 ){
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
	
	public String ifcandelete(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			String deleteid=request.getParameter("deleteid");
			String result="";
			String deleteid1[]=deleteid.split(", ");
			int [] deleteid2 = new int[deleteid1.length];
			for(int i=0;i<deleteid1.length;i++){
				deleteid2[i]=Integer.parseInt(deleteid1[i]);
				orderss=orderService.findBySalesman(deleteid2[i]);
				chances=chanceService.findChanceBySalesman(deleteid2[i]);
				missions=missionService.findMissionBySalesman(deleteid2[i]);
				servicelogs=servicelogService.findBySalesman(deleteid2[i]);
				if(orderss.size()>0 || chances.size()>0 || missions.size()>0 || servicelogs.size()>0 ){
					result="1";
					break;
				}else{
					result="0";
				}
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
	
	public String deleteSomeSalesman() throws Exception{
		if(sid==null||sid==""){
			System.out.println("没有数据");
			return "deleteSomeSalesman_f";
		}
		else{
			String sid1[]=sid.split(", ");
			int [] sid2 = new int[sid1.length];
			for(int i=0;i<sid1.length;i++){
				sid2[i]=Integer.parseInt(sid1[i]);
			}
			for(int i=0;i<sid2.length;i++){
				salesmanService.deleteById(Salesman.class, sid2[i]);
			}
			return "deleteSomeSalesman_s";
		}
	}
	
	public String updateSalesman() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<3){
				return "error";
			}else{
				userPower=userPowerService.findById(UserPower.class, userPower.getId());
				if(idtype.equals("是")){
					userPower.setLevel(3);
				}else{
					userPower.setLevel(2);
				}
				userPower.setManager(manager);
				userPower.setUsername(salesman.getEmail());
				salesman.setUserPower(userPower);
				salesman.setManager(manager);
				channel=channelService.findChannelByName(channel.getCname());
				salesman.setChannel(channel);
				userPowerService.update(userPower);
				salesmanService.update(salesman);
				return "updateSalesman_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteTheSalesman() throws Exception{
		salesmanService.deleteById(Salesman.class,salesman.getId());
		return "deleteTheSalesman_s";
	}
	
	public void exportTableMessage() throws ExcelException, IOException{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
			}else{
				salesmans=salesmanService.findAllByManager(Salesman.class, manager.getId());
				ExcelUtils.addValue("dataList", salesmans);
		    	String tplpath = "/report/excel/exportSalesmanInfomation.xls";
		    	response.reset();
		    	response.addHeader("Content-Type", "application/vnd.ms-excel");
		    	String filename = "销售员信息统计";
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
			String sname=request.getParameter("sname");
			String result="";
			salesmans=salesmanService.findSalesmanByNameAndManager(sname, manager.getId());
			if(salesmans.size()>0){
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
			String sname=request.getParameter("sname");
			int salesmanid=Integer.valueOf(request.getParameter("salesmanid"));
			String result="";
			salesman=salesmanService.findById(Salesman.class, salesmanid);
			if(!salesman.getSname().equals(sname)){
				salesmans=salesmanService.findSalesmanByNameAndManager(sname, manager.getId());
				if(salesmans.size()>0){
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
