package com.netcracker.wind.commands.implementations;

import com.netcracker.wind.commands.ICommand;
import com.netcracker.wind.dao.factory.AbstractFactoryDAO;
import com.netcracker.wind.dao.factory.FactoryCreator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Oksana
 */
public class ShowUser implements ICommand {

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        AbstractFactoryDAO factoryDAO
                = FactoryCreator.getInstance().getFactory();
        request.setAttribute("depts", factoryDAO.createUserDAO().findByRole(1));
        return "printUsers.jsp";
    }

}