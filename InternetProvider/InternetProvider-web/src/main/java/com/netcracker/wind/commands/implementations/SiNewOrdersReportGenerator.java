package com.netcracker.wind.commands.implementations;

import com.netcracker.wind.commands.ICommand;
import com.netcracker.wind.dao.factory.AbstractFactoryDAO;
import com.netcracker.wind.dao.factory.FactoryCreator;
import com.netcracker.wind.entities.reports.SiOrder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Alexander Kovriga
 */
public class SiNewOrdersReportGenerator implements ICommand {

    public String execute(HttpServletRequest request,
            HttpServletResponse response) {
        HttpSession hs = request.getSession(false);
        AbstractFactoryDAO factoryDAO =
                FactoryCreator.getInstance().getFactory();
        String dateFrom = request.getParameter("validDp1");
        String dateTo = request.getParameter("validDp2");
        List<SiOrder> orders = factoryDAO.createSiNewOrdersDAO().
                findDateFromTo(dateFrom, dateTo);
        hs.setAttribute("title", "New orders per period: " + dateFrom + " - "
                + dateTo);
        hs.setAttribute("orders", orders);
        return "/SiOrders.jsp";
    }
    
}
