package com.crm.rk.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.ProductDict;
import com.crm.rk.model.Reportlog;
import com.crm.rk.model.Servicelog;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductDictService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.ReportlogService;
import com.crm.rk.service.ServicelogService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
//商品动作类
public class ProductAction extends ActionSupport {
	@Resource private ProductService productService;
	@Resource private ProductDictService productDictService;
	@Resource private ChanceService chanceService;
	@Resource private OrderService orderService;
	@Resource private ServicelogService servicelogService;
	@Resource private ReportlogService reportlogService;
	private List<ProductDict> porductDicts;
	private Product product;
	private List<Product> products;
	private List<Chance> chances;
	private List<Orders> orderss;
	private List<Servicelog> servicelogs;
	private List<Reportlog> reportlogs;
	private String pid;
	private File upload;
	private String uploadFileName;
	
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public List<Servicelog> getServicelogs() {
		return servicelogs;
	}
	public void setServicelogs(List<Servicelog> servicelogs) {
		this.servicelogs = servicelogs;
	}
	public List<Reportlog> getReportlogs() {
		return reportlogs;
	}
	public void setReportlogs(List<Reportlog> reportlogs) {
		this.reportlogs = reportlogs;
	}
	public List<ProductDict> getPorductDicts() {
		return porductDicts;
	}
	public void setPorductDicts(List<ProductDict> porductDicts) {
		this.porductDicts = porductDicts;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	//读取所有商品信息（区分经理）
	public String findAllProduct() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				porductDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
				products=productService.findAllByManager(Product.class, manager.getId());
				return "findAllProduct_s";	
			}
		}else{
			return "error";
		}
	}
	
	//检查是否能删除商品（防止因为外键，而删除时报错）
	public String ifcandeleteone(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			int deleteid=Integer.parseInt(request.getParameter("deleteid"));
			String result="";
			chances=chanceService.findChanceByProduct(deleteid);
			orderss=orderService.findOrdersByProduct(deleteid);
			servicelogs=servicelogService.findByProduct(deleteid);
			if(chances.size()>0 || orderss.size()>0 || servicelogs.size()>0 ){
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
	
	//检查是否能删除商品（防止因为外键，而删除时报错）
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
				chances=chanceService.findChanceByProduct(deleteid2[i]);
				orderss=orderService.findOrdersByProduct(deleteid2[i]);
				servicelogs=servicelogService.findByProduct(deleteid2[i]);
				if(chances.size()>0 || orderss.size()>0 || servicelogs.size()>0 ){
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
	
	//删除多个商品
	public String deleteSomeProduct() throws Exception{
		if(pid==null||pid==""){
			System.out.println("没有数据");
			return "deleteSomeProduct_f";
		}
		else{
			String pid1[]=pid.split(", ");
			int [] pid2 = new int[pid1.length];
			for(int i=0;i<pid1.length;i++){
				pid2[i]=Integer.parseInt(pid1[i]);
			}
			for(int i=0;i<pid2.length;i++){
				reportlogs=reportlogService.findReportlogByProduct(pid2[i]);
				for (int j = 0; j < reportlogs.size(); j++) {
					reportlogService.deleteById(Reportlog.class, reportlogs.get(j).getId());
				}
				productService.deleteById(Product.class, pid2[i]);
			}
			return "deleteSomeProduct_s";
		}
	}
	
	//删除单个商品
	public String deleteTheProduct() throws Exception{
		reportlogs=reportlogService.findReportlogByProduct(product.getId());
		for (int j = 0; j < reportlogs.size(); j++) {
			reportlogService.deleteById(Reportlog.class, reportlogs.get(j).getId());
		}
		productService.deleteById(Product.class, product.getId());
		return "deleteTheProduct_s";
	}
	
	//新增商品
	public String addProduct() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				String imgPath=null;
				if(upload!=null){
					String path=ServletActionContext.getServletContext().getRealPath("/productImg");
					File file=new File(path);
					if (!file.exists()) {
						file.mkdir();
					}
					imgPath="productImg/"+uploadFileName;
					FileUtils.copyFile(upload, new File(file,uploadFileName));
				}
				product.setManager(manager);
				product.setPicture(imgPath);
				productService.save(product);
				return "addProduct_s";
			}
		}else {
			return "error";
		}
		
	}
	
	//更新商品
	public String updateProduct() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				String imgPath=null;
				if(upload!=null){
					String path=ServletActionContext.getServletContext().getRealPath("/productImg");
					File file=new File(path);
					if (!file.exists()) {
						file.mkdir();
					}
					imgPath="productImg/"+uploadFileName;
					FileUtils.copyFile(upload, new File(file,uploadFileName));
					product.setPicture(imgPath);
				}
				product.setManager(manager);
				productService.update(product);
				return "updateProduct_s";
			}
		}else {
			return "error";
		}
	}
	
	//读取某个商品的详细信息
	public String findTheProduct() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				porductDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
				product=productService.findById(Product.class, product.getId());
				return "findTheProduct_s";
			}
		}else {
			return "error";
		}
	}
	
	//验证商品名是否重复(新增)
	public String validateInput(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String pn=request.getParameter("pn");
			products=productService.findProductByNameAndManager(pn, manager.getId());
			String result="";
			if(products.size()==0){
				result="0";
			}else{
				result="1";
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
	
	//验证商品名是否重复(更新)
	public String validateInput2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String pn=request.getParameter("pn");
			int pid=Integer.valueOf(request.getParameter("pid"));
			product=productService.findById(Product.class, pid);
			products=productService.findProductByNameAndManager(pn, manager.getId());
			String result="";
			if(products.size()==0){
				result="0";
			}else{
				if(products.get(0).getPname().equals(product.getPname())){
					result="2";
				}else{
					result="1";
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
	
}
