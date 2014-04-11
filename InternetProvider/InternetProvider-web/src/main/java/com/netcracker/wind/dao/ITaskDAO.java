/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netcracker.wind.dao;

import com.netcracker.wind.entities.Task;

/**
 *
 * @author Oksana
 */
public interface ITaskDAO {

    public void add(Task task);

    public void delete(int id);

    public Task findByID(int id);

    public void update(Task task);

}