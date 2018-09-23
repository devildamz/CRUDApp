<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.training.connetor.JdbcUtil,com.training.vo.EmployeeVO"%>
<!DOCTYPE html>
<%

    String empId = request.getParameter("ID");
    Long id = 0L;
    if (empId != null) {
        id = Long.parseLong(empId);
    }
    EmployeeVO empVO = JdbcUtil.getEmployeeById(id);
    String empName = request.getParameter("name");
    String phone = request.getParameter("Number");
    String email = request.getParameter("email");
    String address = request.getParameter("Address");
    if (empId != null && empName != null && phone != null && address != null && email != null) {
        JdbcUtil.updateEmployee(empName, address, email, phone, id);

    }

%>

<html>
    <head><title> Update Form</title>
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

        </style></head>   
    <body><h1>Employee Form</h1>
        <br>
        <form id= "form3" name="form1">

            ID:&emsp;
            <input id="empId" type="Number" name="ID" readonly="readonly" placeholder="ID..." value="<%=empVO.getId()%>">&emsp;

            Name:&emsp;
            <input id="empName" type="text" name="name" value="<%=empVO.getName()%>" placeholder="Name..."><br><br>
            Email:&emsp;
            <input id="empEmail" type="text" value="<%=empVO.getEmail()%>" name="email" placeholder="example@email.com">&emsp;
            Phone-Number:&emsp;
            <input id="empPhone" value="<%=empVO.getPhone()%>" type="text" name="Number" placeholder="+9621234567">
            <br><br>
            Address:&emsp;
            <input id="empAddress" value="<%=empVO.getAddress()%>" type="text" name="Address" placeholder="Address...">
            <br><br>
            <button id="updateEmp" type="button" form="form3" value="updateEmp" onclick="updateEmployee()">Update Employee</button>
            <button id ="homePage" type="button" onclick="location.href = 'index.jsp'">back to Homepage
            </button>  
            <br>
            <br>

            <script type="text/javascript">
                function  updateEmployee() {
                    var id = document.getElementById("empId").value;
                    var name = document.getElementById("empName").value;
                    var empPhone = document.getElementById("empPhone").value;
                    var empEmail = document.getElementById("empEmail").value;
                    var empAddress = document.getElementById("empAddress").value;
                    var url = './updateForm.jsp?';
                    var params = 'empName=' + name + '&empAddress=' + empAddress + '&empPhone=' + empPhone + '&empEmail=' + empEmail + '&empId' + id;
//                    var url= url+params;
//                    window.location = url+params;
                    document.getElementById("form3").action = url + params;
                    document.getElementById("form3").submit();
                }
            </script>
    </body>


</html>

