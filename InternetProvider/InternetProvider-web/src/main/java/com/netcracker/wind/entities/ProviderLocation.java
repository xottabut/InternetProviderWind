package com.netcracker.wind.entities;

import com.netcracker.wind.dao.factory.AbstractFactoryDAO;
import com.netcracker.wind.dao.factory.FactoryCreator;
import com.netcracker.wind.dao.implementations.helper.AbstractOracleDAO;
import java.io.Serializable;
import java.util.List;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 *
 * @author Anatolii
 */
public class ProviderLocation implements Serializable {

    private static final long serialVersionUID = -189052472651534830L;
    
    private final AbstractFactoryDAO factoryDAO
            = FactoryCreator.getInstance().getFactory();

    private Integer id;
    private Double posX;
    private Double posY;
    private String address;
    private transient List<Price> pricesList;
    private transient List<ServiceOrder> serviceOrdersList;
    private String name;

    public ProviderLocation() {
    }

    public ProviderLocation(Integer id) {
        this.id = id;
    }

    public ProviderLocation(Integer id, Double posX, Double posY) {
        this.id = id;
        this.posX = posX;
        this.posY = posY;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getPosX() {
        return posX;
    }

    public void setPosX(Double posX) {
        this.posX = posX;
    }

    public Double getPosY() {
        return posY;
    }

    public void setPosY(Double posY) {
        this.posY = posY;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<Price> getPricesList() {
        if (pricesList == null) {
            pricesList = factoryDAO.createPriceDAO().findByProviderLoc(id, 
                    AbstractOracleDAO.DEFAULT_PAGE_NUMBER,
                    AbstractOracleDAO.ALL_RECORDS);
        }
        return pricesList;
    }

    public void setPricesList(List<Price> pricesList) {
        this.pricesList = pricesList;
    }

    public List<ServiceOrder> getServiceOrdersList() {
        if (serviceOrdersList == null) {
            serviceOrdersList = factoryDAO.createServiceOrderDAO().
                    findByProvLoc(id, AbstractOracleDAO.DEFAULT_PAGE_NUMBER,
                    AbstractOracleDAO.ALL_RECORDS);
        }
        return serviceOrdersList;
    }

    public void setServiceOrdersList(List<ServiceOrder> serviceOrdersList) {
        this.serviceOrdersList = serviceOrdersList;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int hashCode() {
        HashCodeBuilder builder = new HashCodeBuilder();
        builder.append(id);
        builder.append(posX);
        builder.append(posY);
        builder.append(address);
        builder.append(pricesList);
        builder.append(serviceOrdersList);
        builder.append(name);
        return builder.toHashCode();
    }

    @Override
    public boolean equals(Object object) {
        if (object == null) {
            return false;
        }
        if (object == this) {
            return true;
        }
        if (!(object instanceof ProviderLocation)) {
            return false;
        }
        ProviderLocation rhs = (ProviderLocation) object;
        EqualsBuilder builder = new EqualsBuilder();
        builder.append(id, rhs.getId());
        builder.append(posX, rhs.getPosX());
        builder.append(posY, rhs.getPosY());
        builder.append(address, rhs.getAddress());
        builder.append(pricesList, rhs.getPricesList());
        builder.append(serviceOrdersList, rhs.getServiceOrdersList());
        builder.append(name, rhs.getName());
        return builder.isEquals();
    }

    @Override
    public String toString() {
        return "com.netcracker.wind.entities.ProviderLocations[ id=" + id + " ]";
    }

}
