package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.CustomerReportlogDao;
import com.crm.rk.model.CustomerReportlog;
import com.crm.rk.model.Reportlog;

public class CustomerReportlogDaoImpl extends BaseDaoImpl<CustomerReportlog> implements CustomerReportlogDao {
	public List<CustomerReportlog> findIfHavaReportlog(int id1,int id2){
		return (List<CustomerReportlog>)getHibernateTemplate().find("from CustomerReportlog where customerReport.id='"+id1+"' and customerP.id='"+id2+"'");
	}
	public List<CustomerReportlog> findCustomerReportlogByCrid(int id){
		return (List<CustomerReportlog>)getHibernateTemplate().find("from CustomerReportlog where customerReport.id='"+id+"'");
	}
	public void deleteByCustomerReportId(Class<CustomerReportlog> entityClass,List<CustomerReportlog> customerreportlogs){
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		for(CustomerReportlog customerreportlog : customerreportlogs){
	         this.getHibernateTemplate().delete(entityName,customerreportlog);
	   }
	}
}
