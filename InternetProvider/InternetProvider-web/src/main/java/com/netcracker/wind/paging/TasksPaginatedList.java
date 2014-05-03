package com.netcracker.wind.paging;

import com.netcracker.wind.dao.factory.FactoryCreator;
import com.netcracker.wind.dao.interfaces.ITaskDAO;
import com.netcracker.wind.entities.Role;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Alexander Kovriga
 */
public class TasksPaginatedList extends AbstractPaginatedList {
    
    private final ITaskDAO taskDAO
            = FactoryCreator.getInstance().getFactory().createTaskDAO();

    public TasksPaginatedList(HttpServletRequest request, int pageSize) {
        super(request, pageSize);
    }

    @Override
    public List getList() {
        return taskDAO.findByGroup(Role.PE_GROUPR_ID, pageNumber, pageSize);
    }

    @Override
    public int getFullListSize() {
        return taskDAO.getRows();
    }
    
}