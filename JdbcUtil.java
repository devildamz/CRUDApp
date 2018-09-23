package com.training.connetor;

import com.training.vo.EmployeeVO;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.ManagedBean;

@ManagedBean
public class JdbcUtil {

    private final static String connectionStr = "jdbc:mysql://localhost:3306/trainingdb";
    private final static String userName = "root";
    private final static String password = "123456";

    public static Connection conDB() throws SQLException, ClassNotFoundException {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException ex) {
            Logger.getLogger(JdbcUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(JdbcUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(connectionStr, userName, password);
    }
    private static Long EMP_ID;
    private static String EMP_Name, EMP_Address, EMP_Email, EMP_Phone_Number;

    public static Long getEMP_ID() {
        return EMP_ID;
    }

    public static void setEMP_ID(Long EMP_ID) {
        JdbcUtil.EMP_ID = EMP_ID;
    }

    public static String getEMP_Name() {
        return EMP_Name;
    }

    public static void setEMP_Name(String EMP_Name) {
        JdbcUtil.EMP_Name = EMP_Name;
    }

    public static String getEMP_Address() {
        return EMP_Address;
    }

    public static void setEMP_Address(String EMP_Address) {
        JdbcUtil.EMP_Address = EMP_Address;
    }

    public static String getEMP_Email() {
        return EMP_Email;
    }

    public static void setEMP_Email(String EMP_Email) {
        JdbcUtil.EMP_Email = EMP_Email;
    }

    public static String getEMP_Phone_Number() {
        return EMP_Phone_Number;
    }

    public static void setEMP_Phone_Number(String EMP_Phone_Number) {
        JdbcUtil.EMP_Phone_Number = EMP_Phone_Number;
    }

    public JdbcUtil() {
    }

    public static void addEmployee(int i, String n, String p, String e, String a) throws SQLException {

        Connection c = null;
        PreparedStatement s = null;
        try {
            int updatequery = 0;
            c = JdbcUtil.conDB();
            String sql = "insert into employee(EMP_ID, EMP_NAME, EMP_ADDRESS, EMP_PHONE_NUMBER, EMP_EMAIL) values(?,?,?,?,?);";
            s = c.prepareStatement(sql);
            s.setInt(1, i);
            s.setString(2, n);
            s.setString(3, p);
            s.setString(4, e);
            s.setString(5, a);
            updatequery = s.executeUpdate();
        } catch (Exception ex) {
            System.out.println("<<>>");
            ex.printStackTrace();
        } finally {
            s.close();
            c.close();
        }
    }

    public static void deleteEmployee(int i) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = null;
        Connection c = null;
        try {
            String sql = " delete from employee where EMP_ID = ? ";
            c = JdbcUtil.conDB();
            ps = c.prepareStatement(sql);
            ps.setInt(1, i);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(JdbcUtil.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ps.close();
            c.close();
        }

    }

    public static List<EmployeeVO> getEmployees() throws SQLException, ClassNotFoundException {
        List<EmployeeVO> emp = new ArrayList<>();
        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            JdbcUtil j = new JdbcUtil();
            c = j.conDB();
            ps = null;
            String sql = "Select * from employee";
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                EmployeeVO vo = new EmployeeVO();
                vo.setId(rs.getLong("EMP_ID"));
                vo.setName(rs.getString("EMP_NAME"));
                vo.setAddress(rs.getString("EMP_ADDRESS"));
                vo.setEmail(rs.getString("EMP_EMAIL"));
                vo.setPhone(rs.getString("EMP_PHONE_NUMBER"));
                emp.add(vo);
//                
//                JdbcUtil j = new JdbcUtil();
//                j.addEmployee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
            }
        } catch (SQLException ex) {
            Logger.getLogger(JdbcUtil.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            rs.close();
            ps.close();
            c.close();
        }
        return emp;
    }
    
    
      public static EmployeeVO getEmployeeById(Long id) throws SQLException, ClassNotFoundException {
        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            JdbcUtil j = new JdbcUtil();
            c = j.conDB();
            String sql = "Select * from employee where EMP_ID=?;";
            ps = c.prepareStatement(sql);
             ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                EmployeeVO vo = new EmployeeVO();
                vo.setId(rs.getLong("EMP_ID"));
                vo.setName(rs.getString("EMP_NAME"));
                vo.setAddress(rs.getString("EMP_ADDRESS"));
                vo.setEmail(rs.getString("EMP_EMAIL"));
                vo.setPhone(rs.getString("EMP_PHONE_NUMBER"));
                return vo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(JdbcUtil.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            rs.close();
            ps.close();
            c.close();
        }
        return null;
    }


    public static void updateEmployee(String n, String a, String e, String p, Long id) throws SQLException, ClassNotFoundException {
        JdbcUtil j = new JdbcUtil();
        Connection c = null;
        PreparedStatement ps = null;
        try {
            c = j.conDB();
            String query = "update employee set EMP_NAME=?,EMP_EMAIL=?, EMP_PHONE_NUMBER=?,EMP_ADDRESS=? where EMP_ID=?";
            ps = c.prepareStatement(query);
            ps.setString(1, n);
            ps.setString(2, e);
            ps.setString(3, a);
            ps.setString(4, p);
            ps.setLong(5, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        finally
        {
            ps.close();
            c.close();
        }
    }
    
}
