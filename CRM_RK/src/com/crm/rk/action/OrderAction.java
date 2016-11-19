package com.crm.rk.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Channel;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.ProductDict;
import com.crm.rk.model.Salesman;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductDictService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.SalesmanService;
import com.opensymphony.xwork2.ActionContext;

import net.sf.excelutils.ExcelException;
import net.sf.excelutils.ExcelUtils;

public class OrderAction {
	@Resource private OrderService orderService;
	@Resource private CustomerPService customerPService;
	@Resource private ProductService productService;
	@Resource private ChannelService channelService;
	@Resource private ChanceService chanceService;
	@Resource private SalesmanService salesmanService;
	@Resource private ProductDictService productDictService;
	private ProductDict productDict;
	private List<ProductDict> productDicts;
	private Orders orders;
	private CustomerP customerP;
	private Product product;
	private Channel channel;
	private Chance chance;
	private Salesman salesman;
	private List<Orders> orderss;
	private List<CustomerP> customerPs;
	private List<Product> products;
	private List<Channel> channels;
	private List<Chance> chances;
	private List<Salesman> salesmans;
	private String oid;
	
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
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
	public Chance getChance() {
		return chance;
	}
	public void setChance(Chance chance) {
		this.chance = chance;
	}
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
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
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	public String findCustomerOrder(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			customerP=(CustomerP)ActionContext.getContext().getApplication().get("user");
			orderss=orderService.findByCustomer(customerP.getId(),manager.getId());
			return "findCustomerOrder_s";
		}else{
			return "error";
		}
		
	}
	
	public String findAllOrder() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(level==3){
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					orderss=orderService.findOrdersByChannel(salesman.getChannel().getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					products=productService.findAllByManager(Product.class, manager.getId());
					chances=chanceService.findAllByManager(Chance.class, manager.getId());
					productDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
					return "findAllOrder_s";
				}else if (level==2) {
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					orderss=orderService.findOrdersByChannelAndSalesman(salesman.getChannel().getId(), salesman.getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					products=productService.findAllByManager(Product.class, manager.getId());
					chances=chanceService.findAllByManager(Chance.class, manager.getId());
					productDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
					return "findAllOrder_s";
				}else{
					orderss=orderService.findAllByManager(Orders.class, manager.getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					products=productService.findAllByManager(Product.class, manager.getId());
					chances=chanceService.findAllByManager(Chance.class, manager.getId());
					productDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
					return "findAllOrder_s";
				}
			}
		}else {
			return "error";
		}
	}
	
	public String findTheOrder() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				products=productService.findAllByManager(Product.class, manager.getId());
				chances=chanceService.findAllByManager(Chance.class, manager.getId());
				salesmans=salesmanService.findSalesmanByChannel(orders.getSalesman().getChannel().getId());
				productDicts=productDictService.findAllByManager(ProductDict.class, manager.getId());
				return "findTheOrder_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteSomeorder(){
		if(oid==null||oid==""){
			System.out.println("没有数据");
			return "deleteSomeorder_f";
		}
		else{
			String oid1[]=oid.split(", ");
			for(int i=0;i<oid1.length;i++){
				System.out.println(oid1[i]);
				//orderService.deleteByStringId(oid1[i]);
			}
			return "deleteSomeorder_s";
		}
	}
	
	public String addorder() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				chances=chanceService.findChanceByNameAndManager(chance.getName(), manager.getId());
				if(chances.size()>0){
					orders.setChance(chances.get(0));
				}
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
				if(orders.getStatus().equals("已付清款项")){
					orders.setPaymoney(orders.getDealpriceT());
					orders.setRemainingPay(0);
				}
				else if(orders.getStatus().equals("未付款")){
					orders.setPaymoney(0);
					orders.setRemainingPay(orders.getDealpriceT());
				}
				else if(orders.getStatus().equals("已付部分款项")){
					orders.setPaymoney(0);
					orders.setRemainingPay(orders.getDealpriceT());
				}
				orders.setDealdate(new Date());
				orders.setCustomerP(customerPs.get(0));
				orders.setSalesman(salesmans.get(0));
				orders.setChannel(salesmans.get(0).getChannel());
				orders.setProduct(products.get(0));
				orders.setCostingT(products.get(0).getCosting()*orders.getAmount());
				orders.setDealpriceT(orders.getDealprice()*orders.getAmount());
				orders.setProfits((orders.getDealprice()-products.get(0).getCosting())*orders.getAmount());
				if(!orders.getCstatus().equals("")||orders.getCstatus()!=null){
					customerPs.get(0).setStatus(orders.getCstatus());
				}
				if(!orders.getCtype().equals("")||orders.getCtype()!=null){
					customerPs.get(0).setType(orders.getCtype());
				}
				orders.setManager(manager);
				orderService.save(orders);
				customerPService.update(customerPs.get(0));
				return "addorder_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteTheOrder(){
		System.out.println(orders.getId());
		//orderService.deleteByStringId(orders.getId());
		return "deleteTheOrder_s";
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
				orderss=orderService.findAllByManager(Orders.class, manager.getId());
				ExcelUtils.addValue("dataList", orderss);
		    	String tplpath = "/report/excel/exportOrdersInfomation.xls";
		    	response.reset();
		    	response.addHeader("Content-Type", "application/vnd.ms-excel");
		    	String filename = "订单信息统计";
		    	response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename,"UTF-8") + ".xls");
		    	ExcelUtils.export(request.getSession().getServletContext(),tplpath,response.getOutputStream());
			}
		}else{
			response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
		}
	}
	
	public String updateOrder() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				chances=chanceService.findChanceByNameAndManager(chance.getName(), manager.getId());
				if(chances.size()>0){
					orders.setChance(chances.get(0));
				}
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
				orders.setCustomerP(customerPs.get(0));
				orders.setSalesman(salesmans.get(0));
				orders.setChannel(salesmans.get(0).getChannel());
				orders.setProduct(products.get(0));
				orders.setCostingT(products.get(0).getCosting()*orders.getAmount());
				orders.setDealpriceT(orders.getDealprice()*orders.getAmount());
				orders.setProfits((orders.getDealprice()-products.get(0).getCosting())*orders.getAmount());
				if(!orders.getCstatus().equals("")||orders.getCstatus()!=null){
					customerPs.get(0).setStatus(orders.getCstatus());
				}
				if(!orders.getCtype().equals("")||orders.getCtype()!=null){
					customerPs.get(0).setType(orders.getCtype());
				}
				orders.setManager(manager);
				orderService.update(orders);
				customerPService.update(customerPs.get(0));
				return "updateOrder_s";
			}
		}else {
			return "error";
		}
	}
	
}
