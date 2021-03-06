package com.netcracker.wind.commands.implementations.csedashboard;

import com.netcracker.wind.annotations.RolesAllowed;
import com.netcracker.wind.commands.ICommand;
import com.netcracker.wind.dao.implementations.helper.AbstractOracleDAO;
import com.netcracker.wind.entities.Role;
import com.netcracker.wind.manager.ConfigurationManager;
import com.netcracker.wind.paging.IExtendedPaginatedList;
import com.netcracker.wind.paging.SIUserPaginationList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * *this command helps to find all service instances for 
 * particular users and show them on CSE dashboard
 * @author Oksana
 */
@RolesAllowed(roles = Role.Roles.CustomerSupportEngineer)
public class CSEgetServiceInstanceForUser implements ICommand {

    private static final String SI = "service_instances";
    private static final String CUSTOMER_ID = "customer_id";

    public String execute(HttpServletRequest request,
            HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        int customerId = Integer.parseInt(request.getParameter(CUSTOMER_ID));
        IExtendedPaginatedList paginatedList = new SIUserPaginationList(
                AbstractOracleDAO.DEFAULT_PAGE_SIZE).setPerformer(customerId);
        paginatedList.setRequest(request);
        session.setAttribute(SI, paginatedList);
        return manager.getProperty(
                ConfigurationManager.PAGE_CSE_SERVICE_INSTANCES);

    }

}
