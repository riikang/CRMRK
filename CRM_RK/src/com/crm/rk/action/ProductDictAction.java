package com.crm.rk.action;

import java.util.List;

import javax.annotation.Resource;

import com.crm.rk.model.Manager;
import com.crm.rk.model.ProductDict;
import com.crm.rk.service.ProductDictService;
import com.crm.rk.service.ProductService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
//商品字典动作类
public class ProductDictAction extends ActionSupport {
	@Resource private ProductDictService productDictService;
	private ProductDict productDict;
	private List<ProductDict> productDicts;
	public ProductDict getProductDict() {
		return productDict;
	}
	public void setProductDict(ProductDict productDict) {
		this.productDict = productDict;
	}
	public List<ProductDict> getProductDicts() {
		return productDicts;
	}
	public void setProductDicts(List<ProductDict> productDicts) {
		this.productDicts = productDicts;
	}
	
	//读取所有字典
	public String findAllDict() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				productDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
				return "findAllDict_s";
			}
		}else {
			return "error";
		}
	}
	
	//新增数据字典
	public String addDict() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				productDict.setManager(manager);
				productDictService.save(productDict);
				return "addDict_s";
			}
		}else {
			return "error";
		}
	}
	
	//删除数据字典
	public String deleteDict() throws Exception{
		productDictService.deleteById(ProductDict.class, productDict.getId());
		return "deleteDictDict_s";
	}
	
	
	
}
