/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netcracker.wind.commands.implementations.csedashboard;

import com.netcracker.wind.commands.ICommand;
import com.netcracker.wind.dao.factory.FactoryCreator;
import com.netcracker.wind.dao.interfaces.IUserDAO;
import com.netcracker.wind.entities.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Anatolii
 */
public class CustomerReview implements ICommand {

    private static final String ID = "id";

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        int customerId = Integer.parseInt(request.getParameter(ID));
        IUserDAO userDAO = FactoryCreator.getInstance().getFactory().createUserDAO();
        User user = userDAO.findById(customerId);
        if (user == null) {
            return "";
        }
        request.setAttribute("customer", user);
        return "/WEB-INF/cse/cse-page-customer-review.jsp";
    }

}
