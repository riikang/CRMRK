package com.crm.rk.action;

import java.util.List;

import javax.annotation.Resource;

import com.crm.rk.model.Chance;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Followup;
import com.crm.rk.model.Manager;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.FollowupService;
import com.opensymphony.xwork2.ActionContext;
//跟踪记录动作类
public class FollowupAction {
	@Resource private FollowupService followupService;
	@Resource private ChanceService chanceService;
	@Resource private CustomerPService customerPService;
	Followup followup;
	Chance chance;
	List<Followup> followups;
	List<Chance> chances;
	List<CustomerP> customerPs;
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}

	private String fid;
	
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public Followup getFollowup() {
		return followup;
	}
	public void setFollowup(Followup followup) {
		this.followup = followup;
	}
	public Chance getChance() {
		return chance;
	}
	public void setChance(Chance chance) {
		this.chance = chance;
	}
	public List<Followup> getFollowups() {
		return followups;
	}
	public void setFollowups(List<Followup> followups) {
		this.followups = followups;
	}
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
	}
	
	//读取所有跟踪记录（区分销售机会）
	public String findAllFollowup() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(ActionContext.getContext().getApplication().get("chanceid")!=null){
					int chanceid=(Integer)ActionContext.getContext().getApplication().get("chanceid");
					followups=followupService.findFollowupByChanceId(chanceid);
				}
				return "findAllFollowup_s";
			}
		}else {
			return "error";
		}
	}
	
	//读取单个跟踪记录
	public String findThefollowup() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				followup=followupService.findById(Followup.class, followup.getId());
				return "findThefollowup_s";
			}
		}else {
			return "error";
		}
	}
	
	//新增跟踪记录
	public String addfollowup() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				int chanceid=(Integer)ActionContext.getContext().getApplication().get("chanceid");
				chance=chanceService.findById(Chance.class, chanceid);
				followup.setChance(chance);
				followup.setFollowstage("跟进中");
				followupService.save(followup);
				return "addfollowup_s";
			}
		}else {
			return "error";
		}
	}
	
	//删除销售记录（多个）
	public String deleteSomefollowup() throws Exception{
		if(fid==null||fid==""){
			System.out.println("没有数据");
			return "deleteSomefollowup_f";
		}
		else{
			String fid1[]=fid.split(", ");
			int [] fid2 = new int[fid1.length];
			for(int i=0;i<fid1.length;i++){
				fid2[i]=Integer.parseInt(fid1[i]);
			}
			for(int i=0;i<fid2.length;i++){
				followupService.deleteById(Followup.class, fid2[i]);
			}
			return "deleteSomefollowup_s";
		}
	}
	
	//删除销售记录（单个 ）
	public String deleteTheFollowup() throws Exception{
		followupService.deleteById(Followup.class, followup.getId());
		return "deleteTheFollowup_s";
	}
	
	//更新销售记录（根据“跟踪阶段”，更新客户状态）
	public String updateFollowup() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				chance=chanceService.findById(Chance.class, followup.getChance().getId());
				if(followup.getFollowstage().equals("跟进完成")){
					chance.setStage(followup.getStage());
					customerPs=customerPService.findCustomerPByNameAndManager(chance.getCustomerP().getCname(), manager.getId());
					if(chance.getStage().equals("确认订单")||chance.getStage().equals("成功交易")){
						customerPs.get(0).setStatus("成交客户");
					}else if(chance.getStage().equals("失败交易")){
						customerPs.get(0).setStatus("已流失客户");
					}else{
						customerPs.get(0).setStatus("意向客户");
					}
					customerPService.update(customerPs.get(0));
					chanceService.update(chance);
				}
				
				followup.setChance(chance);
				followupService.update(followup);
				return "updateFollowup_s";
			}
		}else {
			return "error";
		}
	}
	
}
