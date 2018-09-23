 
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.training.connetor.JdbcUtil,com.training.vo.EmployeeVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html><head>
        <%

            List<EmployeeVO> listemp = JdbcUtil.getEmployees();
            for (int idx = 0; idx < listemp.size(); idx++) {
                System.out.println(">" + ((EmployeeVO) listemp.get(idx)).getId());
            }

            String empId = request.getParameter("ID");
            String empName = request.getParameter("name");
            String phone = request.getParameter("Number");
            String email = request.getParameter("email");
            String address = request.getParameter("Address");
            if (empId != null && empName != null && phone != null && address != null && email != null) {
                int id = Integer.parseInt(empId);
                JdbcUtil.addEmployee(id, empName, phone, email, address);
            }
        %>
        <%
            String i = request.getParameter("ID");
            String mode = request.getParameter("MODE");
            if(mode != null){
                if (i != null && mode.equalsIgnoreCase("del")) {
                    int k = Integer.parseInt(i);
                    JdbcUtil.deleteEmployee(k);
                }
            }
        %>
        <style type="text/css">
            body{
                background-color:white;
            }
            input[type="text"]{
                width: 20%;
                padding: 10px 12px;
                margin: 8px 0;
                box-sizing: border-box;
            }
            input[type="Number"]{
                width: 15%;
                padding: 8px 10px;
                margin: 8px 0;
                box-sizing: border-box;
            }
            button{
                background-color: rgb(0,125,240);
                font-family: "Comic Sans MS", cursive, sans-serif;
                color: white;
                font-size: 16px;
                padding: 10px 12px;
            }
            p{
                text-align: left;
                font-family: "Comic Sans MS", cursive, sans-serif;
                font-size: 20px;

            }
            h1 { 
                font-size: 2em;
                margin-top: 0.67em;
                margin-bottom: 0.67em;
                margin-left: 19.2em;
                margin-right: 0;
                font-weight: bold;
            }

            table {
                border-collapse: collapse;
                background-color: white;
                width: 80%;

            }
            table, th, td {
                border: 1px solid black;
            }
            th,tr {
                text-align: center;
            }
            th,td{padding: 15px;}
            h1 { 
                font-size: 2em;
                margin-top: 0.67em;
                margin-bottom: 0.67em;
                margin-left: 19.2em;
                margin-right: 0;
                font-weight: bold;
            }

        </style>
        <title>First Task</title>
    </head>
    <body id="b"> 
        <h1>Employee Form</h1>
        <br>
        <h2>Please fill in this form.
            <br></h2>
        <form id= "form1" name="form1">
            ID:&emsp;
            <input id="empId" type="Number" name="ID" placeholder="ID...">&emsp;
            Name:&emsp;
            <input id="empName" type="text" name="name" placeholder="Name..."><br><br>
            Email:&emsp;
            <input id="empEmail" type="text" name="email" placeholder="example@email.com">&emsp;
            Phone-Number:&emsp;
            <input id="empPhone" type="Number" name="Number" placeholder="+9621234567">
            <br><br>
            Address:&emsp;
            <input id="empAddress" type="text" name="Address" placeholder="Address...">
            <br><br>
            <button id="addEmp" type="button" form="form1" value="addEmp" onclick="sendDataToInsert()">Add Employee</button>
            <br>
            <br>
            <table width="80%" id="table">
                <tr>
                    <td>Employee ID</td>
                    <td>Employee Name</td>
                    <td>Employee Phone number</td>
                    <td>Employee Email</td>
                    <td>Employee Address</td>
                <tr>
                    <c:forEach items="${JdbcUtil.getEmployees()}" var="k"> 
                    <tr>
                        <td>${k.id}</td>
                        <td>${k.name}</td>
                        <td>${k.phone}</td>
                        <td>${k.email}</td>
                        <td>${k.address}</td>
                        <td>
                            <button id="redirectUpdate" type="button" form="form1" value="" onclick="location.href = 'updateForm.jsp?ID=${k.id}'">Edit 
                            </button>
                            <button id="deleteEmployee" type="button" form="form1" value="" onclick="deleteEmp(${k.id})">Delete Employee
                            </button>
                        </td>
                    </tr>
                </c:forEach>

            </table>

            <script type="text/javascript">
                function  sendDataToInsert() {
                    var id = document.getElementById("empId").value;
                    var name = document.getElementById("empName").value;
                    var empPhone = document.getElementById("empPhone").value;
                    var empEmail = document.getElementById("empEmail").value;
                    var empAddress = document.getElementById("empAddress").value;
                    var url = './index.jsp?';
                    var mode = '&MODE=add';
                    var params = 'empId=' + id + '&empName=' + name + '&empAddress=' + empAddress + '&empPhone=' + empPhone + '&empEmail=' + empEmail;
                    url = url + params+mode;
                    document.getElementById("form1").submit();
                }
                function deleteEmp(id) {
                    var url = ''
                    url = './index.jsp';
                    var params = '?ID=' + id;
                    var mode = '&MODE=del';
                    url = url + params+mode;
                    alert(url);
          window.location = url;          
//                    document.getElementById("empId").value = id;
//                    document.getElementById("form1").action = url;
//                    document.getElementById("form1").submit();
                }
            </script></form>
</html>

