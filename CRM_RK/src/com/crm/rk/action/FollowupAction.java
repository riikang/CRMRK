package com.crm.rk.action;

import java.util.List;

import javax.annotation.Resource;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Followup;
import com.crm.rk.model.Manager;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.FollowupService;
import com.opensymphony.xwork2.ActionContext;

public class FollowupAction {
	@Resource private FollowupService followupService;
	@Resource private ChanceService chanceService;
	Followup followup;
	Chance chance;
	List<Followup> followups;
	List<Chance> chances;
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
	
	public String deleteSomefollowup(){
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
				System.out.println(fid2[i]);
			}
			return "deleteSomefollowup_s";
		}
	}
	
	public String deleteTheFollowup() throws Exception{
		//followupService.deleteById(Followup.class, followup.getId());
		System.out.println(followup.getId());
		return "deleteTheFollowup_s";
	}
	
	public String updateFollowup() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				chance=chanceService.findById(Chance.class, followup.getChance().getId());
				chance.setStage(followup.getStage());
				chanceService.update(chance);
				followup.setChance(chance);
				followupService.update(followup);
				return "updateFollowup_s";
			}
		}else {
			return "error";
		}
	}
	
}
