package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Reportlog;

public interface ReportlogDao extends BaseDao<Reportlog> {
	public List<Reportlog> findIfHavaReportlog(int id1,int id2);
	public List<Reportlog> findReportlogByPrid(int id);
	public List<Reportlog> findReportlogByProduct(int id);
	public void deleteByProductReportId(Class<Reportlog> entityClass,List<Reportlog> reportlogs);
}
