package model.dao.jdbc;

import model.dao.connection.DataSource;
import model.dao.interfaces.UsersDAO;
import model.entity.Client;
import model.entity.Entity;
import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.log4j.Logger;
import service.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by tonchief on 05/21/2017.
 */
public class UsersDAOimpl implements UsersDAO {

    private static UsersDAOimpl instance = null;
    private final Logger logger = Logger.getLogger(UsersDAOimpl.class);
    private BasicDataSource pool = DataSource.getInstance().getBds();
    private static final int UID = 1;
    private static final int NAM = 2;
    private static final int EML = 3;
    private static final int PWD = 4;
    private static final int ROL = 5;
    //Checked for fields equality b/w dao and db(v2), 2017-05-27


    public static UsersDAOimpl getInstance() {
        if(instance==null) instance = new UsersDAOimpl();
        return instance;
    }



    /**
     * @param  user
     * @return int : userId obtained from db
     */
    public Integer insert(Object user) {
        //TODO: change new user registration to include new account creation at the time of submitting application

        logger.info("Insert into [clients] - [user] passed by account:" + user);

        try (Connection conn = pool.getConnection();
             PreparedStatement ps = conn.prepareStatement(BUNDLE.getString("clients.insert"), 1);
        ) {
            User client = (User) user;

            ps.setString    (NAM-1, client.getName());
            ps.setString    (EML-1, client.getEmail());
            ps.setString    (PWD-1, client.getPassword());
            ps.setLong      (ROL-1, client.getRole());

            logger.info("PS: " + ps.toString());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                rs.next();  // logger.info(PrintResultSet.getDump(rs));
                Integer newUserId = rs.getInt(1);
                logger.info("New client Registration: ID="+newUserId);
                return newUserId; //rs.getLong(1)
            } finally {
                ps.close();
            }
        } catch (SQLException e) {
            logger.error("SQL exception", e);
        }

        return 0;
    }

    public Integer authenticateUser(String email, String password) {
        logger.info("fetching User with given credentials: " + email + ":*****");
        if(email==null || email.isEmpty() || password==null || password.isEmpty()) return null;
        try (Connection conn = pool.getConnection();
             PreparedStatement ps = conn.prepareStatement(BUNDLE.getString("clients.checkLoginPwd"),0);
        ){
            logger.info("got conn.");
            ps.setString(1, email);
            ps.setString(2, password);
            logger.info("Trying PS:" + ps);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                Integer userId = rs.getInt(1);
                rs.close();
                return userId;
            } catch (SQLException e) {
                logger.error("SQLex." + e.toString());
            }
        } catch (SQLException e) {
            logger.error("SQL exception.", e);
        } catch (Exception e) {
            logger.error("Fatal General Exception.", e);
        }
        return null;
    }

    public List<Client> getUsersByRole(Long role){

        List<Client> resultList = new ArrayList<>();
        logger.info("fetching Client Entities for RoleId:" + role);
        try (Connection conn = pool.getConnection();
             PreparedStatement ps = conn.prepareStatement(BUNDLE.getString("clients.getByRole"), 0);
        ){
            logger.info("Got connection.");
            ps.setLong(1, role);

            logger.info("Trying PS:" + ps);

            try (ResultSet rs = ps.executeQuery()) {
//                logger.info(PrintResultSet.getDump(rs));
                int i=1;
                while(rs.next()) {
/*                    logger.warn(i++);
                    logger.info("\t1\t"+ rs.getString(UID));
                    logger.info("\t2\t"+ rs.getInt(UID));
                    logger.info("\t3\t"+ rs.getString(NAM));
                    logger.info("\t4\t"+ rs.getString(EML));
                    logger.info( rs.getLong(ROL));*/

                    Client cl= new Client( rs.getInt(UID), rs.getString(NAM),
                            rs.getString(EML), rs.getInt(ROL) );
                    resultList.add(cl);
                }
                rs.close();
                return resultList;
            } catch (SQLException e) {
                logger.error("SQLex." + e.toString());
            }
        } catch (SQLException e) {
            logger.error("SQL exception.", e);
        } catch (Exception e) {
            logger.error("Major General Exception.", e);
        }
        return null;
    }









    public boolean update(int id, Entity data) {
        return false;
    }

    public boolean delete(long id) {
        return false;
    }

    public Entity getById(int id) {
        return null;
    }


}
