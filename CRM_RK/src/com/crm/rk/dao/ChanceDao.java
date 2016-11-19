package com.crm.rk.dao;

import java.util.List;

import com.crm.rk.model.Chance;

public interface ChanceDao extends BaseDao<Chance> {
	public List<Chance> findChanceByName(String name);
	public List<Chance> findChanceByNameAndManager(String name,int id);
	public List<Chance> findChanceByChannel(int id);
	public List<Chance> findChanceBySalesman(int id);
}
