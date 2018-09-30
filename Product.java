package com.training.jsf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean(name = "obj")
@SessionScoped
public class Product {

    private String name;
    private int qty;
    private Long price;
    private final static String user_name = "root";
    private final static String password = "123456";
    private final static String conUrl = "jdbc:mysql://localhost:3306/trainingdb";
    
    private String msg;

    public static Connection conDB() throws SQLException, ClassNotFoundException {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(conUrl, user_name, password);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
    
    public String add(){
        System.out.println("Success!! Product Added");
        System.out.println(name+ ""+ qty+ ""+ price);
        this.msg = "success";
    return "/success?faces-redirect=true";
    }
}
