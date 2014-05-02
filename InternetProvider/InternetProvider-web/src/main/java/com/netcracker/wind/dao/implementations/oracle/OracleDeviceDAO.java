package com.netcracker.wind.dao.implementations.oracle;

import com.netcracker.wind.connection.ConnectionPool;
import com.netcracker.wind.dao.implementations.helper.AbstractOracleDAO;
import com.netcracker.wind.dao.interfaces.IDeviceDAO;
import com.netcracker.wind.entities.Device;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author Oksana
 */
public class OracleDeviceDAO extends AbstractOracleDAO implements IDeviceDAO {

    private final ConnectionPool connectionPool = ConnectionPool.getInstance();
    private static final Logger LOGGER
            = Logger.getLogger(OracleDeviceDAO.class.getName());

    private static final String DELETE = "DELETE FROM DEVICES WHERE ID = ?";
    private static final String INSERT = "INSERT INTO DEVICES (NAME) "
            + "VALUES (?)";
    private static final String UPDATE = "UPDATE DEVICES SET NAME = ?, "
            + "WHERE ID = ?";
    private static final String SELECT = "SELECT * FROM DEVICES ";
    private static final String ID = "ID";
    private static final String NAME = "NAME";
    // private static final String UPDATE = "";

    /**
     *
     * @param device
     */
    public void add(Device device) {
        Connection connection = null;
        PreparedStatement stat = null;
        try {
            connection = connectionPool.getConnection();
            stat = connection.prepareStatement(INSERT,
                    PreparedStatement.RETURN_GENERATED_KEYS);
            stat.setString(1, device.getName());
            stat.executeUpdate();
            ResultSet insertedResultSet = stat.getGeneratedKeys();
            if (insertedResultSet != null && insertedResultSet.next()) {
                String s = insertedResultSet.getString(1);
                PreparedStatement ps = connection.prepareStatement("SELECT * "
                        + "FROM root.devices WHERE rowid = ?");
                ps.setObject(1, s);
                ResultSet rs = ps.executeQuery();
                rs.next();
                device.setId(rs.getInt(ID));
            }
        } catch (SQLException ex) {
            LOGGER.error(null, ex);
        } finally {
            try {
                if (stat != null) {
                    stat.close();
                }
            } catch (SQLException ex) {
                LOGGER.error(null, ex);
            }
            connectionPool.close(connection);
        }
    }

    /**
     *
     * @param idDevice
     */
    public void delete(int idDevice) {
        super.delete(DELETE, idDevice);
    }

    /**
     *
     * @param idDevice
     * @return
     */
    public Device findByID(int idDevice) {
        List<Device> devices = findWhere("WHERE ID = ?",
                new Object[]{idDevice});
        if (devices.isEmpty()) {
            return null;
        } else {
            return devices.get(0);
        }
    }

    public Device findByName(String DeviceName) {
        List<Device> devices = findWhere("WHERE NAME = ?",
                new Object[]{DeviceName});
        if (devices.isEmpty()) {
            return null;
        } else {
            return devices.get(0);
        }
    }

    /**
     *
     * @param where SQL statement where for searching by different parameters
     * @param param parameters by which search will be formed
     * @return list of found devices
     */
    @Override
    protected List<Device> findWhere(String where, Object[] param) {
        return super.findWhere(SELECT + where, param);
    }

    /**
     *
     * @param rs result return from database
     * @return list of founded devices
     */
    protected List<Device> parseResult(ResultSet rs) {
        List<Device> devices = new ArrayList<Device>();
        try {
            while (rs.next()) {
                Device device = new Device();
                int id = rs.getInt(ID);
                device.setId(id);
                device.setName(rs.getString(NAME));
                devices.add(device);
            }
        } catch (SQLException ex) {
            LOGGER.error(null, ex);
        }
        return devices;
    }

    public List<Device> findAll() {
        return findWhere("", new Object[]{});
    }

    public void update(Device device) {
        Connection con = null;
        PreparedStatement stat = null;
        try {
            con = connectionPool.getConnection();
            stat = con.prepareStatement(UPDATE);
            stat.setString(1, device.getName());
            stat.setInt(2, device.getId());
            stat.executeUpdate();
        } catch (SQLException ex) {
            LOGGER.error(null, ex);
        } finally {

            try {
                if (stat != null) {
                    stat.close();
                }
            } catch (SQLException ex) {
                LOGGER.error(null, ex);
            }
            connectionPool.close(con);
        }
    }

}
