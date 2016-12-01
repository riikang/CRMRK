package com.crm.rk.dao.impl;

import java.util.List;

import com.crm.rk.dao.ReportlogDao;
import com.crm.rk.model.Reportlog;

public class ReportlogDaoImpl extends BaseDaoImpl<Reportlog> implements ReportlogDao {
	public List<Reportlog> findIfHavaReportlog(int id1,int id2){
		return (List<Reportlog>)getHibernateTemplate().find("from Reportlog where productReport.id='"+id1+"' and product.id='"+id2+"'");
	}
	public List<Reportlog> findReportlogByPrid(int id){
		return (List<Reportlog>)getHibernateTemplate().find("from Reportlog where productReport.id='"+id+"'");
	}
	public void deleteByProductReportId(Class<Reportlog> entityClass,List<Reportlog> reportlogs){
		String  entityName = this.getHibernateTemplate().getSessionFactory().getClassMetadata(entityClass).getEntityName();
		for(Reportlog reportlog : reportlogs){
	         this.getHibernateTemplate().delete(entityName,reportlog);
	   }
	}
}
